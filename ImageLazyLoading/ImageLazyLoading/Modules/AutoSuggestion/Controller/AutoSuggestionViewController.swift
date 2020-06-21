//
//  AutoSuggestionViewController.swift
//  ImageLazyLoading
//
//  Created by Aman gupta on 21/06/20.
//  Copyright © 2020 AmanGupta. All rights reserved.
//

import UIKit

class AutoSuggestionViewController: BaseViewController {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    
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

extension AutoSuggestionViewController {
    // MARK: - Keyboard notifications
       //Method to hide keyboard from screen
       override func keyboardWillDisappear(notification: NSNotification) {
           tableViewBottomConstraint.constant = 0.0
       }
       
       //Method to present keyboard on screen
       override func keyboardWillAppear(notification: NSNotification) {
           if #available(iOS 11.0, *) {
               tableViewBottomConstraint.constant = (ImageLazyLoadingUtilityMethods.getKeyboardHeightBy(notification: notification) ?? tableViewBottomConstraint.constant) - view.safeAreaInsets.bottom
           } else {
               tableViewBottomConstraint.constant = ImageLazyLoadingUtilityMethods.getKeyboardHeightBy(notification: notification) ?? tableViewBottomConstraint.constant
           }
           view.layoutIfNeeded()
       }
}
