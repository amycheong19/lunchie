//
//  UIView+Extension.swift
//  Lunchie
//
//  Created by Amy Cheong on 20/5/19.
//  Copyright © 2019 Amy Cheong. All rights reserved.
//

import UIKit

extension UIView {
    // To be able to present alerts from subview
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if parentResponder is UIViewController {
                return parentResponder as? UIViewController
            }
        }
        return nil
    }
}
