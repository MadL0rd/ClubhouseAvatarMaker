//
//  EditorCoordinator.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 17.02.2021.
//

import UIKit

final class EditorCoordinator {
    
    weak var transition: ModuleTransitionHandler!

    static func createModule(_ configuration: ((CustomizableEditorViewModel) -> Void)? = nil) -> UIViewController {
        let view = EditorViewController()
        let viewModel = EditorViewModel()
        let coordinator = EditorCoordinator()

        view.viewModel = viewModel
        view.coordinator = coordinator

        coordinator.transition = view
        
        viewModel.assetsManager = AssetsManager.shared
        viewModel.purchaseManager = PurchaseManager.shared
        viewModel.defaults = UserDefaultsEditorManager()

        if let configuration = configuration {
            configuration(viewModel)
        }

        return view
    }
}

// MARK: - Interface for view
extension EditorCoordinator: EditorCoordinatorProtocol {

    func openAboutUs() {
        let vc = AboutUsCoordinator.createModule()
        transition.showInRootNavigationController(vc)
    }
    
    func openSubscribtion(output: SubscriptionOutput) {
        let vc = SubscriptionCoordinator.createModule()
        transition.present(vc)
    }
}
