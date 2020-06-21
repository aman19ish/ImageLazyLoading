//
//  AutoSuggestionTableViewCell.swift
//  ImageLazyLoading
//
//  Created by Aman gupta on 21/06/20.
//  Copyright © 2020 AmanGupta. All rights reserved.
//

import UIKit

class AutoSuggestionTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var autoSuggestionLabel: UILabel!
    
    // MARK: - Properties
    var autoSuggestionModel: AutoSuggestionModel? {
        didSet {
            if let model = autoSuggestionModel {
                autoSuggestionLabel.text = model.successfullSearchString
            }
        }
    }
    
    // MARK: - Cell Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
        
}
