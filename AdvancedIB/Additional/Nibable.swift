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
        
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|",
//                                                      options: [],
//                                                      metrics: nil,
//                                                      views: ["childView": view]))
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[childView]|",
//                                                      options: [],
//                                                      metrics: nil,
//                                                      views: ["childView": view]))
    }
}

private func swapFirstItemsOfConstraintsDefinedInThisView(_ superview: UIView, betweenItem item1: UIView, andItem item2: UIView)
{
    var constraintsNew_item1: [NSLayoutConstraint]  = []
    var constraintsInner: [NSLayoutConstraint]  = []
    
    for constraint in superview.constraints
    {
        if (constraint.firstItem === item2)
        {
            constraintsNew_item1.append(NSLayoutConstraint(item: item1, attribute: constraint.firstAttribute, relatedBy: constraint.relation, toItem: constraint.secondItem, attribute: constraint.secondAttribute, multiplier: constraint.multiplier, constant: constraint.constant))
        }
        else if (constraint.secondItem === item2)
        {
            constraintsNew_item1.append(NSLayoutConstraint(item: constraint.firstItem, attribute: constraint.secondAttribute, relatedBy: constraint.relation, toItem: item1, attribute: constraint.secondAttribute, multiplier: constraint.multiplier, constant: constraint.constant))
        }
    }
    
    for constraint in item2.constraints {
        if (constraint.firstItem === item2)
        {
            constraintsInner.append(NSLayoutConstraint(item: item1, attribute: constraint.firstAttribute, relatedBy: constraint.relation, toItem: constraint.secondItem, attribute: constraint.secondAttribute, multiplier: constraint.multiplier, constant: constraint.constant))
        }
        else if (constraint.secondItem === item2)
        {
            constraintsInner.append(NSLayoutConstraint(item: item1, attribute: constraint.secondAttribute, relatedBy: constraint.relation, toItem: constraint.secondItem, attribute: constraint.secondAttribute, multiplier: constraint.multiplier, constant: constraint.constant))
        }
    }
    
//    superview.removeConstraints(constraintsToRemove);
    superview.addConstraints(constraintsNew_item1);
    item1.addConstraints(constraintsInner);
}

func copyConstraints(fromView sourceView: UIView, toView destView: UIView) {
    guard let sourceViewSuperview = sourceView.superview else {
        return
    }
    for constraint in sourceViewSuperview.constraints {
        if constraint.firstItem as? UIView == sourceView {
            sourceViewSuperview.addConstraint(NSLayoutConstraint(item: destView, attribute: constraint.firstAttribute, relatedBy: constraint.relation, toItem: constraint.secondItem, attribute: constraint.secondAttribute, multiplier: constraint.multiplier, constant: constraint.constant))
        } else if constraint.secondItem as? UIView == sourceView {
            sourceViewSuperview.addConstraint(NSLayoutConstraint(item: constraint.firstItem, attribute: constraint.firstAttribute, relatedBy: constraint.relation, toItem: destView, attribute: constraint.secondAttribute, multiplier: constraint.multiplier, constant: constraint.constant))
        }
    }
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
        
        swapFirstItemsOfConstraintsDefinedInThisView(self.superview!, betweenItem: nib, andItem: self)
//        copyConstraints(fromView: self, toView: nib)
        self.removeFromSuperview()
    }
    override func didMoveToSuperview() {
        
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
