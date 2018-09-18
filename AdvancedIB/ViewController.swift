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
        
        let traitSizeClass: UITraitCollection
        if Device.IS_4_INCHES() {
            traitSizeClass = UITraitCollection(traitsFrom: [wC])
        } else if Device.IS_4_7_INCHES() {
            traitSizeClass = UITraitCollection(traitsFrom: [wR])
        } else if Device.IS_5_5_INCHES() {
            traitSizeClass = UITraitCollection(traitsFrom: [hR])
        } else if Device.IS_5_8_INCHES() {
            traitSizeClass = UITraitCollection(traitsFrom: [hC])
        } else if Device.IS_9_7_INCHES() {
            traitSizeClass = UITraitCollection(traitsFrom: [wC, hC])
        } else if Device.IS_12_9_INCHES() {
            traitSizeClass = UITraitCollection(traitsFrom: [wR, hR])
        } else {
            return super.traitCollection
        }
        
        return UITraitCollection(traitsFrom: [super.traitCollection, traitSizeClass])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        _label.text = "Size is: \(_squareSideConstraint.constant)"
    }

    @IBAction func goToProfile(_ sender: Any) {
        
    }
    
}

