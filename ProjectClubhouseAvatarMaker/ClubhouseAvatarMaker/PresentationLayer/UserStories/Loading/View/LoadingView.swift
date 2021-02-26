//
//  LoadingView.swift
//  ClubhouseAvatarMaker
//
//  Created by Anton Tekutov on 17.02.21.
//

import UIKit

final class LoadingView: UIView {
    
    let logo = UIImageView()
    let changeLogoDuration: TimeInterval = 0.8

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    // MARK: - Public methods
    
    func changeLogo() {
        UIView.transition(with: self,
                          duration: changeLogoDuration,
                          options: .transitionCrossDissolve) { [ weak self ] in
            self?.logo.image = R.image.loadingImage()
        }
    }

    // MARK: - Private methods
    
    private func setupView() {

        backgroundColor = R.color.main()
        
        addSubview(logo)
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.contentMode = .scaleAspectFill
        logo.image = R.image.launchImage()
        
        makeConstraints()
    }

    private func makeConstraints() {
        NSLayoutConstraint.activate([
            logo.centerYAnchor.constraint(equalTo: centerYAnchor),
            logo.centerXAnchor.constraint(equalTo: centerXAnchor),
            logo.widthAnchor.constraint(equalTo: widthAnchor),
            logo.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
}
