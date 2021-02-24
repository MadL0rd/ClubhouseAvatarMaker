//
//  SubscriptionViewController.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 19.02.2021.
//

import UIKit

final class SubscriptionViewController: UIViewController {

    var viewModel: SubscriptionViewModelProtocol!
    var coordinator: SubscriptionCoordinatorProtocol!
    
    private let vibroGeneratorLight = UIImpactFeedbackGenerator(style: .light)
    weak var timer: Timer?
    
    private var _view: SubscriptionView {
        return view as! SubscriptionView
    }

    override func loadView() {
        self.view = SubscriptionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        _view.yearButton.flash()
    }
    
    deinit {
        timer?.invalidate()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureSelf()
    }

    private func configureSelf() {
        modalPresentationStyle = .formSheet
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.7) { [ weak self ] in
            guard let self = self
            else { return }
            self.attentionScaleAnimation()
            self.timer = Timer.scheduledTimer(timeInterval: 5,
                                              target: self,
                                              selector: #selector(self.attentionScaleAnimation),
                                              userInfo: nil,
                                              repeats: true)
        }
        _view.closeButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        _view.yearButton.addTarget(self, action: #selector(yearButtonDidTapped(sender:)), for: .touchUpInside)
        _view.weekButton.addTarget(self, action: #selector(weekButtonDidTapped(sender:)), for: .touchUpInside)
    }
    
    // MARK: - UI elements actions
    
    @objc private func backButtonTapped(sender: UIButton) {
        vibroGeneratorLight.impactOccurred()
        coordinator.dismiss()
    }
    
    @objc func attentionScaleAnimation() {
        _view.yearButton.attentionScaleAnimation()
    }
    
    @objc private func yearButtonDidTapped(sender: UIButton) {
        vibroGeneratorLight.impactOccurred()
        sender.tapAnimation()
    }
    
    @objc private func weekButtonDidTapped(sender: UIButton) {
        vibroGeneratorLight.impactOccurred()
        sender.tapAnimation()
    }
}
