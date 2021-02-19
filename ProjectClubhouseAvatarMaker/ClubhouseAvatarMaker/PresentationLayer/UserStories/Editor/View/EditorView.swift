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
    let emojiView = EmojiContainer()
    
    let saveButton = ButtonWithTouchSize()
    let aboutButton = ButtonWithTouchSize()
    let recropButton = ButtonWithTouchSize()
    let pickColorButton = ButtonWithTouchSize()
    
    let successMessageLabel = PaddingLabel(withInsets: 20, 20, 30, 30)
    private var hideLabelRequestCount: Int = 0
    let duration: TimeInterval = 0.3
    let successLabelHiddenTransform = CGAffineTransform(translationX: 0, y: 80).scaledBy(x: 0.7, y: 0.7)

    let photosCollectionViewLayout = UICollectionViewFlowLayout()
    private(set) var photosCollectionView: UICollectionView!
    
    let colorsCollectionViewLayout = UICollectionViewFlowLayout()
    private(set) var colorsCollectionView: UICollectionView!
    
    let settingsView = UIView()
    let settingsStack = UIStackView()
    let newUserSwitchButton = TwoStateButton()
    let muteSwitchButton = TwoStateButton()
    let emojiSwitchButton = TwoStateButton()
    let buttonSwitchSideSize: CGFloat = 60

    let sideMargin: CGFloat = 25
    
    let photosCellSpacing: CGFloat = 12
    let photoCellHeight: CGFloat = 113
    var photoCellWidth: CGFloat {
        return (UIConstants.screenBounds.width - (sideMargin + photosCellSpacing) * 2) / 3
    }
    
    let colorCellSideSize: CGFloat = ColorCollectionViewCell.colorCellSideSize
    let colorCellSpacing: CGFloat = 6
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    // MARK: - Public methods
    
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
    
    func manageEmojiViewVisibility(visible: Bool) {
        UIView.animate(withDuration: 0.3) { [ weak self ] in
            guard let self = self
            else { return }
            self.emojiView.alpha = visible ? 1 : 0
        }
    }
    
    func manageColorsCollectionViewVisibility(visible: Bool) {
        UIView.animate(withDuration: 0.3) { [ weak self ] in
            guard let self = self
            else { return }
            self.photosCollectionView.transform = .init(translationX: 0, y: visible ? self.colorCellSideSize : 0)
            self.colorsCollectionView.alpha = visible ? 1 : 0
            self.pickColorButton.transform = CGAffineTransform(translationX: visible ? 0 : 150, y: 0)
                .rotated(by: visible ? 0 : .pi / 2)
            self.pickColorButton.alpha = visible ? 1 : 0
        }
    }
    
    func showSaveSuccessMessage() {
        UIView.animate(withDuration: duration) { [ weak self ] in
            self?.successMessageLabel.alpha = 1
            self?.successMessageLabel.transform = .init(translationX: 0, y: 0)
        }
        if hideLabelRequestCount != 0 {
            successMessageLabel.tapAnimation()
        }
        hideLabelRequestCount += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + duration * 5) { [ weak self ] in
            self?.hideSaveSuccessMessage()
        }
    }
    
    func hideSaveSuccessMessage() {
        hideLabelRequestCount -= 1
        if hideLabelRequestCount == 0 {
            UIView.animate(withDuration: duration) { [ weak self ] in
                guard let self = self
                else { return }
                self.successMessageLabel.alpha = 0
                self.successMessageLabel.transform = self.successLabelHiddenTransform
            }
        }
    }

    // MARK: - Private methods
    
    private func setupView() {
        backgroundColor = R.color.main()
        
        addSubview(avatar)
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.alpha = 0
        avatar.setCornerRadiusByWidth(mainAvatarWidth)
        avatar.isUserInteractionEnabled = true
        
        avatar.addSubview(emojiView)
        emojiView.translatesAutoresizingMaskIntoConstraints = false
        emojiView.label.text = "♠"
        emojiView.setSize(avatarSideSize: mainAvatarWidth)
        
        setupButtons()
        setupSuccessMessage()
        setupColorsCollection()
        setupPhotosCollection()
        setupBottomMenu()
        
        makeConstraints()
        makeSettingsConstraints()
    }
    
    private func setupButtons() {
        addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setDefaultAreaPadding()
        saveButton.setImage(R.image.saveButtonTest(), for: .normal)
        saveButton.setImage(R.image.saveButtonTest(), for: .focused)

        addSubview(aboutButton)
        aboutButton.translatesAutoresizingMaskIntoConstraints = false
        aboutButton.setDefaultAreaPadding()
        aboutButton.setImage(R.image.aboutButton(), for: .normal)
        
        addSubview(recropButton)
        recropButton.translatesAutoresizingMaskIntoConstraints = false
        recropButton.setDefaultAreaPadding()
        recropButton.setImage(R.image.cropIcon(), for: .normal)
        recropButton.isHidden = true
        
        addSubview(pickColorButton)
        pickColorButton.translatesAutoresizingMaskIntoConstraints = false
        pickColorButton.setDefaultAreaPadding()
        pickColorButton.setImage(R.image.colorableIcon(), for: .normal)
        pickColorButton.setImage(R.image.colorableIcon(), for: .focused)
        pickColorButton.transform = CGAffineTransform(translationX: 150, y: 0).rotated(by: .pi / 2)
        pickColorButton.alpha = 0
        UIStyleManager.shadow(pickColorButton)
    }
    
    private func setupSuccessMessage() {
        addSubview(successMessageLabel)
        successMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        successMessageLabel.font = R.font.gilroyBold(size: 14)
        successMessageLabel.textColor = R.color.tintColorDark()
        successMessageLabel.backgroundColor = R.color.backgroundLight()
        successMessageLabel.numberOfLines = 0
        successMessageLabel.textAlignment = .center
        let congratulationsText = NSLocalizedString("Congratulations!", comment: "")
        let saveText = NSLocalizedString("New avatar saved to gallery", comment: "")
        successMessageLabel.text = "🎉 \(congratulationsText) 🎉\n\(saveText)"
        successMessageLabel.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner],
                                         radius: 25)
        successMessageLabel.alpha = 0
        successMessageLabel.transform = successLabelHiddenTransform
    }
    
    private func setupColorsCollection() {
        colorsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: colorsCollectionViewLayout)
        addSubview(colorsCollectionView)
        colorsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        colorsCollectionView.backgroundColor = R.color.main()
        colorsCollectionViewLayout.minimumLineSpacing = colorCellSpacing
        colorsCollectionViewLayout.minimumInteritemSpacing = colorCellSpacing
        colorsCollectionViewLayout.scrollDirection = .horizontal
        colorsCollectionViewLayout.itemSize = CGSize(width: colorCellSideSize, height: colorCellSideSize)
        colorsCollectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: colorCellSideSize, bottom: 0, right: colorCellSideSize)
        colorsCollectionView.contentInset = UIEdgeInsets(top: 0, left: colorCellSideSize, bottom: 0, right: colorCellSideSize)
        colorsCollectionView.showsHorizontalScrollIndicator = false
        colorsCollectionView.alpha = 0
    }
    
    private func setupPhotosCollection() {
        photosCollectionView = UICollectionView(frame: .zero, collectionViewLayout: photosCollectionViewLayout)
        addSubview(photosCollectionView)
        photosCollectionView.translatesAutoresizingMaskIntoConstraints = false
        photosCollectionView.backgroundColor = R.color.backgroundLight()
        photosCollectionViewLayout.minimumLineSpacing = photosCellSpacing + 5
        photosCollectionViewLayout.minimumInteritemSpacing = photosCellSpacing
        photosCollectionViewLayout.scrollDirection = .vertical
        photosCollectionViewLayout.itemSize = CGSize(width: photoCellWidth, height: photoCellHeight)
        photosCollectionView.scrollIndicatorInsets = UIEdgeInsets(top: 70, left: 5, bottom: 100, right: 0)
        photosCollectionView.contentInset = UIEdgeInsets(top: sideMargin * 1.7,
                                                         left: sideMargin,
                                                         bottom: sideMargin + 90,
                                                         right: sideMargin)
        photosCollectionView.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 60)
        
    }
    
    private func setupBottomMenu() {
        addSubview(settingsView)
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        settingsView.backgroundColor = R.color.backgroundLight()
        settingsView.layer.cornerRadius = 42
        settingsView.layer.shadowColor = R.color.gray()?.cgColor
        settingsView.layer.shadowOpacity = 0.7
        settingsView.layer.shadowOffset = .zero
        settingsView.layer.shadowRadius = 5
        
        settingsView.addSubview(settingsStack)
        settingsStack.translatesAutoresizingMaskIntoConstraints = false
        settingsStack.axis = .horizontal
        settingsStack.spacing = 25
        settingsStack.distribution = .equalCentering
        
        setupSwitchButton(image: R.image.newUser(), button: newUserSwitchButton)
        setupSwitchButton(image: R.image.mute(), button: muteSwitchButton)
        setupSwitchButton(image: nil, button: emojiSwitchButton)
        emojiSwitchButton.setTitle("🔥", for: .normal)
        emojiSwitchButton.titleLabel?.font = R.font.gilroyBold(size: 45)
        emojiSwitchButton.textChanging = false
    }
    
    private func setupSwitchButton(image: UIImage?, button: TwoStateButton) {
        settingsStack.addArrangedSubview(button)
        UIStyleManager.buttonShadow(button)
        button.interactionAbilityChanging = false
        button.setActive()
        button.duration = 0.25
        button.backgroundColor = R.color.backgroundLight()
        button.setImage(image, for: .normal)
        button.setImage(image, for: .highlighted)
    }

    private func makeConstraints() {
        NSLayoutConstraint.activate([
            avatar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            avatar.centerXAnchor.constraint(equalTo: centerXAnchor),
            avatar.widthAnchor.constraint(equalToConstant: mainAvatarWidth),
            avatar.heightAnchor.constraint(equalToConstant: mainAvatarWidth),
            
            emojiView.leftAnchor.constraint(equalTo: avatar.leftAnchor, constant: 15),
            emojiView.topAnchor.constraint(equalTo: avatar.topAnchor, constant: 15),

            successMessageLabel.bottomAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 10),
            successMessageLabel.centerXAnchor.constraint(equalTo: avatar.centerXAnchor),
            successMessageLabel.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.8),
            
            colorsCollectionView.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: sideMargin / 2),
            colorsCollectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            colorsCollectionView.widthAnchor.constraint(equalTo: widthAnchor),
            colorsCollectionView.heightAnchor.constraint(equalToConstant: colorCellSideSize),
            
            photosCollectionView.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: sideMargin),
            photosCollectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            photosCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            photosCollectionView.widthAnchor.constraint(equalTo: widthAnchor),
            
            saveButton.topAnchor.constraint(equalTo: avatar.topAnchor),
            saveButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -sideMargin),
            saveButton.widthAnchor.constraint(equalToConstant: 50),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            
            aboutButton.topAnchor.constraint(equalTo: avatar.topAnchor),
            aboutButton.leftAnchor.constraint(equalTo: leftAnchor, constant: sideMargin),
            aboutButton.widthAnchor.constraint(equalToConstant: 50),
            aboutButton.heightAnchor.constraint(equalToConstant: 50),
            
            recropButton.bottomAnchor.constraint(equalTo: avatar.bottomAnchor),
            recropButton.leftAnchor.constraint(equalTo: leftAnchor, constant: sideMargin),
            recropButton.widthAnchor.constraint(equalToConstant: 50),
            recropButton.heightAnchor.constraint(equalToConstant: 50),
            
            pickColorButton.bottomAnchor.constraint(equalTo: avatar.bottomAnchor),
            pickColorButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -sideMargin),
            pickColorButton.widthAnchor.constraint(equalToConstant: 50),
            pickColorButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func makeSettingsConstraints() {
        NSLayoutConstraint.activate([
            settingsView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 50),
            settingsView.leftAnchor.constraint(equalTo: leftAnchor),
            settingsView.rightAnchor.constraint(equalTo: rightAnchor),
            settingsView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -90),
            
            settingsStack.topAnchor.constraint(equalTo: settingsView.topAnchor, constant: 15),
            settingsStack.centerXAnchor.constraint(equalTo: settingsView.centerXAnchor),
            settingsStack.widthAnchor.constraint(equalTo: settingsView.widthAnchor, constant: -UIConstants.screenBounds.width * 0.2),
            
            newUserSwitchButton.widthAnchor.constraint(equalToConstant: buttonSwitchSideSize),
            newUserSwitchButton.heightAnchor.constraint(equalToConstant: buttonSwitchSideSize),
            
            muteSwitchButton.widthAnchor.constraint(equalToConstant: buttonSwitchSideSize),
            muteSwitchButton.heightAnchor.constraint(equalToConstant: buttonSwitchSideSize),
            
            emojiSwitchButton.widthAnchor.constraint(equalToConstant: buttonSwitchSideSize),
            emojiSwitchButton.heightAnchor.constraint(equalToConstant: buttonSwitchSideSize)
        ])
    }
}
