import UIKit

public extension UINavigationItem {
    func setMatchMakerTitle(_ title: String) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .navigationTitle
        titleLabel.textColor = .black
        titleView = titleLabel
    }
}
