//
//  MoreViewController.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 7/22/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit

class MoreViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.allowsSelection = true
        collectionView?.contentInset = .init(top: 8.0, left: 0.0, bottom: 8.0, right: 0.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpNavigation(controller: navigationController)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Get Gear Icon", style: .plain, target: self, action: #selector(settingsTapped))
        self.title = "More"
    }
    
    func settingsTapped() {
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoreCollectionViewCell.identifier, for: indexPath) as? MoreCollectionViewCell {
            cell.configureCell(with: UIImage(named: "DanceBlueReveal.jpg")!, title: "Title")
            return cell
        }
        return MoreCollectionViewCell()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 2 - 60, height: collectionView.bounds.height / 2 - 60)
    }
}
