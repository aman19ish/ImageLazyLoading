//
//  AutoSuggestionViewController.swift
//  ImageLazyLoading
//
//  Created by Aman gupta on 21/06/20.
//  Copyright © 2020 AmanGupta. All rights reserved.
//

import UIKit

class AutoSuggestionViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    lazy var viewModel = AutoSuggestionViewModel()
    var selectSearchSuggestedItem: ( (_ autoSuggestionModel: AutoSuggestionModel) -> Void)?

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Configure View
    private func configureView() {
        fetchSuggestedResult()
    }
        
}

// MARK: - Helper Methods
extension AutoSuggestionViewController {
    func fetchSuggestedResult() {
        viewModel.getSuggestedResult { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}
