import UIKit
import SnapKit
import DesignSystem

public final class ProfileEditViewController: UIViewController {
   
/*    enum TextFieldType {
        case name
        case fullName
//        case description
//        case logout
    }
    
    enum Row: Int, CaseIterable {
        case profilePicture = 0
        case textField(TextFieldType) = 1
//        case description = 2
//        case logout = 3
    }*/
    
    private weak var tableView: UITableView!
    
    let viewModel = ProfileEditViewModel()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureTableView()
        setupHideKeyBoardGesture()
        subscribeToKeyboard()
        
        navigationItem.setMatchMakerTitle("ProfilePP")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
   private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(ProfileEditPictureCell.self, forCellReuseIdentifier: ProfileEditPictureCell.identifier)
        tableView.register(ProfileTextFieldCell.self, forCellReuseIdentifier: ProfileTextFieldCell.identifier)
        tableView.register(ButtonCell.self, forCellReuseIdentifier: ButtonCell.identifier)
    
    }
}


// MARK: Keyboard

extension ProfileEditViewController {
    private func setupHideKeyBoardGesture() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyBoard)
        )
        tap.cancelsTouchesInView = false
       
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyBoard() {
        view.endEditing(true)
    }
    
    private func subscribeToKeyboard() {
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
    
    @objc private func keyboardWillShow(notification: Notification) {
        
        guard let userInfo = notification.userInfo,
              let endFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        else { return }
        
        let isKeyboardHidden = endFrame.origin.y >= UIScreen.main.bounds.size.height
        
        let bottomMargin = isKeyboardHidden ? 0 : -endFrame.height - 16
        
        tableView.snp.updateConstraints { make in
            make.bottom.equalToSuperview().offset(bottomMargin)
        }
        
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
}

extension ProfileEditViewController {
    private func setupUI() {
        view.backgroundColor = .white
        configureNavigationItem()
        setupTableView()
    }
    
    private func configureNavigationItem() {
        navigationItem.largeTitleDisplayMode = .never
        
        let saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc
    private func didTapSave() {
        print("did save")
    }
    
    private func setupTableView() {
        let tableView = UITableView()
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
        
        self.tableView = tableView
        tableView.contentInset = UIEdgeInsets(top: 28, left: 0, bottom: 0, right: 0)
    }
    
    private func getStatusBarHeight() -> CGFloat {
       guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        else { return 0 }
        
        return windowScene.statusBarManager?.statusBarFrame.height ?? 0
    }
}

extension ProfileEditViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.rows.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let row = Row(rawValue: indexPath.row) else { return UITableViewCell() }
        
        let row = viewModel.rows[indexPath.row]
        
        switch row {
        case .profilePicture:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileEditPictureCell.identifier, for: indexPath) as? ProfileEditPictureCell
            else { return UITableViewCell() }
            
            if let selectedImage = viewModel.selectedImage {
                cell.configure(with: selectedImage)

            }
        
 //           cell.didTap = { [weak self] in
//              self?.didTapProfilePicture() }
            
            return cell
            
        case .textField(let type):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTextFieldCell.identifier, for: indexPath) as? ProfileTextFieldCell
            else { return UITableViewCell() }
            
//            cell.textField.delegate = self
            
            cell.configure(
                with: viewModel.modelForTextFieldRow(type))
 
            return cell
            
        }
    }
}

extension ProfileEditViewController: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard case .profilePicture = viewModel.rows[indexPath.row] else { return }
        
            didTapProfilePicture()
            
        }
    }
 

extension ProfileEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func didTapProfilePicture() {
        let alert = UIAlertController(title: "Select option", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { [weak self] _ in
            self?.showImagePicker(with: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { [weak self] _ in
            self?.showImagePicker(with: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    private func showImagePicker(with sourceType: UIImagePickerController.SourceType) {
        
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else { return }
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true)

    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            viewModel.selectedImage = selectedImage
            
            tableView.reloadRows(at: [
                IndexPath(row: 0, section: 0)
            ], with: .automatic)
        }
        picker.dismiss(animated: true)
    }
}
