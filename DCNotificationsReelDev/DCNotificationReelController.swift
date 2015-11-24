//
//  DCNotificationReelController.swift
//  DCNotificationsReelDev
//
//  Created by Paolo Longato on 13/11/2015.
//  Copyright © 2015 Paolo Longato. All rights reserved.
//

enum DCNotificationReelPosition {
    case Left
    case Right
    case Center
    
    func getConstant() -> Double {
        switch self {
            case Left: return 0
            case Right: return 1
            case Center: return 0.5
        }
    }
}

private struct BoxedUIViewController {
    var controller: UIViewController
    var height: Double
}

import UIKit

class DCNotificationReelController : UIViewController {
    
    var width: Double = 1
    private var height: Double = 1
    var insets: Double = 8
    var position: DCNotificationReelPosition = .Center
    var flowFromBottom = false
    var statusBarOffset = true
    private var controllers: [BoxedUIViewController] = []
    private var out = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.clipsToBounds = true
    }
    
    override func viewDidLayoutSubviews() {
        self.view.frame = makeFrame()
        _ = controllers.map({ $0.controller.view.frame = makeNotificationViewFrame($0.height)
        })
        super.viewDidLayoutSubviews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Helper functions
    
    private func makeFrame() -> CGRect {
        let statusBarSize = Double(UIApplication.sharedApplication().statusBarFrame.height)
        var parentViewFrame:CGRect
        if let tv = self.view.superview?.frame {
            parentViewFrame = tv
        } else {
            parentViewFrame = UIScreen.mainScreen().bounds
        }
        let w = (Double(parentViewFrame.width) - 2 * insets * width) * width
        var h = (Double(parentViewFrame.height) - 2 * insets * height) * height - statusBarSize * Double(statusBarOffset)
        if let newH = controllers.first?.height {
            h = newH
        }
        let x = (Double(parentViewFrame.width) - w) * position.getConstant() + insets - insets * position.getConstant() * 2
        var y: Double
        if flowFromBottom {
            y = Double(parentViewFrame.height) - insets - h
        } else {
            y = insets + statusBarSize * Double(statusBarOffset)
        }
        return CGRect(origin: CGPoint(x: x, y: y), size: CGSize(width: w, height: h))
    }
    
    private func makeNotificationViewFrame(height: Double) -> CGRect {
        let w = Double(self.view.frame.width) * width
        let h = Double(height)
        return CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: w, height: h))
    }
    
    private func makeOffScreenNotificationViewFrame(height: Double) -> CGRect {
        var temporatyFrame = makeNotificationViewFrame(height)
        var sign: CGFloat = -1
        if flowFromBottom { sign = 1 }
        temporatyFrame.origin.y += sign * temporatyFrame.size.height
        return temporatyFrame
    }
    
    // APIs
    
    func addTo(viewController: UIViewController) {
        viewController.addChildViewController(self)
        viewController.view.addSubview(self.view)
        viewController.view.sendSubviewToBack(self.view)
    }
    
    func slideOutAndRemove(vc: UIViewController) {
        var newFrame = vc.view.frame
        newFrame.origin.y = vc.view.frame.origin.y - vc.view.frame.height
        UIView.animateWithDuration(0.5,
            animations: { vc.view.frame = newFrame },
            completion: { (finished:Bool) -> Void in self.remove(vc); self.slideInNext() })
    }
    
    func remove(vc: UIViewController) {
        vc.view.removeFromSuperview()
        vc.removeFromParentViewController()
        controllers = controllers.filter({$0.controller !== vc})
        self.parentViewController?.view.sendSubviewToBack(self.view)
        self.out = false
    }
    
    func showNext() {
        if let notificationViewController = controllers.first?.controller {
            if !self.out {
                self.addChildViewController(notificationViewController)
                self.view.addSubview(notificationViewController.view)
                self.parentViewController?.view.bringSubviewToFront(self.view)
                self.out = true
            }
        }
    }
    
    func slideInNext() {
        if !self.out {
            if let notificationViewController = controllers.first?.controller {
                notificationViewController.view.frame = makeOffScreenNotificationViewFrame(controllers.first!.height)
                self.addChildViewController(notificationViewController)
                self.view.addSubview(notificationViewController.view)
                self.parentViewController?.view.bringSubviewToFront(self.view)
                self.out = true
                UIView.animateWithDuration(0.5,
                    animations: { notificationViewController.view.frame = self.makeNotificationViewFrame(self.controllers.first!.height) },
                    completion: nil)
            }
        }
    }
    
    func add(notificationViewController: UIViewController, withHeight h: Double) {
        if controllers.filter({ $0.controller === notificationViewController }).count == 0 {
            notificationViewController.view.translatesAutoresizingMaskIntoConstraints = true
            controllers.append(BoxedUIViewController(controller: notificationViewController, height: h))
        }
    }
    
}
