//
//  BlogCollectionViewController.swift
//  
//
//  Created by Blake Swaidner on 7/31/17.
//
//

import UIKit
import FirebaseDatabase

class BlogCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private var firebaseReference: DatabaseReference?
    private var blogAddHandle: DatabaseHandle?
    private var blogChangeHandle: DatabaseHandle?
    private var blogDeleteHandle: DatabaseHandle?
    private var featuredAddHandle: DatabaseHandle?
    private var featuredChangeHandle: DatabaseHandle?
    private var featuredDeleteHandle: DatabaseHandle?
    
    private var blogData: [Blog] = [] {
        didSet {
            blogHeights = [CGFloat].init(repeating: 0, count: blogData.count)
        }
    }
    private var blogMap: [String : Blog] = [:]
    private var featuredPost: Blog? {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    private var featuredHeight: CGFloat = 0.0
    private var blogHeights: [CGFloat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.delegate = self
        setupFirebase()
        collectionView?.allowsSelection = true
        collectionView?.contentInset = .init(top: 8.0, left: 0.0, bottom: 8.0, right: 0.0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUpNavigation(controller: navigationController)
        self.title = "Blog"
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: self.view.bounds.width, height: 440.0)
        } else {
            return CGSize(width: self.view.bounds.width / 2 - 30, height: blogHeights[indexPath.row])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return .zero
        } else {
            return UIEdgeInsets(top: 8, left: 20, bottom: 20, right: 20)
        }
    }

    
    // MARK: - Storyboard
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "FeaturedSegue" {
            if let destination = segue.destination as? BlogDetailsTableViewController {
                destination.post = featuredPost
            }
        } else if segue.identifier == "BlogSegue" {
            if let destination = segue.destination as? BlogDetailsTableViewController, let cell = sender as? BlogCollectionViewCell, let indexPath = self.collectionView?.indexPath(for: cell) {
                destination.post = blogData[indexPath.row]
            }
        }
        
    }

    // MARK: - Firebase
        
    func setupFirebase() {
        
        firebaseReference = Database.database().reference()
        
        // Featured Handles
        
        featuredAddHandle = firebaseReference?.child("blog").child("featured").observe(.childAdded, with: { (snapshot) in
           
            guard let data = snapshot.value as? [String : AnyObject]  else { return }
            let post = Blog(JSON: data)
            self.featuredPost = post
            self.collectionView?.reloadData()
        })
        
        featuredChangeHandle = firebaseReference?.child("blog").child("featured").observe(.childChanged, with: { (snapshot) in
            guard let data = snapshot.value as? [String : AnyObject]  else { return }
            let post = Blog(JSON: data)
            self.featuredPost = post
            self.collectionView?.reloadData()
            
        })
        
        // Recent Handles
        
        blogAddHandle = firebaseReference?.child("blog").child("recent").observe(.childAdded, with: { (snapshot) in
            guard let data = snapshot.value as? [String : AnyObject]  else { return }
            guard let post = Blog(JSON: data) else { return }
            self.blogMap["\(post.id!)"] = post
            self.blogData.append(post)
            self.sortPosts()
        })
        
        blogChangeHandle = firebaseReference?.child("blog").child("recent").observe(.childChanged, with: { (snapshot) in
            guard let data = snapshot.value as? [String : AnyObject]  else { return }
            guard let post = Blog(JSON: data) else { return }
            self.blogMap.updateValue(post, forKey: "\(post.id!)")
            self.blogData = Array(self.blogMap.values)
            self.sortPosts()
            self.collectionView?.reloadData()
        })
        
        blogDeleteHandle = firebaseReference?.child("blog").child("recent").observe(.childRemoved, with: { (snapshot) in
            guard let data = snapshot.value as? [String : AnyObject]  else { return }
            guard let post = Blog(JSON: data) else { return }
            self.blogMap.removeValue(forKey: post.id!)
            self.blogData = Array(self.blogMap.values)
            self.sortPosts()
            self.collectionView?.reloadData()
        })
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return blogData.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let featuredCell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedCollectionViewCell.identifier, for: indexPath) as? FeaturedCollectionViewCell else
            { return FeaturedCollectionViewCell() }
            if featuredPost != nil {
                guard let details = featuredPost!.details else { return UICollectionViewCell() }
                featuredCell.configureCell(with: details)
            }
            return featuredCell
            
        } else {
            guard let postCell = collectionView.dequeueReusableCell(withReuseIdentifier: BlogCollectionViewCell.identifier, for: indexPath) as? BlogCollectionViewCell else
            { return BlogCollectionViewCell() }
            guard let details = blogData[indexPath.row].details else { return UICollectionViewCell() }
            postCell.configureCell(with: details)
            
            if blogHeights[indexPath.row] == 0 {
                blogHeights[indexPath.row] = postCell.sizeThatFits(CGSize(width: self.view.bounds.width / 2 - 30, height: .greatestFiniteMagnitude)).height
                collectionViewLayout.invalidateLayout()
            }
            
            return postCell
        }

    }
    
    // MARK: - Utility
    
    func sortPosts() {
        blogData.sort(by: {$0.details?.timestamp ?? Date() < $1.details?.timestamp ?? Date()})
    }
    
}
