//
//  EditorView.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 17.02.2021.
//

import UIKit

final class EditorView: UIView {
    
    let avatar = AvatarView()
    let mainAvatarWidth = UIConstants.screenBounds.width * 0.7
    
    let saveButton = ButtonWithTouchSize()
    let recropButton = ButtonWithTouchSize()
    
    let photosCollectionViewLayout = UICollectionViewFlowLayout()
    private(set) var photosCollectionView: UICollectionView!
    
    let photosCellSpacing: CGFloat = 12
    let sideMargin: CGFloat = 25
    let photoCellHeight: CGFloat = 113
    var photoCellWidth: CGFloat {
        return (UIConstants.screenBounds.width - (sideMargin + photosCellSpacing) * 2) / 3
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    func showAvatar() {
        UIView.animate(withDuration: 0.3) { [ weak self ] in
            self?.avatar.alpha = 1
        }
    }
    
    func setNewPhoto(_ photo: UIImage?) {
        avatar.setPhoto(photo)
        for cell in photosCollectionView.visibleCells {
            guard let cell = cell as? PhotoCollectionViewCell
            else { return }
            cell.avatar.setPhoto(photo)
        }
        photosCollectionView.reloadData()
    }

    // MARK: - Private methods
    
    private func setupView() {
        backgroundColor = R.color.main()
        
        addSubview(avatar)
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.alpha = 0
        avatar.setCornerRadiusByWidth(mainAvatarWidth)
        avatar.isUserInteractionEnabled = true
        
        photosCollectionView = UICollectionView(frame: .zero, collectionViewLayout: photosCollectionViewLayout)
        addSubview(photosCollectionView)
        photosCollectionView.translatesAutoresizingMaskIntoConstraints = false
        photosCollectionView.backgroundColor = R.color.backgroundLight()
        photosCollectionViewLayout.minimumLineSpacing = photosCellSpacing + 5
        photosCollectionViewLayout.minimumInteritemSpacing = photosCellSpacing
        photosCollectionViewLayout.scrollDirection = .vertical
        photosCollectionViewLayout.itemSize = CGSize(width: photoCellWidth, height: photoCellHeight)
        photosCollectionView.scrollIndicatorInsets = UIEdgeInsets(top: 70, left: 5, bottom: 30, right: 0)
        photosCollectionView.contentInset = UIEdgeInsets(top: sideMargin * 1.7,
                                                         left: sideMargin,
                                                         bottom: sideMargin,
                                                         right: sideMargin)
        photosCollectionView.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 60)
        
        addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setDefaultAreaPadding()
        saveButton.setImage(R.image.saveButtonTest(), for: .normal)
        
        addSubview(recropButton)
        recropButton.translatesAutoresizingMaskIntoConstraints = false
        recropButton.setDefaultAreaPadding()
        recropButton.setImage(R.image.cropIcon(), for: .normal)
        recropButton.isHidden = true

        makeConstraints()
    }

    private func makeConstraints() {
        NSLayoutConstraint.activate([
            avatar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            avatar.centerXAnchor.constraint(equalTo: centerXAnchor),
            avatar.widthAnchor.constraint(equalToConstant: mainAvatarWidth),
            avatar.heightAnchor.constraint(equalToConstant: mainAvatarWidth),
            
            photosCollectionView.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: sideMargin),
            photosCollectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            photosCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            photosCollectionView.widthAnchor.constraint(equalTo: widthAnchor),
            
            saveButton.topAnchor.constraint(equalTo: avatar.topAnchor),
            saveButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -sideMargin),
            saveButton.widthAnchor.constraint(equalToConstant: 50),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            
            recropButton.bottomAnchor.constraint(equalTo: avatar.bottomAnchor),
            recropButton.leftAnchor.constraint(equalTo: leftAnchor, constant: sideMargin),
            recropButton.widthAnchor.constraint(equalToConstant: 50),
            recropButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
