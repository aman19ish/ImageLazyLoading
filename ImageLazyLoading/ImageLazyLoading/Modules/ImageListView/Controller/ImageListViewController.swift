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
    
    // MARK: - Properties
    lazy var viewModel = ImageListViewModel()
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = ImageListViewStringContant.searchImages
        searchBar.showsCancelButton = true
        return searchBar
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - ConfigureView
    func configureView() {
        self.navigationItem.titleView = searchBar
    }
    
    // MARK: - Action Methods
    
}

