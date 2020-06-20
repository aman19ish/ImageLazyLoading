//
//  ImageListView+CollectionView.swift
//  ImageLazyLoading
//
//  Created by Aman gupta on 20/06/20.
//  Copyright © 2020 AmanGupta. All rights reserved.
//

import UIKit

extension ImageListViewController {
    func setUpCollectionView() {
        registerCells()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func registerCells() {
        let cells = [ImageCollectionViewCell.self]
        collectionView.register(with: cells)
    }
    
}

// MARK: - UITableViewDataSource Methods
extension ImageListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.getNumberOfSection()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.defaultReuseIdentifier, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let loaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LoaderCollectionReusableView.defaultReuseIdentifier, for: indexPath) as? LoaderCollectionReusableView else { return UICollectionReusableView() }
        
        loaderView.activityIndicator.isHidden = true
        return loaderView
    }
    
}

// MARK: - UITableViewDelegate Methods
extension ImageListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
