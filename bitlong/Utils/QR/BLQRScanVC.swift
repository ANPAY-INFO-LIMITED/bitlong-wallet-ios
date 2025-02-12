//
//  BLQRScanVC.swift
//  bitlong
//

//

import UIKit
import AVFoundation

typealias QRScanBlock = (_ qrStr : String) -> ()

class BLQRScanVC: BLBaseVC,AVCaptureMetadataOutputObjectsDelegate {

    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var callBack : QRScanBlock?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            return
        }
        
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        
        DispatchQueue.global().async { [weak self] in
            self?.captureSession.startRunning()
        }
        
        addMaskToScannerView()
    }
    
    var scanningLine: UIView!
    func addMaskToScannerView() {
        
        let squareSize: CGFloat = 300
        let squareX = (view.bounds.width - squareSize) / 2
        let squareY = (view.bounds.height - squareSize) / 2

        
        let topMask = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: squareY))
        let bottomMask = UIView(frame: CGRect(x: 0, y: squareY + squareSize, width: view.bounds.width, height: view.bounds.height - (squareY + squareSize)))
        let leftMask = UIView(frame: CGRect(x: 0, y: squareY, width: squareX, height: squareSize))
        let rightMask = UIView(frame: CGRect(x: squareX + squareSize, y: squareY, width: view.bounds.width - (squareX + squareSize), height: squareSize))

        
        [topMask, bottomMask, leftMask, rightMask].forEach {
            $0.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            view.addSubview($0)
        }

        
        let squareFrame = UIView(frame: CGRect(x: squareX, y: squareY, width: squareSize, height: squareSize))
        squareFrame.layer.borderColor = UIColor.green.cgColor
        squareFrame.layer.borderWidth = 3
        squareFrame.backgroundColor = .clear
        view.addSubview(squareFrame)
        
        
        scanningLine = UIView(frame: CGRect(x: squareX, y: squareY, width: squareSize, height: 2))
        scanningLine.backgroundColor = UIColor.red
        view.addSubview(scanningLine)

        
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.fromValue = squareY
        animation.toValue = squareY + squareSize
        animation.duration = 2
        animation.repeatCount = .infinity
        scanningLine.layer.add(animation, forKey: "scanning")
    }

    
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
        
        dismiss(animated: true)
    }
    
    func found(code: String) {
        
        if callBack != nil{
            callBack!(code)
        }
        self.back()
    }
}
