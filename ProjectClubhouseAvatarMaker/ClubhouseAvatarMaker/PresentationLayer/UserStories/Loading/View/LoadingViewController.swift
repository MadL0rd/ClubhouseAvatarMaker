//
//  LoadingViewController.swift
//  ClubhouseAvatarMaker
//
//  Created by Anton Tekutov on 17.02.21.
//

import UIKit

final class LoadingViewController: UIViewController {
    
    var viewModel: LoadingViewModelProtocol!
    var coordinator: LoadingCoordinatorProtocol!
    
    private var _view: LoadingView {
        return view as! LoadingView
    }
    
    override func loadView() {
        self.view = LoadingView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSelf()
    }
    
    private func configureSelf() {
        viewModel.startConfiguration()
        
        DispatchQueue.main.async { [ weak self ] in
            self?._view.changeLogo()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + _view.changeLogoDuration * 0.7) { [ weak self ] in
//            self?.coordinator.showEditor()
        }
    }
}
