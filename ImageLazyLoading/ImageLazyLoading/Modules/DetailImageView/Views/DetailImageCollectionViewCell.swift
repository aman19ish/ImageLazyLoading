//
//  DetailImageCollectionViewCell.swift
//  ImageLazyLoading
//
//  Created by Aman gupta on 21/06/20.
//  Copyright © 2020 AmanGupta. All rights reserved.
//

import UIKit

class DetailImageCollectionViewCell: UICollectionViewCell {
    // MARK: - Outlest
    @IBOutlet weak var displayImageView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: - Properties
    var imageDetailModel: ImageDetailModel? {
        didSet {
            if let model = imageDetailModel {
                displayImageView.image = UIImage(named: "placeHolderImage")
                activityIndicatorView.isHidden = false
                activityIndicatorView.startAnimating()
                if let largeImageURL = model.largeImageURL {
                    ImageManager.shared.downloadImage(imageURL: largeImageURL) { [weak self] (imageURL, image) in
                        if imageURL == largeImageURL, let image = image {
                            DispatchQueue.main.async {
                                self?.activityIndicatorView.isHidden = true
                                self?.activityIndicatorView.stopAnimating()
                                self?.displayImageView.image = image
                            }
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Cell Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
