//
//  EditorViewController.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 17.02.2021.
//

import UIKit
import CropViewController

final class EditorViewController: UIViewController {
    
    var viewModel: EditorViewModelProtocol!
    var coordinator: EditorCoordinatorProtocol!
    
    private let vibroGeneratorLight = UIImpactFeedbackGenerator(style: .light)
    
    private var lastPickedPhoto: UIImage?
    private var lastSelectedPhoto: UIImage? {
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
    private var selectedBorderColor = R.color.backgroundDark()
    
    private var showNewUserIcon = true
    private var showMuteIcon = true
    private var addEmoji = true

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
        
        _view.photosCollectionView.dataSource = self
        _view.photosCollectionView.delegate = self
        _view.photosCollectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectNewPhoto))
        _view.avatar.addGestureRecognizer(tap)
        _view.avatar.borderTintColor = selectedBorderColor
        
        _view.saveButton.addTarget(self, action: #selector(saveCurrentImage(sender:)), for: .touchUpInside)
        _view.recropButton.addTarget(self, action: #selector(recropImage(sender:)), for: .touchUpInside)
        
        _view.newUserSwitchButton.addTarget(self, action: #selector(switchButtonTapped(button:)), for: .touchUpInside)
        _view.muteSwitchButton.addTarget(self, action: #selector(switchButtonTapped(button:)), for: .touchUpInside)
        _view.emojiSwitchButton.addTarget(self, action: #selector(switchButtonTapped(button:)), for: .touchUpInside)
    }
    
    // MARK: - Private methods
    
    private func cropSelectedImage(_ image: UIImage) {
        let cropController = CropViewController(croppingStyle: .default, image: image)
        cropController.delegate = self
        cropController.aspectRatioPreset = .presetSquare
        cropController.aspectRatioLockEnabled = true
        cropController.toolbar.clampButtonHidden = true
        cropController.toolbar.resetButtonHidden = true
        cropController.modalPresentationStyle = .fullScreen
        present(cropController, animated: true, completion: nil)
    }
    
    // MARK: - UI elements actions
    
    @objc private func selectNewPhoto() {
        _view.avatar.tapAnimation()
        vibroGeneratorLight.impactOccurred()
        viewModel.pickNewPhotoFromAssets(changePhoto(asset:))
    }
    
    private func changePhoto(asset: ImageAssetProtocol) {
        asset.loadOriginalImage { [ weak self ] result in
            switch result {
            case let .success(image):
                self?.lastPickedPhoto = image
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
        var resultPhoto = currentPhoto
        if let borderImage = _view.avatar.border?.image {
            resultPhoto = currentPhoto.mergeWith(topImage: borderImage)
        }
        UIImageWriteToSavedPhotosAlbum(resultPhoto, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc private func recropImage(sender: UIButton) {
        guard let image = lastSelectedPhoto
        else { return }
        sender.tapAnimation()
        cropSelectedImage(image)
    }
    
    @objc private func switchButtonTapped(button: TwoStateButton) {
        switch button {
        case _view.muteSwitchButton:
            showMuteIcon = !button.viewState
        case _view.emojiSwitchButton:
            addEmoji = !button.viewState
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
}

// MARK: - UICollectionViewDataSource

extension EditorViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.borders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        cell.avatar.photo.image = currentPhoto
        if let border = viewModel.borders[exist: indexPath.row] {
            cell.avatar.setBorder(border, animated: false)
            cell.avatar.borderTintColor = selectedBorderColor
            cell.manageColorableIconVisibility(visible: border.colorable)
            cell.nameLabel.text = border.title ?? PhotoCollectionViewCell.defaultName
            cell.muteView.isHidden = !showMuteIcon
            cell.newUserView.isHidden = !showNewUserIcon
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension EditorViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? PhotoCollectionViewCell
        else { return }
        cell.tapAnimation()
        if let border = cell.avatar.border {
            _view.avatar.setBorder(border)
            vibroGeneratorLight.impactOccurred()
        }
    }
}

// MARK: - CropViewControllerDelegate

extension EditorViewController: CropViewControllerDelegate {
    
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        cropViewController.dismiss(animated: true, completion: nil)
        if lastPickedPhoto != nil {
            lastSelectedPhoto = lastPickedPhoto
            lastPickedPhoto = nil
        }
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
            //        TODO: make new save animation
            self.showAlert("Image saved", message: "The iamge is saved into your Photo Library.")
        }
    }
    
    private func showAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
