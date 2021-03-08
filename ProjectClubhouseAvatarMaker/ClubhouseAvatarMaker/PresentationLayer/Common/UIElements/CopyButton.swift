//
//  CopyButton.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 22.02.2021.
//

import UIKit

class CopyButton: ButtonWithTouchSize {
    
    private let vibroGeneratorLight = UIImpactFeedbackGenerator(style: .light)    
    var getTextClosure: (() -> String?)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - UI elements actions

    @objc func copyText() {
        guard let text = getTextClosure?()
        else { return }
        tapAnimation()
        vibroGeneratorLight.impactOccurred()
        UIPasteboard.general.string = text
    }
    
    // MARK: - Private setup methods
    
    private func setupView() {
        addTarget(self, action: #selector(copyText), for: .touchUpInside)
        setImage(R.image.copyButton(), for: .normal)
        setImage(R.image.copyButton(), for: .highlighted)
        setDefaultAreaPadding()

        makeConstraints()
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
}
