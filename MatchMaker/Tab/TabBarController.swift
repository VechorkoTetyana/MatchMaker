import UIKit
import DesignSystem
import MMDiscovery
import MatchMakerSettings
import MatchMakerAuthentication
import Swinject

class TabBarController: UITabBarController {
    
    private let container: Container
    
    init(container: Container) {
        self.container = container
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        tabBar.barTintColor = .white
        tabBar.tintColor = .accent
        tabBar.unselectedItemTintColor = .grayShadow

    }
    
    private func setupViewController() {
        // home, matches, inbox, settings
        
        let home = DiscoveryViewController()
        home.tabBarItem = Tab.home.tabBarItem
        
        let matches = UIViewController()
        matches.tabBarItem = Tab.matches.tabBarItem
        
        let inbox = UIViewController()
        inbox.tabBarItem = Tab.inbox.tabBarItem
        
        let settingsNav = setupSettings()

//        let settings = SettingsViewController()
//        let settingsNav = UINavigationController(rootViewController: settings)
//        settingsNav.styleMatchMaker()
        
//        settings.title = Tab.settings.tabBarItem.title
        
//        settings.tabBarItem = Tab.settings.tabBarItem

        viewControllers = [
            home,
            matches,
            inbox,
            settingsNav
        ]
        
//        selectedViewController = settingsNav
    }
    
    private func setupSettings() -> UIViewController {
        //     let settings = SettingsViewController()
        //     settings.viewModel = SettingsViewModel(container: container)
        let settingsNav = UINavigationController()
        
        let coordinator = SettingsCoordinator(
            navigationController: settingsNav,
            container: container
        )
        
        coordinator.start()
        
        coordinator.rootViewController.tabBarItem = Tab.settings.tabBarItem
        
        return settingsNav
    }
}
