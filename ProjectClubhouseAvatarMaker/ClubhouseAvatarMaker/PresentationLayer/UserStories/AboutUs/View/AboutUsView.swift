//
//  AboutUsView.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 19.02.2021.
//

import UIKit

final class AboutUsView: UIView {
    
    let titleLabel = UILabel()

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
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = R.font.gilroyBold(size: 20)
        titleLabel.text = NSLocalizedString("About us", comment: "")
        titleLabel.textColor = R.color.tintColorDark()

        makeConstraints()
    }

    private func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: topAnchor, constant: UIConstants.navigationBarCenterY),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
