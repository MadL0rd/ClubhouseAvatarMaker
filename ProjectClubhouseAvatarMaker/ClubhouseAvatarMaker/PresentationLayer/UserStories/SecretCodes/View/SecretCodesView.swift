//
//  SecretCodesView.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 08.03.2021.
//

import UIKit

final class SecretCodesView: UIView {
    
    let padding: CGFloat = 24
    
    let closeButton = ButtonWithTouchSize()
    
    let scroll = UIScrollView()
    let titleLabel = UILabel()
    let codeTextField = UITextField()
    let useCodeButton = ButtonWithTouchSize()
    
    let tableTitleLabel = UILabel()
    let usedCodesTableView = ContentFittingTableView()
    
    let promotionTitleLabel = UILabel()
    let promotionTextLabel = UILabel()
    let emailLabel = CopyLabelView()

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
        
        addSubview(scroll)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        
        setupCodesMenu()
        setupPromotionInfo()
        
        makeConstraints()
    }
    
    private func setupCodesMenu() {
        scroll.addSubview(titleLabel)
        UIStyleManager.lableTitle(titleLabel)
        titleLabel.text = NSLocalizedString("Use secret code", comment: "")
        
        scroll.addSubview(codeTextField)
        codeTextField.autocapitalizationType = .allCharacters
        UIStyleManager.textFieldDefault(textField: codeTextField,
                                        placeholderText: NSLocalizedString("Enter code here", comment: ""))
        
        scroll.addSubview(useCodeButton)
        UIStyleManager.buttonDark(useCodeButton)
        useCodeButton.setTitle(NSLocalizedString("Apply", comment: ""), for: .normal)
        
        scroll.addSubview(tableTitleLabel)
        tableTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        tableTitleLabel.font = R.font.sfuiTextBold(size: 18)
        tableTitleLabel.textColor = R.color.tintColorDark()
        tableTitleLabel.numberOfLines = 0
        tableTitleLabel.text = NSLocalizedString("Used codes", comment: "")
        
        scroll.addSubview(usedCodesTableView)
        usedCodesTableView.translatesAutoresizingMaskIntoConstraints = false
        usedCodesTableView.estimatedRowHeight = CodeTableViewCell.cellHeight
        usedCodesTableView.rowHeight = UITableView.automaticDimension
        usedCodesTableView.separatorStyle = .none
        usedCodesTableView.allowsSelection = false
        usedCodesTableView.register(CodeTableViewCell.self, forCellReuseIdentifier: CodeTableViewCell.identifier)
    }
    
    private func setupPromotionInfo() {
        let titleText = """
        *This is a service
        for branded and corporate avatars
        """
        let text = """
        How it works?
        1) Write to us that you want to brand your avatar
        2) Choose a plan
        3) Your special frames appears in this app
        4) We send you codes for free using for employees

        Note: you can choose access mode for your frames - public or staff only
        """
        
        scroll.addSubview(promotionTitleLabel)
        promotionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        promotionTitleLabel.textColor = R.color.tintColorDark()
        promotionTitleLabel.numberOfLines = 0
        promotionTitleLabel.font = R.font.sfuiTextBold(size: 18)
        
        var attributedString = NSMutableAttributedString(string: titleText)
        var range: NSRange = attributedString.mutableString.range(of: "branded", options: .caseInsensitive)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.thick.rawValue, range: range)
        range = attributedString.mutableString.range(of: "corporate", options: .caseInsensitive)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.thick.rawValue, range: range)
        promotionTitleLabel.attributedText = attributedString

        scroll.addSubview(promotionTextLabel)
        promotionTextLabel.translatesAutoresizingMaskIntoConstraints = false
        promotionTextLabel.textColor = R.color.tintColorDark()
        promotionTextLabel.numberOfLines = 0
        promotionTextLabel.font = R.font.sfuiTextLight(size: 16)

        attributedString = NSMutableAttributedString(string: text)
        range = attributedString.mutableString.range(of: "How it works?", options: .caseInsensitive)
        attributedString.addAttribute(NSAttributedString.Key.font, value: R.font.sfuiTextBold(size: 16)!, range: range)
        promotionTextLabel.attributedText = attributedString

        scroll.addSubview(emailLabel)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.setText(labelText: Contacts.mainContactEmail, copyText: Contacts.mainContactEmail)
    }

    private func makeConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 25),
            closeButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 25),
            closeButton.widthAnchor.constraint(equalToConstant: 20),
            closeButton.heightAnchor.constraint(equalToConstant: 20),
            
            scroll.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: padding),
            scroll.leftAnchor.constraint(equalTo: leftAnchor),
            scroll.rightAnchor.constraint(equalTo: rightAnchor),
            scroll.bottomAnchor.constraint(equalTo: bottomAnchor),

            titleLabel.topAnchor.constraint(equalTo: scroll.topAnchor, constant: padding),
            titleLabel.leftAnchor.constraint(equalTo: scroll.leftAnchor, constant: padding),
            titleLabel.rightAnchor.constraint(equalTo: scroll.rightAnchor, constant: -padding),
            
            codeTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            codeTextField.leftAnchor.constraint(equalTo: scroll.leftAnchor, constant: padding),
            
            useCodeButton.topAnchor.constraint(equalTo: codeTextField.topAnchor),
            useCodeButton.leftAnchor.constraint(equalTo: codeTextField.rightAnchor, constant: 8),
            useCodeButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding),
            useCodeButton.widthAnchor.constraint(equalTo: useCodeButton.titleLabel!.widthAnchor, constant: padding * 2),
            
            useCodeButton.titleLabel!.widthAnchor.constraint(equalToConstant: useCodeButton.titleLabel!.text!.width(with: useCodeButton.titleLabel!.font)),
            
            tableTitleLabel.topAnchor.constraint(equalTo: codeTextField.bottomAnchor, constant: padding),
            tableTitleLabel.leftAnchor.constraint(equalTo: scroll.leftAnchor, constant: padding),
            tableTitleLabel.rightAnchor.constraint(equalTo: scroll.rightAnchor, constant: -padding),
            
            usedCodesTableView.topAnchor.constraint(equalTo: tableTitleLabel.bottomAnchor, constant: padding / 2),
            usedCodesTableView.leftAnchor.constraint(equalTo: leftAnchor),
            usedCodesTableView.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding),
            
            promotionTitleLabel.topAnchor.constraint(equalTo: usedCodesTableView.bottomAnchor, constant: padding * 2),
            promotionTitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: padding),
            promotionTitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding),

            promotionTextLabel.topAnchor.constraint(equalTo: promotionTitleLabel.bottomAnchor, constant: padding),
            promotionTextLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: padding),
            promotionTextLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding),

            emailLabel.topAnchor.constraint(equalTo: promotionTextLabel.bottomAnchor, constant: padding),
            emailLabel.bottomAnchor.constraint(equalTo: scroll.bottomAnchor, constant: -100),
            emailLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: padding),
            emailLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding)
        ])
    }
}
