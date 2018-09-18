//
//  NSLayoutConstrait.swift
//  AdvancedIB
//
//  Created by Maksim Kurpa on 9/14/18.
//  Copyright © 2018 Maksim Kurpa. All rights reserved.
//

import UIKit


fileprivate enum AssociatedKeys: String {
    case inch35_value = "NSLayoutConstraint.inch35"
    case inch40_value = "NSLayoutConstraint.inch40"
    case inch47_value = "NSLayoutConstraint.inch47"
    case inch55_value = "NSLayoutConstraint.inch55"
    case inch79_value = "NSLayoutConstraint.inch79"
    case inch97_value = "NSLayoutConstraint.inch97"
    case inch12_9_value = "NSLayoutConstraint.inch12_9"
}


/// - parameter inches_3_5:    Representing screens for iPhone 4, 4S
/// - parameter inches_4_0:    Representing screens for iPhone 5, 5S
/// - parameter inches_4_7:    Screens for iPhone 6, 6S
/// - parameter inches_5_5:    Screens for iPhone 6Plus
/// - parameter inches_7_9:    Screens for iPad Mini
/// - parameter inches_9_7:    Screens for iPad
/// - parameter inches_12_9:   Screens for iPad Pro

extension NSLayoutConstraint {
    
    struct AssociatedKeys {
        static var constant_inch40_key = "constant_inch40_value"
    }
    
    
    @IBInspectable
    var inch40: CGFloat {
        get {
            return self.constant
        }
        set {
            if Device.IS_4_INCHES() {
                self.constant = newValue
            }
        }
    }
    
    @IBInspectable
    var inch47: CGFloat {
        get {
            return self.constant
        }
        set {
            if Device.IS_4_7_INCHES() {
                self.constant = newValue
            }
        }
    }
    
    @IBInspectable
    var inch55: CGFloat {
        get {
            return self.constant
        }
        set {
            if Device.IS_5_5_INCHES() {
                self.constant = newValue
            }
        }
    }
//    @IBInspectable
//    var constant_inch40: CGFloat {
//
//        get {
//            if let value = objc_getAssociatedObject(self, &AssociatedKeys.constant_inch40_key) as? NSNumber {
//                return CGFloat(value.doubleValue)
//            }
//            else {
//                return 0
//            }
//        }
//        set(newValue) {
//            let number = NSNumber(value: Double(newValue)).objCType
//            objc_setAssociatedObject(self, &AssociatedKeys.constant_inch40_key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            if Device.IS_4_INCHES() {
//                self.constant = constant_inch40
//            }
//        }
////        didSet {
////            if Device.IS_4_INCHES() {
////                self.constant = constant_inch40
////            }
////        }
//    }

    
}
