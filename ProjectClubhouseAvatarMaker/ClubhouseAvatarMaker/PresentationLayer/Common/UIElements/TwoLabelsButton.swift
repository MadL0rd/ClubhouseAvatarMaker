//
//  TwoLabelsButton.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 10.03.2021.
//

import UIKit

class TwoLabelsButton: ButtonWithTouchSize {
    
    let stack = UIStackView()
    let topLabel = UILabel()
    let bottomLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - Private setup methods
    
    private func setupView() {
        setDefaultAreaPadding()
        
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 12
        
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 5
        stack.isUserInteractionEnabled = false
        
        stack.addArrangedSubview(topLabel)
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.font = R.font.sfuiTextBold(size: 18)
        topLabel.textAlignment = .center
        topLabel.isUserInteractionEnabled = false
        
        stack.addArrangedSubview(bottomLabel)
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel.font = R.font.sfuiTextLight(size: 16)
        bottomLabel.textAlignment = .center
        bottomLabel.isUserInteractionEnabled = false
        bottomLabel.numberOfLines = 2
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalTo: stack.heightAnchor, constant: 30),
            
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: centerYAnchor),
            stack.widthAnchor.constraint(equalTo: widthAnchor, constant: -20)
        ])
    }
}
