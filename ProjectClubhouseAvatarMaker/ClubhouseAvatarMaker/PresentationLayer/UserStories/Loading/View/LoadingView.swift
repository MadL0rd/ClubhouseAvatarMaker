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
    let updateButton = TwoLabelsButton()
    let updateCheckFaildLabel = UILabel()

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
    
    func showUpdateButton(version: String) {
        updateButton.bottomLabel.text = NSLocalizedString("Tap to update app to new version", comment: "") + " \(version)"
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3) { [ weak self ] in
                self?.updateButton.alpha = 1
            }
        }
    }
    
    func showUpdateCheckFaildLabel() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3) { [ weak self ] in
                self?.updateCheckFaildLabel.alpha = 1
            }
        }
    }

    // MARK: - Private methods
    
    private func setupView() {

        backgroundColor = R.color.main()
        
        addSubview(logo)
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.contentMode = .scaleAspectFill
        logo.image = R.image.launchImage()
        
        addSubview(updateButton)
        UIStyleManager.twoLabelsButtonDark(updateButton)
        updateButton.alpha = 0
        updateButton.topLabel.text = NSLocalizedString("New version is available", comment: "")
        
        addSubview(updateCheckFaildLabel)
        updateCheckFaildLabel.translatesAutoresizingMaskIntoConstraints = false
        updateCheckFaildLabel.font = R.font.sfuiTextBold(size: 24)
        updateCheckFaildLabel.text = NSLocalizedString("New version checking failed", comment: "")
        updateCheckFaildLabel.textColor = R.color.tintColorDark()
        updateCheckFaildLabel.textAlignment = .center
        updateCheckFaildLabel.numberOfLines = 0
        updateCheckFaildLabel.alpha = 0
        
        makeConstraints()
    }

    private func makeConstraints() {
        NSLayoutConstraint.activate([
            logo.centerYAnchor.constraint(equalTo: centerYAnchor),
            logo.centerXAnchor.constraint(equalTo: centerXAnchor),
            logo.widthAnchor.constraint(equalTo: widthAnchor),
            logo.heightAnchor.constraint(equalTo: heightAnchor),
            
            updateButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            updateButton.widthAnchor.constraint(equalTo: widthAnchor, constant: -50),
            updateButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            updateCheckFaildLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            updateCheckFaildLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            updateCheckFaildLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
    }
}
