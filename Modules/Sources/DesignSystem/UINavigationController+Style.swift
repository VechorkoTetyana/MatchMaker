import UIKit

public extension UINavigationController {
 /*   func styleMatchMaker() {
        navigationBar.tintColor = .accent
        
        let image: UIImage = UIImage(resource: .navigationBack)
        
        navigationBar.backIndicatorImage = image
        navigationBar.backIndicatorTransitionMaskImage = image

        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
    
    */
    
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
    
    

