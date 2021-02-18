//
//  PhotoCollectionViewCell.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 17.02.2021.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "PhotoCollectionViewCell"
    
    let avatar = AvatarView()
    let muteView = UIImageView(image: R.image.mute())
    let newUserView = UIImageView(image: R.image.newUser())
    let colorableIconImageView = UIImageView(image: R.image.colorableIcon())
    let nameLabel = UILabel()
    
    let avatarWidth: CGFloat = 77
    let indicatorsWidth: CGFloat = 27
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - Public methods
    
    func manageColorableIconVisibility(visible: Bool) {
        colorableIconImageView.isHidden = !visible
        if visible {
            nameLabel.transform = .init(translationX: 6, y: 0)
            let angle = .pi / 6 * CGFloat.random(in: 0...1)
            colorableIconImageView.transform = .init(rotationAngle: angle)
        } else {
            nameLabel.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }

    // MARK: - Private setup methods
    
    private func setupView() {
        contentView.addSubview(avatar)
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.setCornerRadiusByWidth(avatarWidth)
        addIndicatorImageView(muteView)
        addIndicatorImageView(newUserView)
        addIndicatorImageView(colorableIconImageView)
        colorableIconImageView.isHidden = true
        
        addSubview(nameLabel)
        nameLabel.textColor = R.color.tintColorDark()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = R.font.gilroyBold(size: 13)
        nameLabel.text = NSLocalizedString("Speaker", comment: "")
        
        makeConstraints()
    }
    
    private func addIndicatorImageView(_ imageView: UIImageView) {
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        imageView.layer.shadowColor = R.color.gray()?.cgColor
        imageView.layer.shadowOpacity = 0.6
        imageView.layer.shadowOffset = CGSize(width: 0, height: 1)
        imageView.layer.shadowRadius = 1
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            avatar.topAnchor.constraint(equalTo: contentView.topAnchor),
            avatar.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            avatar.widthAnchor.constraint(equalToConstant: avatarWidth),
            avatar.heightAnchor.constraint(equalToConstant: avatarWidth),
            
            muteView.heightAnchor.constraint(equalToConstant: indicatorsWidth),
            muteView.widthAnchor.constraint(equalToConstant: indicatorsWidth),
            muteView.bottomAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 4),
            muteView.rightAnchor.constraint(equalTo: avatar.rightAnchor, constant: 4),

            newUserView.heightAnchor.constraint(equalToConstant: indicatorsWidth),
            newUserView.widthAnchor.constraint(equalToConstant: indicatorsWidth),
            newUserView.bottomAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 4),
            newUserView.leftAnchor.constraint(equalTo: avatar.leftAnchor, constant: 2),
            
            colorableIconImageView.heightAnchor.constraint(equalToConstant: indicatorsWidth),
            colorableIconImageView.widthAnchor.constraint(equalToConstant: indicatorsWidth),
            colorableIconImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            colorableIconImageView.leftAnchor.constraint(equalTo: avatar.leftAnchor, constant: -5),
            
            nameLabel.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 13),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
}
