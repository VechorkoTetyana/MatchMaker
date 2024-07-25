import UIKit
import SnapKit
import DesignSystem

class ProfileEditPictureCell: UITableViewCell {
    
    private weak var profileImageView: UIImageView!
    private weak var setNewAvatarBtn: UIButton!
    
    var didTap: (()->())?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    private func commonInit() {
        setupUI()
    }
    
    func configure(with image: UIImage?) {
        if let image {
            profileImageView.image = image
        }
    }
}

extension ProfileEditPictureCell {
    
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        setupProfileImage()
        
    }
    
    private func setupProfileImage() {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .profilePictureSelection)
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill

        
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(151)
            make.height.equalTo(196)
            make.top.equalToSuperview().offset(121)
            make.bottom.equalToSuperview().offset(-16)
            make.centerX.equalToSuperview()

        }
        
        self.profileImageView = imageView
    }
    
}
