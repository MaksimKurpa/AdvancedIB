//
//  FirstView.swift
//  AdvancedIB
//
//  Created by Maksim Kurpa on 8/13/18.
//  Copyright © 2018 Maksim Kurpa. All rights reserved.
//

import UIKit

@IBDesignable class FirstView: NibControl {
    @IBOutlet weak var _avatarImageView: UIImageView!
    @IBOutlet weak var _nameLabel: UILabel!
    
    @IBOutlet weak var _detailButton: UIButton!
    @IBOutlet weak var _avatarButton: UIButton!
    
    override func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControlEvents) {
        _detailButton.addTarget(target, action: action, for: controlEvents)
        _avatarButton.addTarget(target, action: action, for: controlEvents)
    }
}
