//
//  Nibable.swift
//  AdvancedIB
//
//  Created by Maksim Kurpa on 8/13/18.
//  Copyright © 2018 Maksim Kurpa. All rights reserved.
//

import UIKit

protocol Nibable where Self: UIView {}

private extension Nibable where Self: UIView {
    
    private func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    func nibSetup() {
        backgroundColor = UIColor.clear
        let view = loadNib()
        view.frame = bounds
        insertSubview(view, at: 0)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": view]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": view]))
    }
}

private func copyConstraint(in superview: UIView,_ fromView: UIView, _ toView: UIView)
{
    var constraintsOuter: [NSLayoutConstraint]  = []
    var constraintsInner: [NSLayoutConstraint]  = []
    
    for constraint in superview.constraints
    {
        if (constraint.firstItem === fromView)
        {
            constraintsOuter.append(NSLayoutConstraint(item: toView, attribute: constraint.firstAttribute, relatedBy: constraint.relation, toItem: constraint.secondItem, attribute: constraint.secondAttribute, multiplier: constraint.multiplier, constant: constraint.constant))
        }
        else if (constraint.secondItem === fromView)
        {
            constraintsOuter.append(NSLayoutConstraint(item: constraint.firstItem!, attribute: constraint.secondAttribute, relatedBy: constraint.relation, toItem: toView, attribute: constraint.secondAttribute, multiplier: constraint.multiplier, constant: constraint.constant))
        }
    }
    
    for constraint in fromView.constraints {
        if (constraint.firstItem === fromView)
        {
            constraintsInner.append(NSLayoutConstraint(item: toView, attribute: constraint.firstAttribute, relatedBy: constraint.relation, toItem: constraint.secondItem, attribute: constraint.secondAttribute, multiplier: constraint.multiplier, constant: constraint.constant))
        }
        else if (constraint.secondItem === fromView)
        {
            constraintsInner.append(NSLayoutConstraint(item: toView, attribute: constraint.secondAttribute, relatedBy: constraint.relation, toItem: constraint.secondItem, attribute: constraint.secondAttribute, multiplier: constraint.multiplier, constant: constraint.constant))
        }
    }
    
    superview.addConstraints(constraintsOuter);
    toView.addConstraints(constraintsInner);
}

class NibView: UIView, Nibable {
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let nib = self.subviews.first else { return }
        nib.removeFromSuperview()
        self.superview?.addSubview(nib)
//        let constraints = self.constraints
        
        copyConstraint(in: self.superview!, self, nib)

        self.removeFromSuperview()
    }
    override func didMoveToSuperview() {
        
    }
    
    deinit {
        NSLog("asd")
        
        NSLog("asd")
    }
}

class NibControl: UIControl, Nibable {
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
}
