import Foundation
import UIKit
import SnapKit
import PhoneNumberKit
import DesignSystem

enum PhoneNumberText: String {
    case title = "Can I get those digits?"
    case subtitle = "Enter your phone number below to create your free account."
    case continueButton = "Continue"
}

public class PhoneNumberViewController: UIViewController {
    
    private weak var stackView: UIStackView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension PhoneNumberViewController {
    
    private func setupUI() {
        
        view.backgroundColor = .white
        
        setupStackView()
        setupTitle()
        setupSubtitle()
        setupTextField()
        setupContinueButton()
    }
    
    private func setupStackView() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 32
        
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(48)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
        }
        
        self.stackView = stackView
    }
    
    private func setupTitle() {
        let label = UILabel()
        label.textColor = UIColor(resource: .accent)
        label.text = PhoneNumberText.title.rawValue
        label.font = .title
        label.numberOfLines = 0
        
        stackView.addArrangedSubview(label)
    }
    
    private func setupSubtitle() {
        let label = UILabel()
        label.textColor = UIColor(resource: .textGray)
        label.text = PhoneNumberText.subtitle.rawValue
        label.font = .subtitle
        label.numberOfLines = 0
        
        stackView.addArrangedSubview(label)
    }
    
    private func setupTextField() {
        let textFieldBackgroundView = UIView()
        textFieldBackgroundView.backgroundColor = .white
        textFieldBackgroundView.layer.cornerRadius = 6
        textFieldBackgroundView.layer.masksToBounds = false
        
        stackView.addArrangedSubview(textFieldBackgroundView)
        
        textFieldBackgroundView.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalTo(55)
        }
        
        view.layoutIfNeeded()
        
        textFieldBackgroundView.layer.borderColor = UIColor(resource: .border).cgColor
        textFieldBackgroundView.layer.borderWidth = 1
        textFieldBackgroundView.layer.shadowColor = UIColor.black.withAlphaComponent(0.07).cgColor
        textFieldBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 7)
        textFieldBackgroundView.layer.shadowRadius = 64
        textFieldBackgroundView.layer.shadowPath = UIBezierPath(roundedRect: textFieldBackgroundView.bounds, cornerRadius: textFieldBackgroundView.layer.cornerRadius).cgPath
        textFieldBackgroundView.layer.shadowOpacity = 1
        
        let textField = PhoneNumberTextField(
            insets: UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8),
            clearButtonPadding: 0)
        
//        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textField.withFlag = true
        textField.font = .textField
        textField.textColor = .black
        textField.withExamplePlaceholder = true
        textField.attributedPlaceholder = NSAttributedString(string: "Enter phone number")
        textFieldBackgroundView.addSubview(textField)
        
        textField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
    }
    
    private func setupContinueButton() {
        let button = UIButton()
        button.titleLabel?.font = .button
        button.titleLabel?.textColor = .white
        button.setTitle(PhoneNumberText.continueButton.rawValue, for: .normal)

        button.backgroundColor = UIColor(resource: .accent)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
                
        stackView.addArrangedSubview(button)
        
        button.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalToSuperview()
        }
    }
}
    
