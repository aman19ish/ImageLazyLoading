//
//  DetailImageViewController.swift
//  ImageLazyLoading
//
//  Created by Aman gupta on 21/06/20.
//  Copyright © 2020 AmanGupta. All rights reserved.
//

import UIKit

class DetailImageViewController: BaseViewController {
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    var viewModel: ImageListViewModel?
    var selectedIndexPath: IndexPath?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = selectedIndexPath {
            collectionView.scrollToItem(at: indexPath, at: .right, animated: false)
        }
    }
    
    // MARK: - Configure View
    private func configureView() {
        collectionView.reloadData()
    }
    
    // MARK: - Action Methods
    
    @IBAction func navBarLeftBackButtonAction(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}

extension DetailImageViewController {
    func updateCollectionViewData() {
        DispatchQueue.main.async { [weak self] in
            var isFreshSetup = false
            //New result so clean up previous cells
            if self?.viewModel?.currentPage == 1 {
                isFreshSetup = true
            }
            if isFreshSetup {
                //Create new cells
                self?.collectionView.contentOffset = CGPoint.zero
                self?.collectionView.reloadData()
            } else {
                //Append new cells
                self?.collectionView.performBatchUpdates({
                    let currentRows = self?.collectionView.numberOfItems(inSection: 0)
                    
                    var itemCount = (self?.viewModel?.getImageDetailListCount() ?? 0) - 1
                    var tempArray = [IndexPath]()
                    
                    while itemCount >= (currentRows ?? 0) {
                        tempArray.append(IndexPath(row: itemCount, section: 0))
                        itemCount -= 1
                    }
                    
                    self?.collectionView.insertItems(at: tempArray)
                }, completion: { (_) in
                    
                })
            }
        }
    }
    
}
