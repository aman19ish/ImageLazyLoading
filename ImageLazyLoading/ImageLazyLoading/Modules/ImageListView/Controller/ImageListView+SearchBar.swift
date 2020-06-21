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
        autoSuggestioncontainerView.isHidden = false
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        autoSuggestioncontainerView.isHidden = true
        searchBar.resignFirstResponder()
        searchBar.text = nil
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            autoSuggestioncontainerView.isHidden = false
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        autoSuggestioncontainerView.isHidden = true
        searchBar.resignFirstResponder()
        if let searchText = searchBar.text {
            fetchImageList(by: searchText)
        }
    }
    
    func fetchImageList(by searchString: String) {
        viewModel.fetchImagesList(searchString: searchString) { [weak self] (success, error) in
            if let error = error {
                self?.showAlertWithHandlers(messageText: error, cancelCompletion: nil, okCompletion: nil)
            }
            self?.autoSuggestionViewController?.fetchSuggestedResult()
            self?.updateCollectionViewData()
        }
    }
    
}
