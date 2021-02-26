//
//  LoadingCoordinator.swift
//  ClubhouseAvatarMaker
//
//  Created by Anton Tekutov on 17.02.21.
//

import UIKit

final class LoadingCoordinator {
    
    weak var transition: ModuleTransitionHandler!

    static func createModule(_ configuration: ((CustomizableLoadingViewModel) -> Void)? = nil) -> UIViewController {
        let view = LoadingViewController()
        let viewModel = LoadingViewModel()
        let coordinator = LoadingCoordinator()

        view.viewModel = viewModel
        view.coordinator = coordinator

        coordinator.transition = view
        
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
