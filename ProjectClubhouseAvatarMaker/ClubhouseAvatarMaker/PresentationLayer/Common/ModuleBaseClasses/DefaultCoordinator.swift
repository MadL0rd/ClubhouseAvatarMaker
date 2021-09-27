//
//  DefaultCoordinator.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 08.03.2021.
//

import UIKit
import SafariServices

enum ModuleOpeningMode {
    
    case present
    case showInRootNavigationController
    case showInNewRootNavigationStack
}

protocol DefaultCoordinatorProtocol: AnyObject {
    
    func dismiss()
    func openModule(_ module: UserStoriesModulesDefault, openingMode: ModuleOpeningMode?)
    func openModuleWithOutput(_ module: UserStoriesModulesWithOutput, openingMode: ModuleOpeningMode?)
    func openUrl(_ url: URL?)
    
    func generateAnnouncementModule() -> UIViewController
}

extension DefaultCoordinatorProtocol {
    
    func openModule(_ module: UserStoriesModulesDefault) {
        openModule(module, openingMode: nil)
    }
    
    func openModuleWithOutput(_ module: UserStoriesModulesWithOutput) {
        openModuleWithOutput(module, openingMode: nil)
    }
}

class DefaultCoordinator: DefaultCoordinatorProtocol {
    
    internal weak var transition: ModuleTransitionHandler!
    
    func dismiss() {
        transition.dismissSelf()
    }
    
    func openUrl(_ url: URL?) {
        guard let url = url
        else { return }
        
        let config = SFSafariViewController.Configuration()
        
        let vc = SFSafariViewController(url: url, configuration: config)
        vc.preferredBarTintColor = R.color.main()
        vc.preferredControlTintColor = R.color.tintColorDark()
        
        transition.present(vc)
    }
    
    func generateAnnouncementModule() -> UIViewController {
        return AnnouncementViewController()
    }
    
    func openModule(_ module: UserStoriesModulesDefault, openingMode: ModuleOpeningMode?) {
        openModule(moduleGenerator: module, openingMode: openingMode)
    }
    
    func openModuleWithOutput(_ module: UserStoriesModulesWithOutput, openingMode: ModuleOpeningMode?) {
        openModule(moduleGenerator: module, openingMode: openingMode)
    }
    
    private func openModule(moduleGenerator: ModuleGenerator, openingMode: ModuleOpeningMode?) {
        let vc = moduleGenerator.createModule()
        var openingModeResult = openingMode ?? .showInRootNavigationController
        if let vc = vc as? UIViewControllerTransitioningDelegate & UIViewController,
           (openingMode == nil || openingMode == .present) {
            openingModeResult = .present
            vc.view.backgroundColor = vc.view.backgroundColor
        }
        switch openingModeResult {
        case .present:
            // magic for custom presentation
            if let vc = vc as? UIViewControllerTransitioningDelegate & UIViewController {
                vc.view.backgroundColor = vc.view.backgroundColor
            }
            transition.present(vc)
        case .showInRootNavigationController:
            transition.showInRootNavigationController(vc)
        case .showInNewRootNavigationStack:
            transition.showInNewRootNavigationStack(controller: vc)
        }
    }
}
