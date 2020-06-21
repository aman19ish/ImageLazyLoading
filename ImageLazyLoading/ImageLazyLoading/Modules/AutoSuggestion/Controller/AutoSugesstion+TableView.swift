//
//  AutoSugesstion+TableView.swift
//  ImageLazyLoading
//
//  Created by Aman gupta on 21/06/20.
//  Copyright © 2020 AmanGupta. All rights reserved.
//

import UIKit

// MARK: - Setup TableView
extension AutoSuggestionViewController {
    func setUpTableView() {
        registerCells()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func registerCells() {
        let cells = [AutoSuggestionTableViewCell.self]
        tableView.register(with: cells)
    }
}

// MARK: - UITableViewDataSource Methods
extension AutoSuggestionViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getNumberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRaws(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AutoSuggestionTableViewCell.defaultReuseIdentifier,
                                                       for: indexPath) as? AutoSuggestionTableViewCell else { return UITableViewCell() }
        
        cell.autoSuggestionModel = viewModel.getAutoSuggestionModel(at: indexPath)
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate Methods
extension AutoSuggestionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let model = viewModel.getAutoSuggestionModel(at: indexPath) {
            selectSearchSuggestedItem?(model)
        }
    }
    
}
