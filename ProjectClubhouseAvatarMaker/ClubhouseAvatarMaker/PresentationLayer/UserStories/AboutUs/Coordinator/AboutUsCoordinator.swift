//
//  AboutUsCoordinator.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 19.02.2021.
//

import UIKit

final class AboutUsCoordinator {
    
    weak var transition: ModuleTransitionHandler!

    static func createModule(_ configuration: ((CustomizableAboutUsViewModel) -> Void)? = nil) -> UIViewController {
        let view = AboutUsViewController()
        let viewModel = AboutUsViewModel()
        let coordinator = AboutUsCoordinator()

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
extension AboutUsCoordinator: AboutUsCoordinatorProtocol {

    func dismiss() {
        transition.dismissSelf()
    }
}
