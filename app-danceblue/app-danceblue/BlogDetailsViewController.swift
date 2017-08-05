//
//  BlogDetailsViewController.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 8/1/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class BlogDetailsViewController: UITableViewController, BlogHeaderImageDelegate {

    var post: Blog?
    var chunks: [BCData]? {
        didSet {
            cellHeights = [CGFloat].init(repeating: 0, count: chunks?.count ?? 0)
        }
    }
    var cellHeights: [CGFloat] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshControl()
        chunks = post?.chunks
        UIApplication.shared.isStatusBarHidden = true
        self.tableView.bounces = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)

    }
    
    // MARK: - Refresh Control
    
    func setupRefreshControl() {
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        refreshControl?.tintColor = Styles.mainColor
        refreshControl?.backgroundColor = .blue
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func refresh() {
        refreshControl?.beginRefreshing()
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }
    
    // MARK: - TableView
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let bodyChunck = chunks?[indexPath.section] else { return UITableViewCell() }
        let type = bodyChunck.type

        
        switch type {
            case .headerImage:
                if let imageCell = tableView.dequeueReusableCell(withIdentifier: HeaderImageTableViewCell.identifier, for: indexPath) as? HeaderImageTableViewCell {
                    guard let data = bodyChunck.headerData else { return UITableViewCell() }
                    imageCell.configureCell(with: data)
                    cellHeights[indexPath.section] = 325.0
                    imageCell.delegate = self
                    return imageCell
                }
            
            case .details:
                if let detailsCell = tableView.dequeueReusableCell(withIdentifier: DetailsTableViewCell.identifier, for: indexPath) as? DetailsTableViewCell {
                    guard let data = bodyChunck.detailsData else { return UITableViewCell() }
                    detailsCell.configureCell(with: data)
                    if cellHeights[indexPath.section] == 0 {
                        cellHeights[indexPath.section] = detailsCell.sizeThatFits(CGSize(width: tableView.bounds.width, height: .greatestFiniteMagnitude)).height
                    }
                    
                    return detailsCell
                }
            
            case .quote:
                if let quoteCell = tableView.dequeueReusableCell(withIdentifier: QuoteTableViewCell.identifier, for: indexPath) as? QuoteTableViewCell {
                    guard let data = bodyChunck.quoteData else { return UITableViewCell() }
                    quoteCell.configureCell(with: data)
                    if cellHeights[indexPath.section] == 0 {
                        cellHeights[indexPath.section] = quoteCell.sizeThatFits(CGSize(width: tableView.bounds.width, height: .greatestFiniteMagnitude)).height
                    }
                    return quoteCell
                }
            
            case .bodyImage:
                if let bodyImageCell = tableView.dequeueReusableCell(withIdentifier: BodyImageTableViewCell.identifier, for: indexPath) as? BodyImageTableViewCell {
                    guard let data = bodyChunck.bodyImageData else { return UITableViewCell() }
                    bodyImageCell.configureCell(with: data)
                    if cellHeights[indexPath.section] == 0 {
                        cellHeights[indexPath.section] = bodyImageCell.sizeThatFits(CGSize(width: tableView.bounds.width, height: .greatestFiniteMagnitude)).height
                    }
                    return bodyImageCell
                }
            
            case .bodyText:
                if let bodyTextCell = tableView.dequeueReusableCell(withIdentifier: BodyTextTableViewCell.identifier, for: indexPath) as? BodyTextTableViewCell {
                    guard let data = bodyChunck.bodyTextData else { return UITableViewCell() }
                    bodyTextCell.configureCell(with: data)
                    if cellHeights[indexPath.section] == 0 {
                        cellHeights[indexPath.section] = bodyTextCell.sizeThatFits(CGSize(width: tableView.bounds.width, height: .greatestFiniteMagnitude)).height
                    }
                    return bodyTextCell
                }
            case .sectionTitle:
                if let sectionTitleCell = tableView.dequeueReusableCell(withIdentifier: SectionTitleTableViewCell.identifier, for: indexPath) as? SectionTitleTableViewCell {
                    guard let data = bodyChunck.sectionTitleData else { return UITableViewCell() }
                    sectionTitleCell.configureCell(with: data)
                    if cellHeights[indexPath.section] == 0 {
                        cellHeights[indexPath.section] = sectionTitleCell.sizeThatFits(CGSize(width: tableView.bounds.width, height: .greatestFiniteMagnitude)).height
                        print(cellHeights[indexPath.section])
                    }
                    return sectionTitleCell
                }
        }
        return UITableViewCell()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return chunks?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 325.0
        } else {
            return cellHeights[indexPath.section]
        }
    }

    
    // MARK: - HeaderImageDelegate 
    
    func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }

}
