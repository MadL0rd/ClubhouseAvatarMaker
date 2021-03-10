//
//  SecretCodesView.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 08.03.2021.
//

import UIKit

final class SecretCodesView: UIView {
    
    let closeButton = ButtonWithTouchSize()
    
    let titleLabel = UILabel()
    let codeTextField = UITextField()
    let useCodeButton = ButtonWithTouchSize()
    
    let usedCodesTableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }

    // MARK: - Private methods
    
    private func setupView() {
        backgroundColor = R.color.main()
        
        addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setImage(R.image.cross(), for: .normal)
        closeButton.setImage(R.image.cross(), for: .highlighted)
        
        addSubview(titleLabel)
        UIStyleManager.lableTitle(titleLabel)
        titleLabel.text = NSLocalizedString("Use secret code", comment: "")
        
        addSubview(codeTextField)
        codeTextField.autocapitalizationType = .allCharacters
        UIStyleManager.textFieldDefault(textField: codeTextField,
                                        placeholderText: NSLocalizedString("Enter code here", comment: ""))
        
        addSubview(useCodeButton)
        UIStyleManager.buttonDark(useCodeButton)
        useCodeButton.setTitle(NSLocalizedString("Apply", comment: ""), for: .normal)
        
        makeConstraints()
    }

    private func makeConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 25),
            closeButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 25),
            closeButton.widthAnchor.constraint(equalToConstant: 20),
            closeButton.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 50),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            
            codeTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            codeTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            
            useCodeButton.topAnchor.constraint(equalTo: codeTextField.topAnchor),
            useCodeButton.leftAnchor.constraint(equalTo: codeTextField.rightAnchor, constant: 8),
            useCodeButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            useCodeButton.widthAnchor.constraint(equalTo: useCodeButton.titleLabel!.widthAnchor, constant: 48),
            
            useCodeButton.titleLabel!.widthAnchor.constraint(equalToConstant: useCodeButton.titleLabel!.text!.width(with: useCodeButton.titleLabel!.font))
        ])
    }
}
