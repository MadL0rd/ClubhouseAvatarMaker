//
//  AboutUsView.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 19.02.2021.
//

import UIKit

final class AboutUsView: UIView {
    
    let stack = UIStackView()
    let titleLabel = UILabel()
    let folowLabel = UILabel()
    let devLabel = CopyLabelView()
    let designerLabel = CopyLabelView()
    let textLabel = UILabel()
    let emailLabel = CopyLabelView()
    
    let mainText = NSLocalizedString("""
We are Developer and Designer
from Cherry Dev Agency

If you want to make your idea a reality, write to us:
""",
                                     comment: "")
    
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
        
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 40
        
        stack.addArrangedSubview(titleLabel)
        titleLabel.font = R.font.sfuiTextBold(size: 32)
        titleLabel.text = NSLocalizedString("About us", comment: "")
        titleLabel.textColor = R.color.tintColorDark()
        
        stack.addArrangedSubview(folowLabel)
        folowLabel.font = R.font.sfuiTextLight(size: 16)
        folowLabel.text = NSLocalizedString("Folow us in clubhouse:", comment: "")
        folowLabel.textColor = R.color.tintColorDark()
        
        stack.addArrangedSubview(devLabel)
        devLabel.setText(labelText: "👱🏼‍♂️  @madlord", copyText: "@madlord")
        
        stack.addArrangedSubview(designerLabel)
        designerLabel.setText(labelText: "👩🏻  @o.kad", copyText: "@o.kad")
        
        stack.addArrangedSubview(textLabel)
        textLabel.font = R.font.sfuiTextLight(size: 16)
        textLabel.numberOfLines = 0
        let attributedString = NSMutableAttributedString(string: mainText)
        let range: NSRange = attributedString.mutableString.range(of: "Cherry Dev", options: .caseInsensitive)
        attributedString.addAttribute(NSAttributedString.Key.font, value: R.font.sfuiTextBold(size: 16)!, range: range)
        textLabel.attributedText = attributedString

        stack.addArrangedSubview(emailLabel)
        emailLabel.setText(labelText: "Cherry.Dev.Agency@gmail.com", copyText: "Cherry.Dev.Agency@gmail.com")
        
        makeConstraints()
    }

    private func makeConstraints() {
        stack.setCustomSpacing(16, after: devLabel)
        stack.setCustomSpacing(16, after: folowLabel)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor, constant: UIConstants.navigationBarHeight + 30),
            stack.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            stack.rightAnchor.constraint(equalTo: rightAnchor, constant: -24)
        ])
    }
}
