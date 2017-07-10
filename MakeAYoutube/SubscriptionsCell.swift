//
//  PersonaltyCell.swift
//  MakeAYoutube
//
//  Created by 陳 冠禎 on 2017/7/8.
//  Copyright © 2017年 陳 冠禎. All rights reserved.
//

import UIKit

class SubscriptionsCell: FeedCell {
   
    override func fetchVideos() {
        ApiService.shared.fetchSubscriptionsData { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
        
    }
}
