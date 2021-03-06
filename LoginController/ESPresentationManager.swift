//
//  ESPresentationManager.swift
//  ES_UIPresentationController_Demo
//
//  Created by Eric Stroh on 2/24/15.
//  Copyright (c) 2015 com.strohtennis. All rights reserved.
//

import UIKit

public protocol ESModalViewDelegate{
    func modalPresentationSize()->CGSize
}

public class ESPresentationManager: NSObject, UIViewControllerTransitioningDelegate {
    
    class var sharedInstance: ESPresentationManager {
        struct Static {
            static var instance: ESPresentationManager?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token){
            Static.instance = ESPresentationManager()
        }
        
        return Static.instance!
    }
    
    var presentationController:ESPresentationController?
    
    //method was introduced in iOS8
    public func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        presentationController = ESPresentationController(presentedViewController: presented, presentingViewController: source)
        return presentationController;
    }
    
    public func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ESPresentationAnimator()
    }
    
    public func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ESDismissAnimator()
    }
}
