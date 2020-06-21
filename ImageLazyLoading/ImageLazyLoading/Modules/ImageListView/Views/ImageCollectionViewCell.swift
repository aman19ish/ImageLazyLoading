//
//  ImageCollectionViewCell.swift
//  ImageLazyLoading
//
//  Created by Aman gupta on 20/06/20.
//  Copyright © 2020 AmanGupta. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet weak var displayImageView: UIImageView!
    
    // MARK: - Properties
    var imageDetailModel: ImageDetailModel? {
        didSet {
            if let model = imageDetailModel {
                displayImageView.image = UIImage(named: "placeHolderImage")
                if let previewURL = model.previewURL {
                    ImageManager.shared.downloadImage(imageURL: previewURL) { [weak self] (imageURL, image) in
                        if imageURL == previewURL, let image = image {
                            DispatchQueue.main.async {
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
        // Initialization code
    }
}
