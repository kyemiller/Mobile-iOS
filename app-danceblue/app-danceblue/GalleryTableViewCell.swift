//
//  GalleryTableViewCell.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 10/16/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit

class GalleryTableViewCell: UITableViewCell {

    static let identifier = "GalleryCell"
    
    fileprivate var galleryData: [URL]? {
        didSet {
            galleryCollectionView.reloadData()
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var underlineView: UIView!
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        titleLabel.text = "RECENT PHOTOS"
        titleLabel.font = Theme.Font.header
        underlineView.backgroundColor = Theme.Color.main
        
    }
    
    func setupCollectionView() {
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
    }
    
    func configureCell(with data: [URL]) {
        setupCollectionView()
        galleryData = data
    }
    
}

// MARK: - UICollectionViewDelegate

extension GalleryTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Item Selected")
    }
}

// MARK: - UICollectionViewDataSource

extension GalleryTableViewCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        log.debug(galleryData?.count ?? 0)
        return galleryData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let galleryCell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.identifier, for: indexPath) as? GalleryCollectionViewCell {
            guard let data = galleryData else { return UICollectionViewCell() }
            galleryCell.configureCell(with: data [indexPath.row])
            return galleryCell
        }
        return UICollectionViewCell()
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension GalleryTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 220, height: 133.0)
    }
    
}
