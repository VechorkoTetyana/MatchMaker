import UIKit
import MatchMakerAuthentication
import MatchMakerLogin
import MatchMakerCore
import Swinject
import MatchMakerSettings
import DesignSystem

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var container: Container!
    var coordinator: AppCoordinator!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        registerDependencies()
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
//        let controller = setupInitialViewController()
      
        UINavigationController.styleMatchMaker()
        
        setupAppCoordinator()
        
//        self.window = window
    }
    
    private func setupAppCoordinator() {
        let navigationController = UINavigationController()
        
        let coordinator = AppCoordinator(
            navigationController: navigationController,
            container: container
        )
        coordinator.start()
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        self.coordinator = coordinator
    }
}

extension SceneDelegate {
    private func registerDependencies() {
        let container = Container()
        let assembly = Assembly(container: container)
        assembly.assemble()
        
        self.container = container
    }
}

