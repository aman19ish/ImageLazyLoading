//
//  CommonNullView.swift
//  ImageLazyLoading
//
//  Created by Aman gupta on 21/06/20.
//  Copyright © 2020 AmanGupta. All rights reserved.
//

import UIKit

class CommonNullView: UIView {
    
    // MARK: - Outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var nullViewMessageLabel: UILabel!
    @IBOutlet weak var nullImageView: UIImageView!
    
    // MARK: - Initlizer
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSubviews()
    }
    
    // MARK: - Configure View
    func initSubviews() {
        Bundle.main.loadNibNamed("CommonNullView", owner: self, options: nil)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(contentView)
    }
    
    func configureView(nullImage: String, nullMessage: String) {
        nullImageView.image = UIImage(named: nullImage)
        nullViewMessageLabel.text = nullMessage
    }
    
}
