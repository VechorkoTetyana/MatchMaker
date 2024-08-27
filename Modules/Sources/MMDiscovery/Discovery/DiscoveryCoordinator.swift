import UIKit
import MatchMakerCore
import Swinject

// protocol DiscoveryCoordinator: Coordinator {}

public class DiscoveryCoordinator: Coordinator {
    private let navigationController: UINavigationController
    private let container: Container
    
    public var rootViewController: UIViewController!
    
    public init(
        navigationController: UINavigationController,
        container: Container
    ) {
        self.navigationController = navigationController
        self.container = container
        
        navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    public func start() {
        let viewModel = DiscoveryViewModel(
            container: container
        )
        let controller = DiscoveryViewController(viewModel: viewModel)
//        controller.hidesBottomBarWhenPushed = true
        rootViewController = controller
        navigationController.pushViewController(controller, animated: true)
    }
}
