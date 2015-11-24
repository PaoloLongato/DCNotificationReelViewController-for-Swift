//
//  MyContainedNotificationViewController.swift
//  DCNotificationsReelDev
//
//  Created by Paolo Longato on 23/11/2015.
//  Copyright © 2015 Paolo Longato. All rights reserved.
//

import UIKit

class MyContainerNotificationViewController: DCContainerViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func close() {
        print("user: dismissed")
        if self.dismiss != nil {
            self.dismiss!(self)
        }
    }
    
}
