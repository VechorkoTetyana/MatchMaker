import UIKit
import SnapKit

public final class ProfileTextFieldCell: UITableViewCell {
    
    struct Model {
        let icon: UIImage
        let placeholderText: String
        let text: String?
        let isValid: Bool

        init(
            icon: UIImage,
            placeholderText: String,
            text: String?,
            isValid: Bool
        ) {
            self.icon = icon
            self.placeholderText = placeholderText
            self.text = text
            self.isValid = isValid
        }
    }
//    private weak var profileImageView: UIImageView!
    
    weak var textField: UITextField!
    private weak var iconImageView: UIImageView!
    private weak var checkMarkImageView: UIImageView!
    
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
    
    func configure(with model: Model) {
        textField.placeholder = model.placeholderText
        textField.text = model.text
        iconImageView.image = model.icon
        configureCheckMark(for: model)
    }
    
    private func configureCheckMark(for model: Model) {
        checkMarkImageView.image = checkMarkImage(for: model)
        
        if model.isValid {
            setConfigureCheckMarkShadowEnabled()
        } else {
            checkMarkImageView.layer.shadowOpacity = 0
        }
    }
    
    private func setConfigureCheckMarkShadowEnabled() {
        checkMarkImageView.layer.shadowColor = UIColor.pinkShadow.withAlphaComponent(0.65).cgColor
        checkMarkImageView.layer.shadowOpacity = 1
        checkMarkImageView.layer.shadowOffset = CGSize(width: 0, height: 10)
        checkMarkImageView.layer.shadowRadius = 35
    }
    
    private func checkMarkImage(for model: Model) -> UIImage {
        model.isValid ? UIImage(resource: .checkMarkSelected) : UIImage(resource: .checkMark)
    }
}

extension ProfileTextFieldCell {
    
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        setupIcon()
        setupTextField()
        setupCheckMark()
    }
    
    private func setupIcon() {
        let imageView = UIImageView()
//        imageView.image = UIImage(resource: .checkMark)
        imageView.contentMode = .scaleAspectFit
        
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
        }
        iconImageView = imageView
    }
    
    private func setupTextField() {
        let textField = UITextField()
        textField.textColor = .black
        textField.font = .textField2
        
        contentView.addSubview(textField)
        
        textField.snp.makeConstraints { make in
            make.left.equalTo(iconImageView.snp.right).offset(13)
            make.centerY.equalToSuperview()
        }
        self.textField = textField
    }
    
    private func setupCheckMark() {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(23)
            make.left.equalTo(textField.snp.right).offset(18)
            make.right.equalToSuperview().offset(-19)
            make.centerY.equalToSuperview()
        }
        self.checkMarkImageView = imageView
    }
}
