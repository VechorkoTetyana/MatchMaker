import UIKit
import SnapKit
import DesignSystem

public class MatchCell: UICollectionViewCell {
    
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let overlayView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.backgroundColor = .yellow
        contentView.layer.cornerRadius = 30
        contentView.clipsToBounds = true
        
        contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // Overlay View (for gradient effect)
        contentView.addSubview(overlayView)
        overlayView.clipsToBounds = true
        overlayView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.6, 1.0]
        gradientLayer.frame = overlayView.bounds
        overlayView.layer.addSublayer(gradientLayer)
        
        contentView.addSubview(nameLabel)
        nameLabel.font = .cardDetailTitle
        nameLabel.textColor = .white
        nameLabel.textAlignment = .left
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(18)
            make.bottom.trailing.equalToSuperview().inset(14)
            
        }
        layoutIfNeeded()
        gradientLayer.frame = overlayView.bounds
        
    }
    func configure(with user: User) {
        nameLabel.text = user.name
        imageView.sd_setImage(with: user.imageURL, completed: nil)
    }
}
