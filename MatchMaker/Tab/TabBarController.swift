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

//      let home = DiscoveryViewController()

        let home = setupDiscovery()
        let matches = setupMatches()
        let inbox = UIViewController()
        inbox.tabBarItem = Tab.inbox.tabBarItem
        
        let settings = setupSettings()

        viewControllers = [
            home,
            matches,
            inbox,
            settings
        ]
    }
    
    private func setupSettings() -> UIViewController {
        let nav = UINavigationController()
        
        let coordinator = SettingsCoordinator(
            navigationController: nav,
            container: container
        )
        
        coordinator.start()
        
        coordinator.rootViewController.tabBarItem = Tab.settings.tabBarItem
        
        return nav
    }
    
    private func setupDiscovery() -> UIViewController {
        let nav = UINavigationController()
        
        let coordinator = DiscoveryCoordinator(
            navigationController: nav,
            container: container
        )
        
        coordinator.start()
        
        coordinator.rootViewController.tabBarItem = Tab.home.tabBarItem
        
        return nav
    }
    
    private func setupMatches() -> UIViewController {
        let nav = UINavigationController()
        
        let coordinator = MatchesCoordinator(
            navigationController: nav,
            container: container
        )
        
        coordinator.start()
        
        coordinator.rootViewController.tabBarItem = Tab.matches.tabBarItem
        
        return nav
    }
}
