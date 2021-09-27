//
//  DefaultCoordinator.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 08.03.2021.
//

import UIKit

enum ModuleOpeningMode {
    
    case present
    case showInRootNavigationController
}

protocol DefaultCoordinatorProtocol: AnyObject {
    
    func dismiss()
    func openModule(_ module: UserStoriesModulesDefault, openingMode: ModuleOpeningMode)
    func openModuleWithOutput(_ module: UserStoriesModulesWithOutput, openingMode: ModuleOpeningMode)
}

extension DefaultCoordinatorProtocol {
    
    func openModule(_ module: UserStoriesModulesDefault) {
        openModule(module, openingMode: .showInRootNavigationController)
    }
    
    func openModuleWithOutput(_ module: UserStoriesModulesWithOutput) {
        openModuleWithOutput(module, openingMode: .showInRootNavigationController)
    }
}

class DefaultCoordinator: DefaultCoordinatorProtocol {
    
    internal weak var transition: ModuleTransitionHandler!
    
    func dismiss() {
        transition.dismissSelf()
    }
    
    func openModule(_ module: UserStoriesModulesDefault, openingMode: ModuleOpeningMode) {
        openModule(moduleGenerator: module, openingMode: openingMode)
    }
    
    func openModuleWithOutput(_ module: UserStoriesModulesWithOutput, openingMode: ModuleOpeningMode) {
        openModule(moduleGenerator: module, openingMode: openingMode)
    }
    
    private func openModule(moduleGenerator: ModuleGenerator, openingMode: ModuleOpeningMode) {
        let vc = moduleGenerator.createModule()
        switch openingMode {
        case .present:
            transition.present(vc)
        case .showInRootNavigationController:
            transition.showInRootNavigationController(vc)
        }
    }
}

