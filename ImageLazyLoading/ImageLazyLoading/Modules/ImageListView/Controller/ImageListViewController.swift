//
//  ImageListViewController.swift
//  ImageLazyLoading
//
//  Created by Aman gupta on 20/06/20.
//  Copyright © 2020 AmanGupta. All rights reserved.
//

import UIKit

class ImageListViewController: BaseViewController {
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var autoSuggestioncontainerView: UIView!
    
    // MARK: - Properties
    lazy var viewModel = ImageListViewModel()
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = ImageListViewStringContant.searchImages
        searchBar.showsCancelButton = true
        return searchBar
    }()
    var collectionViewColumns: Int? = ImageListViewContant.defaultNumberOfColumns {
        didSet {
            layoutCollectionView()
        }
    }
    var autoSuggestionViewController: AutoSuggestionViewController?
    var nullView: CommonNullView?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setUpCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - ConfigureView
    func configureView() {
        autoSuggestioncontainerView.isHidden = true
        navigationItem.titleView = searchBar
        collectionViewColumns = ImageListViewContant.defaultNumberOfColumns
        nullView = CommonNullView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 250))
        setUpNullView()
    }
    
    // MARK: - Action Methods
    @IBAction func rightNavBarButtonAction(_ sender: UIBarButtonItem) {
        //Creating alert controller
        let alertController = UIAlertController.init(title: ImageListViewStringContant.changeNumberOfColumns, message: "", preferredStyle: .actionSheet)
        
        //Actions
        let actionOne = UIAlertAction.init(title: "\(ImageListViewContant.twoNumberOfColums)", style: .default) {[weak self] (alertAction) in
            self?.collectionViewColumns = ImageListViewContant.twoNumberOfColums
            
        }
        let actionTwo = UIAlertAction.init(title: "\(ImageListViewContant.threeNumberOfColums)", style: .default) {[weak self] (alertAction) in
            self?.collectionViewColumns = ImageListViewContant.threeNumberOfColums
            
        }
        let actionThree = UIAlertAction.init(title: "\(ImageListViewContant.fourNumberOfColums)", style: .default) {[weak self] (alertAction) in
            self?.collectionViewColumns = ImageListViewContant.fourNumberOfColums
        }
        alertController.addAction(actionOne)
        alertController.addAction(actionTwo)
        alertController.addAction(actionThree)
        
        present(alertController, animated: true, completion: nil)
    }
    
}

extension ImageListViewController {
    func updateCollectionViewData() {
        DispatchQueue.main.async { [weak self] in
            var isFreshSetup = false
            //New result so clean up previous cells
            if self?.viewModel.currentPage == 1 {
                isFreshSetup = true
            }
            self?.setUpNullView()
            if isFreshSetup {
                //Create new cells
                self?.collectionView.contentOffset = CGPoint.zero
                self?.collectionView.reloadData()
            } else {
                //Append new cells
                self?.collectionView.performBatchUpdates({
                    let currentRows = self?.collectionView.numberOfItems(inSection: 0)
                    
                    var itemCount = (self?.viewModel.getImageDetailListCount() ?? 0) - 1
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
    
    func setUpNullView() {
        if let nullView = nullView {
            if viewModel.getNumberOfRows() <= 0 {
                if viewModel.searchString.count == 0 {
                    nullView.configureView(nullImage: UIImageNameConstants.nullSearchIcon, nullMessage: String(format: ImageListViewStringContant.search, viewModel.searchString))
                } else {
                    nullView.configureView(nullImage: UIImageNameConstants.nullSearchIcon, nullMessage: String(format: ImageListViewStringContant.weCouldNotFind, viewModel.searchString))
                }
                collectionView.addSubview(nullView)
            } else {
                nullView.removeFromSuperview()
            }
            nullView.center = CGPoint(x: UIScreen.main.bounds.size.width / 2 , y: UIScreen.main.bounds.size.height / 2)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let autoSuggestionViewController = segue.destination as? AutoSuggestionViewController else { return }
        autoSuggestionViewController.selectSearchSuggestedItem = { [weak self] autoSuggestionModel in
            self?.searchBar.searchTextField.text = autoSuggestionModel.successfullSearchString
            self?.autoSuggestioncontainerView.isHidden = true
            self?.fetchImageList(by: autoSuggestionModel.successfullSearchString)
        }
        self.autoSuggestionViewController = autoSuggestionViewController
    }
    
}
