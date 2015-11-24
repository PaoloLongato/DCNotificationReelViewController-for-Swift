//
//  MyNotificationViewController.swift
//  DCNotificationsReelDev
//
//  Created by Paolo Longato on 16/11/2015.
//  Copyright © 2015 Paolo Longato. All rights reserved.
//

import UIKit

class MyNotificationViewController: DCNotificationViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close() {
        if self.dismiss != nil {
            self.dismiss!(self)
        }
    }
    
}
