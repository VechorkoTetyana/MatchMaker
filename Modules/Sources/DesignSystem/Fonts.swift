import Foundation
import UIKit

enum FontName: String {
    case avenirNextBold = "AvenirNext-Bold"
    case avenirNextDemiBold = "AvenirNext-DemiBold"
    case avenirNextRegular = "AvenirNext-Regular"
    case avenirNextMedium = "AvenirNext-Medium"
    case avenirMedium = "Avenir-Medium"
    case avenirBlack = "Avenir-Black"
    case poppinsBold = "Poppins-Bold"
    case poppinsRegular = "Poppins-Regular"
}

public extension UIFont {
    static var title: UIFont {
        UIFont(name: FontName.poppinsBold.rawValue, size: 45)!
    }
    
    static var title3: UIFont {
        UIFont(name: FontName.avenirNextDemiBold.rawValue, size: 20)!
    }
    
    static var subtitle: UIFont {
        UIFont(name: FontName.avenirNextRegular.rawValue, size: 18)!
    }
    
    static var subtitle2: UIFont {
        UIFont(name: FontName.poppinsRegular.rawValue, size: 16)!
    }
    
    static var subtitle3: UIFont {
        UIFont(name: FontName.avenirNextRegular.rawValue, size: 15)!
    }
    
    static var textField: UIFont {
        UIFont(name: FontName.avenirMedium.rawValue, size: 18)!
    }
    
    static var button: UIFont {
        UIFont(name: FontName.avenirBlack.rawValue, size: 20)!
    }
    
    static var subtitleButton: UIFont {
        UIFont(name: FontName.poppinsBold.rawValue, size: 16)!
    }
    
    static var otp: UIFont {
        UIFont(name: FontName.avenirBlack.rawValue, size: 24)!
    }
    
    static var navigationTitle: UIFont {
        UIFont(name: FontName.avenirNextBold.rawValue, size: 25)!
    }
}


