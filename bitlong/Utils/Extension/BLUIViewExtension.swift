//
//  BLUIViewExtension.swift
//  bitlong
//

//

import UIKit

extension UIView {
    func removeAllSubviews() {
        _ = self.subviews.map {
            $0.removeFromSuperview()
        }
    }
}
