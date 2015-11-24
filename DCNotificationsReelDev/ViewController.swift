//
//  ViewController.swift
//  DCNotificationsReelDev
//
//  Created by Paolo Longato on 13/11/2015.
//  Copyright © 2015 Paolo Longato. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var vc = DCNotificationReelController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // TEST 1: configure the Notification Reel with different parameters
        
        vc.flowFromBottom = false       // True and Fakse
        vc.position = .Left           // .Left .Center .Right
        vc.width = 0.80                    // Between 0 and 1
        vc.statusBarOffset = true       // True and False
        vc.insets = 0                   // Insets, Double
        vc.addTo(self)                  // Needed: takes care of DCNotificationReelController containment
        // For debugging only
        vc.view.layer.borderWidth = 1
        vc.view.layer.borderColor = UIColor.whiteColor().CGColor
        
    }

    // TEST 2: Instantiate view from Storyboard directly
    @IBAction func addTwo() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let myVC = sb.instantiateViewControllerWithIdentifier("myVC") as! MyNotificationViewController
        myVC.dismiss = weakify(vc, DCNotificationReelController.slideOutAndRemove)
        vc.add(myVC, withHeight: 40)
        vc.slideInNext()
    }
    
    // TEST 3: Instantiate view from Storyboard with container
    @IBAction func addFromContainer() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let myVC = sb.instantiateViewControllerWithIdentifier("myContainerVC") as! MyContainerNotificationViewController
        myVC.dismiss = weakify(vc, DCNotificationReelController.slideOutAndRemove)
        vc.add(myVC, withHeight: 40)
        vc.slideInNext()
    }
    
    // TEST 4: Instantiate view from XIB
    @IBAction func addFromXIB() {
        let myVC = MyViewControllerFromXIB(nibName: "MyViewControllerFromXIB", bundle: nil)
        myVC.dismiss = weakify(vc, DCNotificationReelController.slideOutAndRemove)
        vc.add(myVC, withHeight: 40)
        vc.slideInNext()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

