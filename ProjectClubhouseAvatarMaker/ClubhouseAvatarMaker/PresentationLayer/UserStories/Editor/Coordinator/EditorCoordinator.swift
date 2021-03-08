//
//  EditorCoordinator.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 17.02.2021.
//

import UIKit

final class EditorCoordinator: DefaultCoordinator {
    
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
        viewModel.remoteBordersService = RemoteBordersService.shared

        if let configuration = configuration {
            configuration(viewModel)
        }

        return view
    }
}

// MARK: - Interface for view
extension EditorCoordinator: EditorCoordinatorProtocol {

}
