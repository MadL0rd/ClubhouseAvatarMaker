//
// Auto generated file
//

import UIKit

protocol ModuleGenerator {
    func createModule() -> UIViewController
}

enum UserStoriesModulesDefault: ModuleGenerator {

    case aboutUs
    case loading
    case subscription
    case menu
    case editor
    case secretCodes

    func createModule() -> UIViewController {
        switch self {
        case .aboutUs: 
            return AboutUsCoordinator.createModule()
        case .loading: 
            return LoadingCoordinator.createModule()
        case .subscription: 
            return SubscriptionCoordinator.createModule()
        case .menu: 
            return MenuCoordinator.createModule()
        case .editor: 
            return EditorCoordinator.createModule()
        case .secretCodes: 
            return SecretCodesCoordinator.createModule()
        }
    }
}

enum UserStoriesModulesWithOutput: ModuleGenerator {

    case aboutUs(output: AboutUsOutput)
    case loading(output: LoadingOutput)
    case subscription(output: SubscriptionOutput)
    case menu(output: MenuOutput)
    case editor(output: EditorOutput)
    case secretCodes(output: SecretCodesOutput)

    func createModule() -> UIViewController {
        switch self {
        case .aboutUs(let output): 
            return AboutUsCoordinator.createModule { viewModel in 
                viewModel.output = output
            }
            
        case .loading(let output): 
            return LoadingCoordinator.createModule { viewModel in 
                viewModel.output = output
            }
            
        case .subscription(let output): 
            return SubscriptionCoordinator.createModule { viewModel in 
                viewModel.output = output
            }
            
        case .menu(let output): 
            return MenuCoordinator.createModule { viewModel in 
                viewModel.output = output
            }
            
        case .editor(let output): 
            return EditorCoordinator.createModule { viewModel in 
                viewModel.output = output
            }
            
        case .secretCodes(let output): 
            return SecretCodesCoordinator.createModule { viewModel in 
                viewModel.output = output
            }
            
        }
    }
}
