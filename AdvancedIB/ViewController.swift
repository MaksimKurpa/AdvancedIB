//
//  ViewController.swift
//  AdvancedIB
//
//  Created by Maksim Kurpa on 7/26/18.
//  Copyright © 2018 Maksim Kurpa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var _label: UILabel!
    @IBOutlet weak var _squareSideConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override public var traitCollection: UITraitCollection {

        let wC = UITraitCollection(horizontalSizeClass: .compact)
        let wR = UITraitCollection(horizontalSizeClass: .regular)
        let hC = UITraitCollection(verticalSizeClass: .compact)
        let hR = UITraitCollection(verticalSizeClass: .regular)
        
            if Device.IS_4_INCHES() {
                return UITraitCollection(traitsFrom: [wC])
            } else if Device.IS_4_7_INCHES() {
                return UITraitCollection(traitsFrom: [wR])
            } else if Device.IS_5_5_INCHES() {
                return UITraitCollection(traitsFrom: [hR])
            } else if Device.IS_5_8_INCHES() {
                return UITraitCollection(traitsFrom: [hC])
            } else if Device.IS_9_7_INCHES() {
                return UITraitCollection(traitsFrom: [wC, hC])
            } else if Device.IS_12_9_INCHES() {
                return UITraitCollection(traitsFrom: [wR, hR])
            }
        
        return super.traitCollection
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        _label.text = "Size is: \(_squareSideConstraint.constant)"
    }

    
}

