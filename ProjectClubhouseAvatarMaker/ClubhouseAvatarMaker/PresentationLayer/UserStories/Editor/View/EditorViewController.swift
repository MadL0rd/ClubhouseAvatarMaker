//
//  EditorViewController.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 17.02.2021.
//

import UIKit
import CropViewController
import CCBottomRefreshControl

final class EditorViewController: UIViewController {
    
    var viewModel: EditorViewModelProtocol!
    var coordinator: EditorCoordinatorProtocol!
    
    private let vibroGeneratorLight = UIImpactFeedbackGenerator(style: .light)
    
    private var cropViewController: CropViewController? {
        didSet {
            _view.recropButton.isHidden = false
        }
    }
    private var currentPhoto = R.image.defaultPhoto() {
        didSet {
            DispatchQueue.main.async { [ weak self ] in
                self?._view.setNewPhoto(self?.currentPhoto)
            }
        }
    }
    private var selectedBorderColor: UIColor? {
        didSet {
            viewModel.defaults.selectedBorderColor = selectedBorderColor
            enableNewBorderColor()
        }
    }
    
    private var showNewUserIcon: Bool {
        get {
            viewModel.defaults.showNewUserIcon
        }
        set {
            viewModel.defaults.showNewUserIcon = newValue
        }
    }
    private var showMuteIcon: Bool {
        get {
            viewModel.defaults.showMuteIcon
        }
        set {
            viewModel.defaults.showMuteIcon = newValue
        }
    }
    private var addEmoji: Bool {
        get {
            viewModel.defaults.addEmoji
        }
        set {
            viewModel.defaults.addEmoji = newValue
        }
    }
    private var cellsEmojiCenter: CGPoint?

    private var _view: EditorView {
        return view as! EditorView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func loadView() {
        self.view = EditorView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSelf()
    }
    
    private func configureSelf() {
        _view.showAvatar()
        _view.avatar.emojiView.delegate = self
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [ weak self ] in
            guard let self = self
            else { return }
            self.locationDidChanged(emojiContainer: self._view.avatar.emojiView)
        }
        
        viewModel.checkSubscriptionsStatus(force: true, { _ in })

        _view.photosCollectionView.dataSource = self
        _view.photosCollectionView.delegate = self
        _view.photosCollectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        
        let bottomRefreshController = UIRefreshControl()
        bottomRefreshController.tintColor = R.color.main()
        bottomRefreshController.triggerVerticalOffset = 50
        bottomRefreshController.addTarget(self, action: #selector(loadNextPage), for: .valueChanged)

        _view.photosCollectionView.bottomRefreshControl = bottomRefreshController
        
        _view.colorsCollectionView.dataSource = self
        _view.colorsCollectionView.delegate = self
        _view.colorsCollectionView.register(ColorCollectionViewCell.self, forCellWithReuseIdentifier: ColorCollectionViewCell.identifier)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(avatarDidTapped))
        _view.avatar.addGestureRecognizer(tap)
        _view.avatar.borderTintColor = selectedBorderColor
        
        _view.saveButton.addTarget(self, action: #selector(saveCurrentImage(sender:)), for: .touchUpInside)
        _view.aboutButton.addTarget(self, action: #selector(openAboutUsPage(sender:)), for: .touchUpInside)
        _view.recropButton.addTarget(self, action: #selector(recropImage(sender:)), for: .touchUpInside)
        _view.pickColorButton.addTarget(self, action: #selector(pickCustomColor(sender:)), for: .touchUpInside)

        _view.newUserSwitchButton.addTarget(self, action: #selector(switchButtonTapped(button:)), for: .touchUpInside)
        _view.muteSwitchButton.addTarget(self, action: #selector(switchButtonTapped(button:)), for: .touchUpInside)
        _view.emojiSwitchButton.addTarget(self, action: #selector(switchButtonTapped(button:)), for: .touchUpInside)
        
        loadDefaults()
    }
    
    private func loadDefaults() {
        _view.avatar.emojiView.emoji = viewModel.defaults.emoji
        emojiDidChanged(emojiContainer: _view.avatar.emojiView, emoji: viewModel.defaults.emoji)
        
        if viewModel.defaults.avatarEmojiCenterX != 0,
           viewModel.defaults.avatarEmojiCenterY != 0 {
            let point = CGPoint(x: CGFloat(viewModel.defaults.avatarEmojiCenterX),
                                y: CGFloat(viewModel.defaults.avatarEmojiCenterY))
            _view.avatar.emojiView.applyMoveModificator(topLeftPoint: point)
        }
        
        if !showMuteIcon {
            _view.muteSwitchButton.setBlocked(animated: false)
        }
        if !addEmoji {
            _view.emojiSwitchButton.setBlocked(animated: false)
            _view.manageEmojiViewVisibility(visible: false)
        }
        if !showNewUserIcon {
            _view.newUserSwitchButton.setBlocked(animated: false)
        }
        
        selectedBorderColor = viewModel.defaults.selectedBorderColor
    }
    
    // MARK: - Private methods
    
    private func cropSelectedImage(_ image: UIImage) {
        let cropController = CropViewController(croppingStyle: .default, image: image)
        cropController.delegate = self
        cropController.aspectRatioPreset = .presetSquare
        cropController.aspectRatioLockEnabled = true
        cropController.toolbar.clampButtonHidden = true
        cropController.toolbar.resetButtonHidden = true
        cropController.toolbar.tintColor = R.color.tintColorLight()
        cropController.modalPresentationStyle = .fullScreen
        present(cropController, animated: true, completion: nil)
    }
    
    private func enableNewBorderColor() {
        UIView.transition(with: _view.avatar.borderView,
                          duration: 0.3,
                          options: .transitionCrossDissolve) { [ weak self ] in
            self?._view.avatar.borderTintColor = self?.selectedBorderColor
        }
        _view.photosCollectionView.reloadData()
    }
    
    // MARK: - UI elements actions
    
    @objc private func avatarDidTapped() {
        _view.avatar.tapAnimation()
        vibroGeneratorLight.impactOccurred()
        
        //        TODO: editing test
//        self.pickNewPhoto()
        viewModel.checkSubscriptionsStatus { [ weak self ] isActive in
            guard let self = self
            else { return }
            switch isActive {
            case .active:
                self.pickNewPhoto()
            case .notPurchased:
                self.coordinator.openSubscribtion(output: self)
            }
        }
    }
    
    private func pickNewPhoto() {
        guard viewModel.authorizationStatusIsOK
        else {
            showErrorAlert(with: NSLocalizedString("To pick photo you should provide this app access to gallery", comment: "")) { [ weak self ] in
                self?.viewModel.openSettings()
            }
            return
        }
        viewModel.pickNewPhotoFromAssets(changePhoto(asset:))
    }
    
    private func changePhoto(asset: ImageAssetProtocol) {
        asset.loadOriginalImage { [ weak self ] result in
            switch result {
            case let .success(image):
                DispatchQueue.main.async {
                    self?.cropSelectedImage(image)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    @objc private func saveCurrentImage(sender: UIButton) {
        guard let currentPhoto = currentPhoto
        else { return }
        sender.tapAnimation()
        vibroGeneratorLight.impactOccurred()
        guard viewModel.authorizationStatusIsOK else {
            showErrorAlert(with: NSLocalizedString("To save photo you should provide this app access to gallery", comment: "")) { [ weak self ] in
                self?.viewModel.openSettings()
            }
            return
        }
        var resultPhoto = currentPhoto
        if let border = _view.avatar.border,
           var borderImage = _view.avatar.borderView.image {
            if border.colorable,
               let tintColor = selectedBorderColor {
                borderImage = borderImage.overlayed(by: tintColor)
            }
            resultPhoto = currentPhoto.mergeWith(topImage: borderImage)
        }
        
        if addEmoji,
           let emojiImage = _view.avatar.emojiView.makeImage() {
            resultPhoto = resultPhoto.mergeWith(topImage: emojiImage)
        }
        UIImageWriteToSavedPhotosAlbum(resultPhoto, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc private func openAboutUsPage(sender: UIButton) {
        sender.tapAnimation()
        coordinator.openAboutUs()
    }
    
    @objc private func recropImage(sender: UIButton) {
        guard let cropController = cropViewController
        else { return }
        sender.tapAnimation()
        present(cropController, animated: true, completion: nil)
        
        vibroGeneratorLight.impactOccurred()
    }
    
    @objc private func switchButtonTapped(button: TwoStateButton) {
        switch button {
        case _view.muteSwitchButton:
            showMuteIcon = !button.viewState
            
        case _view.emojiSwitchButton:
            addEmoji = !button.viewState
            _view.manageEmojiViewVisibility(visible: addEmoji)

        case _view.newUserSwitchButton:
            showNewUserIcon = !button.viewState
            
        default:
            return
        }
        _view.photosCollectionView.reloadData()
        button.tapAnimation()
        button.toggle()
        vibroGeneratorLight.impactOccurred()
    }
    
    @objc private func pickCustomColor(sender: UIButton) {
        sender.tapAnimation()
        vibroGeneratorLight.impactOccurred()
        showAlertWithColorPicker(startColor: selectedBorderColor) { [ weak self ] color in
            self?.selectedBorderColor = color
        }
    }
    
    @objc private func loadNextPage() {
        viewModel.loadNextPage { [ weak self ] in
            self?._view.photosCollectionView.bottomRefreshControl?.endRefreshing()
            if self?.viewModel.canLoadNextPage == false {
                self?._view.photosCollectionView.bottomRefreshControl = nil
            }
            self?._view.photosCollectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension EditorViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case _view.photosCollectionView:
            return viewModel.borders.count
        case _view.colorsCollectionView:
            return viewModel.colors.count
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell!
        switch collectionView {
        case _view.photosCollectionView:
            let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
            photoCell.avatar.photo.image = currentPhoto
            if let border = viewModel.borders[exist: indexPath.row] {
                photoCell.avatar.setBorder(border, animated: false)
                photoCell.avatar.emojiView.isHidden = !addEmoji
                if addEmoji {
                    photoCell.avatar.emojiView.emoji = _view.avatar.emojiView.emoji
                    if let emojiCenter = cellsEmojiCenter {
                        photoCell.avatar.emojiView.applyMoveModificator(topLeftPoint: emojiCenter)
                    }
                }
                photoCell.avatar.borderTintColor = selectedBorderColor
                photoCell.manageColorableIconVisibility(visible: border.colorable)
                photoCell.nameLabel.text = border.title ?? PhotoCollectionViewCell.defaultName
                photoCell.muteView.isHidden = !showMuteIcon
                photoCell.newUserView.isHidden = !showNewUserIcon
            }
            cell = photoCell
            
        case _view.colorsCollectionView:
            let colorCell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCollectionViewCell.identifier, for: indexPath) as! ColorCollectionViewCell
            colorCell.backgroundColor = viewModel.colors[exist: indexPath.row]
            cell = colorCell
            
        default:
            break
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension EditorViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case _view.photosCollectionView:
            guard let cell = collectionView.cellForItem(at: indexPath) as? PhotoCollectionViewCell
            else { return }
            cell.tapAnimation()
            if let border = viewModel.borders[exist: indexPath.row] {
                _view.avatar.setBorder(border)
                _view.manageColorsCollectionViewVisibility(visible: border.colorable)
                vibroGeneratorLight.impactOccurred()
            }
            
        case _view.colorsCollectionView:
            guard let cell = collectionView.cellForItem(at: indexPath),
                  let color = viewModel.colors[exist: indexPath.row]
            else { return }
            cell.tapAnimation()
            vibroGeneratorLight.impactOccurred()
            selectedBorderColor = color
            
        default:
            break
        }
    }
}

// MARK: - CropViewControllerDelegate

extension EditorViewController: CropViewControllerDelegate {
    
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        cropViewController.dismiss(animated: true, completion: nil)
        self.cropViewController = cropViewController
        currentPhoto = image
    }
}

// MARK: - CropViewControllerDelegate

extension EditorViewController {
    
    // Called when image save is complete (with error or not)
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("ERROR: \(error)")
        }
        else {
            _view.showSaveSuccessMessage()
        }
    }
    
    private func showAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - EmojiContainerDelegate

extension EditorViewController: EmojiContainerDelegate {
    
    func locationDidChanged(emojiContainer: EmojiContainer) {
        viewModel.defaults.avatarEmojiCenterX = Float(emojiContainer.center.x)
        viewModel.defaults.avatarEmojiCenterY = Float(emojiContainer.center.y)

        let cellX = emojiContainer.center.x / _view.avatar.frame.width * PhotoCollectionViewCell.avatarWidth
        let cellY = emojiContainer.center.y / _view.avatar.frame.height * PhotoCollectionViewCell.avatarWidth
        cellsEmojiCenter = CGPoint(x: cellX, y: cellY)
        _view.photosCollectionView.reloadData()
    }
    
    func emojiDidChanged(emojiContainer: EmojiContainer, emoji: String) {
        viewModel.defaults.emoji = emoji
        _view.photosCollectionView.reloadData()
        _view.emojiSwitchButton.setTitle(emoji, for: .normal)
    }
}

// MARK: - SubscriptionOutput

extension EditorViewController: SubscriptionOutput {
    
    func subscriptionStatusDidChanged() {
        viewModel.checkSubscriptionsStatus(force: true, { _ in })
    }
}
