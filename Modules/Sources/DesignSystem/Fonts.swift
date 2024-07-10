import Foundation
import UIKit

enum FontName: String {
    case poppinsBold = "Poppins-Bold"
    case avenirNextRegular = "AvenirNext-Regular"
    case avenirMedium = "Avenir-Medium"
    case avenirBlack = "Avenir-Black"
}

public extension UIFont {
    static var title: UIFont {
        UIFont(name: FontName.poppinsBold.rawValue, size: 45)!
    }
    
    static var subtitle: UIFont {
        UIFont(name: FontName.avenirNextRegular.rawValue, size: 18)!
    }
    
    static var textField: UIFont {
        UIFont(name: FontName.avenirMedium.rawValue, size: 18)!
    }
    
    static var button: UIFont {
        UIFont(name: FontName.avenirBlack.rawValue, size: 20)!
    }
}


