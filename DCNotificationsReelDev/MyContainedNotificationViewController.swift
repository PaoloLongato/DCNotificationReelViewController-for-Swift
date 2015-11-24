//
//  MyContainedNotificationViewController.swift
//  DCNotificationsReelDev
//
//  Created by Paolo Longato on 23/11/2015.
//  Copyright © 2015 Paolo Longato. All rights reserved.
//

import UIKit

class MyContainedNotificationViewController: DCContainedNotificationViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close() {
        if let _ = dismiss {
            dismiss!()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
