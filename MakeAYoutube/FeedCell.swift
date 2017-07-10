//
//  FeedCell.swift
//  MakeAYoutube
//
//  Created by 陳 冠禎 on 2017/7/8.
//  Copyright © 2017年 陳 冠禎. All rights reserved.
//

import UIKit

class FeedCell: BaseCell, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let cellID = "cellID"
    var videos: [Video]?
    
    let isSampleAPI = false
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.delegate = self
        cv.dataSource = self
        
        return cv
        
    }()
    
    override func setupViews() {
        super.setupViews()
        fetchVideos()
        backgroundColor = UIColor.white
        
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", view: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", view: collectionView)
        
        
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: cellID)
    }
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! VideoCell
        
        cell.video = videos?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let hight = (frame.width - 16 - 16) * 9 / 16
        return CGSize(width: frame.width, height: hight + 16 + 88)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let videoLauncher = VideoLauncher()
        videoLauncher.showVideoPlayer()
    }
    
    func fetchVideos() {
        
        ApiService.shared.fetchHomeData { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
        
        
    }
    
    
    
    
    
}

