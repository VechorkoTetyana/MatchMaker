import UIKit
import MatchMakerCore
import Swinject

public class ProfileCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    private let container: Container
    
    public init(
        navigationController: UINavigationController,
        container: Container
    ) {
        self.navigationController = navigationController
        self.container = container
    }
    
    public func start() {
        let controller = ProfileEditViewController()
        controller.viewModel = ProfileEditViewModel(
            container: container,
            coordinator: self
        )
        
        controller.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(controller, animated: true)
    }
    
    func dismiss() {
        navigationController.popViewController(animated: true)
//      self?.navigationController?.popViewController(animated: true)

    }
}