//
//  ViewController.swift
//  MakeAYoutube
//
//  Created by 陳 冠禎 on 2017/7/4.
//  Copyright © 2017年 陳 冠禎. All rights reserved.
//

import UIKit
import Foundation


class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout, CGMakeable {
    
    let homeCellID = "Cell"
    
    let trendingCellID = "trendingCellID"
    let subscriptionsCellID = "subscriptionCellID"
    
    let titles = ["Home", "Trending", "Profile", "Favorites"]
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    
    lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        navigationController?.navigationBar.isTranslucent = false
        
        setupNavigationLabel()
        setupCollectionView()
        setupMenuBar()
        setupNavBarButtons()
    }
    
    func setupNavigationLabel() {
        let frame = cgRectMake(0, 0, view.frame.width - 32, view.frame.height)
        let titleLabel = UILabel(frame: frame)
        titleLabel.textColor = UIColor.white
        titleLabel.text = "  Home"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
    }
    
    
    func setupCollectionView() {
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
       
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: homeCellID)
        collectionView?.register(TrendingCell.self, forCellWithReuseIdentifier: trendingCellID)
        collectionView?.register(SubscriptionsCell.self, forCellWithReuseIdentifier: subscriptionsCellID)
        
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.isPagingEnabled = true
        
    }
    
    func setupMenuBar() {
        
        navigationController?.hidesBarsOnSwipe = true
        
        let coverView = UIView()
        
        coverView.backgroundColor = UIColor.rgb(red: 140 , green: 197, blue: 115)
        view.addSubview(coverView)
        view.addSubview(menuBar)
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", view: coverView)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", view: coverView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", view: menuBar)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", view: menuBar)
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        
    }
    
    
    
    func setupNavBarButtons() {
        let searchImage = UIImage(named: "search")
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        searchBarButtonItem.tintColor = UIColor.white
        let moreImage = UIImage(named: "more")
        let moreBarButtonItem = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMore))
        moreBarButtonItem.tintColor = UIColor.white
        navigationItem.rightBarButtonItems = [moreBarButtonItem, searchBarButtonItem]
    }
    
    
    
    
    
    
    func handleMore() {
        settingsLauncher.showSetting()
    }
    
    func showController(for setting: Setting) {
        let dummySettingsViewController = UIViewController()
        navigationController?.pushViewController(dummySettingsViewController, animated: true)
        dummySettingsViewController.navigationItem.title = setting.title.rawValue
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
        
        dummySettingsViewController.view.backgroundColor = UIColor.brown
    }
    
    
    func handleSearch() {
        print("handleSearch")
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    var cellid = ""
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 1 {
            cellid = trendingCellID
            
        } else if indexPath.item == 2 {
            cellid = subscriptionsCellID
        } else {
            
            cellid = homeCellID
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath)
        

        return cell
        
        
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cgSizeMake(view.frame.width, view.frame.height - 50)
    }
    
    
    
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        setNavigationTitle(index: menuIndex)
    }
    
    func setNavigationTitle(index: Int) {
        if let titleView = navigationItem.titleView as? UILabel {
            titleView.text = "  " + titles[index]
        }
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarAnchorConstraint?.constant = scrollView.contentOffset.x / 4
    }
    
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        
        setNavigationTitle(index: Int(index))
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    
    
}

