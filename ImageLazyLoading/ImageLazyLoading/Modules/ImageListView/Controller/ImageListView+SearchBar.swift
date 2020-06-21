//
//  ImageListView+SearchBar.swift
//  ImageLazyLoading
//
//  Created by Aman gupta on 20/06/20.
//  Copyright © 2020 AmanGupta. All rights reserved.
//

import UIKit

extension ImageListViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = nil
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let searchText = searchBar.text {
            viewModel.fetchImagesList(searchString: searchText) { [weak self] (success, error) in
                if let error = error {
                    self?.showAlertWithHandlers(messageText: error, cancelCompletion: nil, okCompletion: nil)
                }
                self?.updateCollectionViewData()
            }
        }
    }
    
}
