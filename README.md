# DCNotificationReelViewController-for-Swift
![alt tag](https://dl.dropboxusercontent.com/u/82715482/notifications.gif)

## Design your notification views
- Library code is in the group "Classes"
- When creating your notifications views in storyboard, subclass "DCNotificationViewController".  Do not constrain your subviews to Bottom or Top Layout Guides as they will most likely be misplaced (perhaps after device rotations)
- When creating your notifications views in storyboard but you want to make use of a container view (for ease of design), subclass both "DCContainerViewController" and "DCContainedNotificationViewController".  Center your container view vertically (Y axis). 
- When creating your notifications views with a XIB, subclass "DCNotificationViewController"

## Example usage

From the view controller that is is charge of showing a notification:

    class ViewController: UIViewController {
     
      var vc = DCNotificationReelController()
      
      override func viewDidLoad() {
          super.viewDidLoad()
          
          // Configure the Notification Reel with different parameters
          
          vc.flowFromBottom = false       // True and Fakse
          vc.position = .Center           // .Left .Center .Right
          vc.width = 1                    // Between 0 and 1
          vc.statusBarOffset = true       // True and False
          vc.insets = 2                   // Insets, Double
          vc.addTo(self)                  // Needed: takes care of DCNotificationReelController containment
        
          // Example: instantiate from XIB
        
          let myVC = MyViewControllerFromXIB(nibName: "MyViewControllerFromXIB", bundle: nil)
          myVC.dismiss = weakify(vc, DCNotificationReelController.slideOutAndRemove)
          vc.add(myVC, withHeight: 40)
          vc.slideInNext()
        
          // Example: instantiate from Storyboard with container
          let sb = UIStoryboard(name: "Main", bundle: nil)
          let myOtherVC = sb.instantiateViewControllerWithIdentifier("myContainerVC") as! MyContainerNotificationViewController
          myOtherVC.dismiss = weakify(vc, DCNotificationReelController.slideOutAndRemove)
          vc.add(myOtherVC, withHeight: 40)
          vc.slideInNext()
        
      }
    }
