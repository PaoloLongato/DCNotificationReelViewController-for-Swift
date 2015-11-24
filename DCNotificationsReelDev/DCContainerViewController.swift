//
//  DCContainerViewController.swift
//  DCNotificationsReelDev
//
//  Created by Paolo Longato on 23/11/2015.
//  Copyright © 2015 Paolo Longato. All rights reserved.
//

import UIKit

class DCContainerViewController: DCNotificationViewController {

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if  let dVC = segue.destinationViewController as? DCContainedNotificationViewController,
            let _ = dismiss {
                dVC.dismiss = { [weak self] in if let s = self { s.dismiss!(s) } }
        }
    }
    
}
