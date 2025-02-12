//
//  BLToolVC.swift
//  bitlong
//

//

import UIKit

class BLToolVC: BLBaseVC,ToolItemClickDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func initUI(){
        self.view.addSubview(itemsView)
        itemsView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(TopHeight)
            make?.left.right().mas_equalTo()(0)
            make?.height.mas_greaterThanOrEqualTo()(itemsView.frame.height)
        }
    }
    
    lazy var itemsView : BLToolItemsView = {
        var view = BLToolItemsView.init()
        view.delegate = self
        
        return view
    }()
    
    //ToolItemClickDelegate
    func itemsClicked(sender: UIButton) {
        switch sender.tag {
        case 100:
            break
        case 101:
            break
        case 102:
            break
        case 103:
            self.pushBaseVCStr(vcStr: "BLBatchTransferVC", animated: true)
            break
        case 104:
            break
        case 105:
            self.pushBaseVCStr(vcStr: "BLDestructionVC", animated: true)
            break
        case 106://IDO
            break
        default:
            break
        }
    }
    
    override func `deinit`() {
        super.`deinit`()
    }
}
