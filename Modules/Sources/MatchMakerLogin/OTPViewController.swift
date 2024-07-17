import Foundation
import UIKit
import DesignSystem
import MatchMakerAuthentication
import SnapKit
import PhoneNumberKit

enum OTPText: String {
    case title = "Enter the 6 digit code."
    case subtitle = "Enter the 6 digit code sent to your device to verify your account."
    case continueBtn = "Continue"
    case didntReceive = "Didn’t get a code?"
    case resend = " Resend"
}

public class OTPViewController: UIViewController {
    
    private weak var stackView: UIStackView!
    private weak var continueBtn: UIButton!
    
    private var textFields: [UITextField] = []
        
    var viewModel: OTPViewModel!
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureKeyboard()
        setupHideKeyboardGesture()
        textFields.first?.becomeFirstResponder()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupHideKeyboardGesture() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        
//        tap.delegate = self
        
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension OTPViewController {
    
    private func setupUI() {
        view.backgroundColor = .white
        
        setupStackView()
        setupTitle()
        setupSubtitle()
        setupTextFields()
        setupContinueButton()
        setupResendLabel()
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
        label.text = OTPText.title.rawValue
        label.font = .title
        label.numberOfLines = 0
        
        stackView.addArrangedSubview(label)
    }
    
    private func setupSubtitle() {
        let label = UILabel()
        label.textColor = UIColor(resource: .textGray)
        label.text = OTPText.subtitle.rawValue
        label.font = .subtitle
        label.numberOfLines = 0
        
        stackView.addArrangedSubview(label)
    }
    
    private func setupTextFields() {
        var fields = [UITextField]()
        
        let fieldsStackView = UIStackView()
        fieldsStackView.axis = .horizontal
        fieldsStackView.distribution = .equalSpacing
        fieldsStackView.alignment = .center
        
        for index in 0...5 {
            let background = UIView()
            background.backgroundColor = .white
            
            background.layer.cornerRadius = 14
            background.layer.masksToBounds = true
            
            let textField = UITextField()
            textField.textAlignment = .center
            textField.textColor = .white
            textField.font = .otp
            textField.keyboardType = .numberPad
            textField.addTarget(self, action: #selector(didChangeText), for: .editingChanged)
            textField.tag = 100 + index
            
            background.addSubview(textField)
            
            background.snp.makeConstraints { make in
                make.height.equalTo(48)
                make.width.equalTo(48)
            }
            
            textField.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            fieldsStackView.addArrangedSubview(background)
            fields.append(textField)
            
        }
        stackView.addArrangedSubview(fieldsStackView)
        
        fieldsStackView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        view.layoutIfNeeded()
        
        for field in fields {
            field.superview?.applyGradient(
                colours: [UIColor(resource: .otpFieldGradientStart),
                          UIColor(resource: .otpFieldGradientEnd)],
                startPoint: CGPoint(x: -0.2, y: 1.15),
                endPoint: CGPoint(x: 1, y: 0)
            )
        }
        textFields = fields
    }
    
    @objc func didChangeText(textField: UITextField) {
        textField.superview?.layer.sublayers?.first?.removeFromSuperlayer()
        textField.superview?.applyGradient(
            colours: [UIColor(resource: .accent),
                      UIColor(resource: .backgroundPink)],
            startPoint: CGPoint(x: -0.2, y: 1.15),
            endPoint: CGPoint(x: 1, y: 0)
        )
        
        let index = textField.tag - 100
        let nextIndex = index + 1
        
        guard nextIndex < textFields.count else {
            didTapContinue()
            continueBtn.alpha = 1.0
            return
        }
        textFields[nextIndex].becomeFirstResponder()
    }
    
    
    
    private func configureKeyboard() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let endFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        else { return }
        
        let animationCurveRawNumber = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNumber?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
        let animationCurve = UIView.AnimationOptions(rawValue: animationCurveRaw)
        
        let isKeyboardHidden = endFrame.origin.y <= UIScreen.main.bounds.size.height
        
        // if keyboard is hidden
        
        let topMargin = isKeyboardHidden ? -40 : -endFrame.height + view.safeAreaInsets.bottom - 16
        
        continueBtn.snp.updateConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(topMargin)
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: animationCurve) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func setupContinueButton() {
        let button = UIButton()
        button.titleLabel?.font = .button
        button.titleLabel?.textColor = .white
        button.setTitle(PhoneNumberText.continueButton.rawValue, for: .normal)
        
        button.backgroundColor = UIColor(resource: .accent)
        button.layer.cornerRadius = 14
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(didTapContinueBtn), for: .touchUpInside)
        
        view.addSubview(button)
        
        stackView.addArrangedSubview(button)
        
        button.snp.makeConstraints { make in
            make.height.equalTo(58)
            make.width.equalTo(306)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-48)
        }
        
        view.layoutIfNeeded()
        button.applyGradient(
            colours: [
                UIColor(resource: .accent),
                UIColor(resource: .backgroundPink)
            ])
        
         self.continueBtn = button
    }
    
    @objc func didTapContinueBtn() {
        let otpVC = OTPViewController()
        navigationController?.pushViewController(otpVC, animated: true)
    }
    
    private func setupResendLabel() {
        let label = UILabel()
        let string = NSMutableAttributedString()
        let didntGetTheCode = NSAttributedString(string: OTPText.didntReceive.rawValue, attributes: [
                .font: UIFont.subtitle2,
                .foregroundColor: UIColor(resource: .textGray)
        ])
        string.append(didntGetTheCode)
        let resend = NSAttributedString(string: OTPText.resend.rawValue, attributes: [
            .font: UIFont.subtitleButton,
            .foregroundColor: UIColor(resource: .accent)
    ])
        string.append(resend)
        
        label.attributedText = string
        
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(continueBtn.snp.bottom).offset(25)
        }
    }
}

extension OTPViewController {
    
    private func setContinueButtonDisabled() {
        continueBtn.isEnabled = false
        continueBtn.alpha = 0.5
    }
    
    private func setContinueButtonEnabled() {
        continueBtn.isEnabled = true
        continueBtn.alpha = 1
    }
    
    @objc func didTapContinue() {
        self.setContinueButtonDisabled()
        
        let digits = textFields.map { $0.text ?? "" }
        
        /*     let loadingVC = LoadingViewController()
         loadingVC.modalPresentationStyle = .overCurrentContext
         self.present(loadingVC, animated: true)*/
        
        Task { [weak self] in
            do {
                try await self?.viewModel.verifyOTP(with: digits)
                
                let vc = UIViewController()
                vc.modalPresentationStyle = .fullScreen
                self?.present(vc, animated: true)
                
            } catch {
                self?.showError(error.localizedDescription)
                self?.setContinueButtonEnabled()
            }
        }
    }
}


