import UIKit
import DesignSystem
import SnapKit
import MatchMakerCore

public final class SettingsViewController: UIViewController {
   
    private weak var tableView: UITableView!
    
    let viewModel = SettingsViewModel()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureTableView()
        setupNavigationBar()
    }
    
    private func configureTableView() {
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SettingsHeaderCell.self, forCellReuseIdentifier: SettingsHeaderCell.identifier)
    }
    
    private func setupNavigationBar() {
        setupNavigationTitle()
        setupEditBarButton()
    }
    
    private func setupNavigationTitle() {
        let titleLabel = UILabel()
        titleLabel.text = "Settings"
        titleLabel.font = .navigationTitle
        titleLabel.textColor = .black
        navigationItem.titleView = titleLabel
    }
    
    private func setupEditBarButton() {
        let rightBarButtonItem = UIBarButtonItem(image: .editIcon, style: .plain, target: self, action: #selector(rightBarButtonTapped))
        rightBarButtonItem.tintColor = .accent
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc private func rightBarButtonTapped() {
        
    }
}

extension SettingsViewController {
    
    private func setupUI() {
        setupNavigationTitle()
        setupTableView()
    }
    
  /*  private func setupNavigationTitle() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .font: UIFont.title
        ]
    }*/
    
    private func setupTableView() {
        let tableView = UITableView()
//        tableView.backgroundColor = .background
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
        
        self.tableView = tableView
        
        setupTableFooter()
    }
    
    private func setupTableFooter() {
        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 100)
        
        let button = UIButton(type: .custom)
        button.setTitle("Logout", for: .normal)
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        footerView.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.height.equalTo(58)
            make.width.equalTo(306)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)

        }
        
        tableView.tableFooterView = footerView
        
        view.layoutIfNeeded()
        button.styleMatchMaker()
    }
    
    @objc private func logoutButtonTapped() {
        
    }
}

extension SettingsViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsHeaderCell.identifier, for: indexPath) as? SettingsHeaderCell else { return UITableViewCell() }
        
        cell.configure(with: viewModel.header)
        
    return cell
    }
}

extension SettingsViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        tableView.tableFooterView
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        tableView.frame.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom - 108
    }
}



