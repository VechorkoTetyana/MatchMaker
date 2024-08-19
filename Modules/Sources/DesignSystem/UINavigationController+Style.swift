import UIKit

public extension UINavigationController {
   static func styleMatchMaker() {
       let appearence = UINavigationBar.appearance()
       
       appearence.tintColor = .accent
       
       let image = UIImage(resource: .navigationBack)
       
       appearence.backIndicatorImage = image
       appearence.backIndicatorTransitionMaskImage = image
       appearence.barTintColor = .white

       appearence.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
}
    
    

