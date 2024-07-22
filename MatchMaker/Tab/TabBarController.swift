import UIKit
import MatchMakerSettings

class TabBarController: UITabBarController {
    
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
        tabBar.unselectedItemTintColor = .lightGray

    }
    
    private func setupViewController() {
        // home, matches, inbox, settings
        
        let home = UIViewController()
        home.tabBarItem = Tab.home.tabBarItem
        
        let matches = UIViewController()
        matches.tabBarItem = Tab.matches.tabBarItem
        
        let inbox = UIViewController()
        inbox.tabBarItem = Tab.inbox.tabBarItem

        let settings = SettingsViewController()
        let settingsNav = UINavigationController(rootViewController: settings)
        
//        settings.title = Tab.settings.tabBarItem.title
        
        settings.tabBarItem = Tab.settings.tabBarItem

        viewControllers = [
            home,
            matches,
            inbox,
            settingsNav
        ]
        
        selectedViewController = settingsNav
    }
}
