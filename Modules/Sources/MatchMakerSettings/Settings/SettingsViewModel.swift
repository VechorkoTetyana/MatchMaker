import UIKit
import DesignSystem

struct Header {
    let image: UIImage
    let name: String
    let description: String
}

public final class SettingsViewModel {
    
    let header: Header
    
    public init() {
        self.header = Header(
            image: UIImage(resource: .profilePicturePlaceholder),
            name: "Setup Your Name",
            description: "No Location"
        )
    }
}
