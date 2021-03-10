//
//  LoadingCoordinator.swift
//  ClubhouseAvatarMaker
//
//  Created by Anton Tekutov on 17.02.21.
//

import UIKit

final class LoadingCoordinator: DefaultCoordinator {
    
    static func createModule(_ configuration: ((CustomizableLoadingViewModel) -> Void)? = nil) -> UIViewController {
        let view = LoadingViewController()
        let viewModel = LoadingViewModel()
        let coordinator = LoadingCoordinator()

        view.viewModel = viewModel
        view.coordinator = coordinator

        coordinator.transition = view
        
        viewModel.remoteBordersService = RemoteBordersService.shared
        viewModel.purchaseManager = PurchaseManager.shared
        
        if let configuration = configuration {
            configuration(viewModel)
        }

        return view
    }
}

// MARK: - Interface for view

extension LoadingCoordinator: LoadingCoordinatorProtocol {
    
    func showEditor() {
        let vc = EditorCoordinator.createModule()
        transition.presentInNewRootNavigationStack(controller: vc, animated: true, completionHandler: nil)
    }
}
