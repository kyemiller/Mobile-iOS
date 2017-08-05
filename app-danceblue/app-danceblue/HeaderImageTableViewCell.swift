//
//  HeaderImageTableViewCell.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 8/1/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

protocol BlogHeaderImageDelegate: class {
    func didTapBackButton()
}

class HeaderImageTableViewCell: UITableViewCell, BlogDetailsHeaderImageDelegate {

    static let identifier = "HeaderImageCell"
    
    private var data: BCHeaderImage?
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var loadingIndicator: NVActivityIndicatorView!
    
    weak var delegate: BlogHeaderImageDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        headerImageView.clipsToBounds = true
    }
    
    func configureCell(with data: BCHeaderImage) {
        self.data = data
        data.delegate = self
        setupViews()
    }
    
    func setupViews() {
        loadingIndicator.color = Styles.loadingIndicatorColor
        loadingIndicator.type = .ballScale
        if data?.image == nil {
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
            headerImageView.image = data?.image
        }
    }
    
    func headerImage(didFinishDownloading image: UIImage?) {
        loadingIndicator.stopAnimating()
        headerImageView.image = image
    }
    

    @IBAction func backButtonTapped(_ sender: Any) {
        delegate?.didTapBackButton()
    }

}
