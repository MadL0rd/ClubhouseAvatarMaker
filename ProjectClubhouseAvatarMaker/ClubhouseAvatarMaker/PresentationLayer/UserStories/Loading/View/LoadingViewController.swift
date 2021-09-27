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
    
    var updateUrl: URL?
    var showEditorDelay: DispatchTime?
    
    private let loadingCheckedQueue = DispatchQueue(label: "loadingCheckedQueue", qos: .userInitiated)
    var updateChecked = false
    var accountChecked = false
    var loadingChecked: Bool { updateChecked && accountChecked }

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
        _view.updateButton.addTarget(self, action: #selector(updateButtonTapped(sender:)), for: .touchUpInside)
        
        viewModel.configureRemoteBordersAccount { [ weak self ] in
            self?.loadingCheckedQueue.sync {
                self?.accountChecked = true
                self?.checkLoadingCompletion()
            }
        }
        
        viewModel.checkUpdateIsAvailable { [ weak self ] result in
            guard let self = self
            else { return }
            
            switch result {
            case .success(let data):
                if data.version.compare(Bundle.main.versionNumber, options: .numeric) == .orderedDescending {
                    self.updateUrl = URL(string: data.trackViewUrl)
                    self._view.showUpdateButton(version: data.version)
                    return
                }
                self.loadingCheckedQueue.sync {
                    self.updateChecked = true
                    self.checkLoadingCompletion()
                }
                
            case .failure(let error):
                print(error)
                self._view.showUpdateCheckFaildLabel()
            }
        }
        
        DispatchQueue.main.async { [ weak self ] in
            self?._view.changeLogo()
        }
        
        showEditorDelay = .now() + _view.changeLogoDuration * 0.7
    }
    
    private func checkLoadingCompletion() {
        if loadingChecked == true {
            showNextScreen()
        }
    }
    
    private func showNextScreen() {
        DispatchQueue.main.asyncAfter(deadline: showEditorDelay ?? .now()) { [ weak self ] in
            self?.coordinator.showEditor()
        }
    }
    
    // MARK: - UI elements actions

    @objc private func updateButtonTapped(sender: TwoLabelsButton) {
        guard let url = updateUrl
        else { return }
        sender.tapAnimation()
        coordinator.openUrl(url)
    }
}
