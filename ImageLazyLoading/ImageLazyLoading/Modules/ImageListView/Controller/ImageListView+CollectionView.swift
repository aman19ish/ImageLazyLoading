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
    
    func layoutCollectionView() {
        DispatchQueue.main.async { [weak self] in
            //Layout collection view according to number of columns
            guard let strongSelf = self,
                let flowlayout = strongSelf.collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
                return
            }
            
            let sideLength = strongSelf.collectionView.frame.size.width / CGFloat((strongSelf.collectionViewColumns ?? 2))
            
            strongSelf.collectionView.performBatchUpdates({
                flowlayout.itemSize = CGSize(width: sideLength, height: sideLength)
            }, completion: { (_) in
                
            })
            
        }
        
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
        
        cell.imageDetailModel = viewModel.getImageDetailModel(at: indexPath)
        
        fetchNextPageData(indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let loaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LoaderCollectionReusableView.defaultReuseIdentifier, for: indexPath) as? LoaderCollectionReusableView else { return UICollectionReusableView() }
        
        loaderView.activityIndicator.isHidden = viewModel.viewState == .loading ? false : true
        viewModel.viewState == .loading ? loaderView.activityIndicator.startAnimating() : loaderView.activityIndicator.stopAnimating()
        
        return loaderView
    }
    
    func fetchNextPageData(indexPath: IndexPath) {
        viewModel.fetchNextPageContent(at: indexPath) { [weak self] (success, error) in
            if let error = error {
                self?.showAlertWithHandlers(messageText: error, cancelCompletion: nil, okCompletion: nil)
            }
            self?.updateCollectionViewData()
        }
    }
    
}

// MARK: - UITableViewDelegate Methods
extension ImageListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //This function calls everytime when we reload collection view for previous cells. So this check was introduced.
        guard !viewModel.isImageDetailListOutOfRange(at: indexPath) else {
            return
        }
        viewModel.updateRquestDownloadedImageURLPriority(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

extension ImageListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
         return CGSize(width: collectionView.frame.size.width, height: 44)
     }
    
}
