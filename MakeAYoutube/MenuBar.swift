//
//  MenuBar.swift
//  MakeAYoutube
//
//  Created by 陳 冠禎 on 2017/7/5.
//  Copyright © 2017年 陳 冠禎. All rights reserved.
//

import UIKit


class MenuBar: BaseCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, CGMakeable {
    
    let cellID = "cellID"
    let imageNames = ["home", "fire", "user", "video"]
    var homeController: HomeController?
    var horizontalBarAnchorConstraint: NSLayoutConstraint?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        cv.backgroundColor = UIColor.rgb(red: 140 , green: 197, blue: 115)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    
    override func setupViews() {
        addSubview(collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", view: collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", view: collectionView)
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellID)
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .top)
        setupHorizontalBar()
    }
    
    
    
    func setupHorizontalBar() {
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        addSubview(horizontalBarView)
        
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        
        horizontalBarAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalBarAnchorConstraint?.isActive = true
        
        horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
        horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        horizontalBarView.layer.cornerRadius = 4
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let x = CGFloat(indexPath.item) * frame.width / 4
        
        horizontalBarAnchorConstraint?.constant = x
        homeController?.scrollToMenuIndex(menuIndex: indexPath.item)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MenuCell
        
        let imageName = imageNames[indexPath.item]
        cell.imageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        cell.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cgSizeMake(frame.width / 4, frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}


class MenuCell : BaseCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        return iv
    }()
    
    
    override var isHighlighted: Bool {
        didSet {
            imageView.tintColor = isHighlighted ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        addConstraintsWithFormat(format: "H:[v0(28)]", view: imageView)
        addConstraintsWithFormat(format: "V:[v0(28)]", view: imageView)
        
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        
    }
}
