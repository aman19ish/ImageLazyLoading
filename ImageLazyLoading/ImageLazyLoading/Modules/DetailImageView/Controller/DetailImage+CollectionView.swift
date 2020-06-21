//
//  DetailImage+CollectionView.swift
//  ImageLazyLoading
//
//  Created by Aman gupta on 21/06/20.
//  Copyright © 2020 AmanGupta. All rights reserved.
//

import UIKit

extension DetailImageViewController {
    func setUpCollectionView() {
        registerCells()
        //        layoutCollectionView()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func registerCells() {
        let cells = [DetailImageCollectionViewCell.self]
        collectionView.register(with: cells)
    }

}

// MARK: - UITableViewDataSource Methods
extension DetailImageViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel?.getNumberOfSection() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.getNumberOfRows() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailImageCollectionViewCell.defaultReuseIdentifier, for: indexPath) as? DetailImageCollectionViewCell else { return UICollectionViewCell() }
        
        cell.imageDetailModel = viewModel?.getImageDetailModel(at: indexPath)
        
        fetchNextPageData(indexPath: indexPath)
        return cell
    }
    
    func fetchNextPageData(indexPath: IndexPath) {
        viewModel?.fetchNextPageContent(at: indexPath) { [weak self] (success, error) in
            if let error = error {
                self?.showAlertWithHandlers(messageText: error, cancelCompletion: nil, okCompletion: nil)
            }
            self?.updateCollectionViewData()
        }
    }
    
}

// MARK: - UITableViewDelegate Methods
extension DetailImageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //This function calls everytime when we reload collection view for previous cells. So this check was introduced.
        guard !(viewModel?.isImageDetailListOutOfRange(at: indexPath) ?? true) else {
            return
        }
        viewModel?.updateRquestDownloadedImageURLPriority(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

extension DetailImageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: collectionView.frame.size.height)
    }
}
