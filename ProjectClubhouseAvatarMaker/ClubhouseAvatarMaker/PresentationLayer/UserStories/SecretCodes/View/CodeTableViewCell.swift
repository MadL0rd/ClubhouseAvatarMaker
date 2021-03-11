//
//  CodeTableViewCell.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 11.03.2021.
//

import UIKit

class CodeTableViewCell: UITableViewCell {
    
    static let identifier: String = "CodeTableViewCell"
    static let cellHeight: CGFloat = 48
    
    let padding: CGFloat = 48
    
    let stack = UIStackView()
    let codeLabel = UILabel()
    let brandLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - Public methods
    
    func setSecretCode(_ code: SecretCode) {
        brandLabel.text = code.brand
        codeLabel.text = code.code
    }
    
    // MARK: - Private setup methods
    
    private func setupView() {
        backgroundColor = R.color.main()
        
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 2
        stack.isUserInteractionEnabled = false
        
        stack.addArrangedSubview(codeLabel)
        codeLabel.translatesAutoresizingMaskIntoConstraints = false
        codeLabel.font = R.font.sfuiTextBold(size: 16)
        codeLabel.textAlignment = .left
        codeLabel.isUserInteractionEnabled = false
        
        stack.addArrangedSubview(brandLabel)
        brandLabel.translatesAutoresizingMaskIntoConstraints = false
        brandLabel.font = R.font.sfuiTextLight(size: 14)
        brandLabel.textAlignment = .left
        brandLabel.isUserInteractionEnabled = false
        brandLabel.numberOfLines = 2
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            stack.leftAnchor.constraint(equalTo: leftAnchor, constant: padding),
            stack.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding),
            stack.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
