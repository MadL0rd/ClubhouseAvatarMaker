//
//  SubscriptionCoordinator.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 19.02.2021.
//

import UIKit

final class SubscriptionCoordinator {
    
    weak var transition: ModuleTransitionHandler!

    static func createModule(_ configuration: ((CustomizableSubscriptionViewModel) -> Void)? = nil) -> UIViewController {
        let view = SubscriptionViewController()
        let viewModel = SubscriptionViewModel()
        let coordinator = SubscriptionCoordinator()

        view.viewModel = viewModel
        view.coordinator = coordinator

        coordinator.transition = view
        
        viewModel.purchaseManager = PurchaseManager.shared

        if let configuration = configuration {
            configuration(viewModel)
        }

        return view
    }
}

// MARK: - Interface for view
extension SubscriptionCoordinator: SubscriptionCoordinatorProtocol {

    func dismiss() {
        transition.dismissSelf()
    }
}
