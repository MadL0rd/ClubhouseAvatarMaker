//
//  EditorViewController.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 17.02.2021.
//

import UIKit

final class EditorViewController: UIViewController {

    var viewModel: EditorViewModelProtocol!
    var coordinator: EditorCoordinatorProtocol!
    
    var currentPhoto = R.image.defaultPhoto() {
        didSet {
            DispatchQueue.main.async { [ weak self ] in
                self?._view.setNewPhoto(self?.currentPhoto)
            }
        }
    }
    
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
    }
    
    // MARK: - UI elements actions

    @objc private func selectNewPhoto() {
        viewModel.pickNewPhotoFromAssets(changePhoto(asset:))
    }
    
    func changePhoto(asset: ImageAssetProtocol) {
        asset.loadOriginalImage { [ weak self ] result in
            switch result {
            case let .success(image):
                self?.currentPhoto = image
            case let .failure(error):
                print(error)
            }
        }
    }
}

// MARK: - UICollectionViewDataSource

extension EditorViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        cell.avatar.photo.image = currentPhoto
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension EditorViewController: UICollectionViewDelegate {
    
}
