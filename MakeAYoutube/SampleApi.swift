////
////  SampleApi.swift
////  MakeAYoutube
////
////  Created by 陳 冠禎 on 2017/7/8.
////  Copyright © 2017年 陳 冠禎. All rights reserved.
////
//
//import Foundation
//
//class SampleApi: NSObject {
//    
//    static let shared = SampleApi()
//    
//    var videos: [Video] = {
//        
//        var coffeeChannel = Channel()
//        coffeeChannel.name = "融合美學與生活的風格"
//        coffeeChannel.profileImageName = "userProfile"
//        
//        var sampleChannel = Channel()
//        sampleChannel.name = "乾淨的廚房，舒適的用餐環境，不再受到蟑螂的打擾"
//        sampleChannel.profileImageName = "user2"
//        
//        var sampleChannel2 = Channel()
//        sampleChannel2.name = "爸媽非常滿意的選擇"
//        sampleChannel2.profileImageName = "user3"
//        
//        var blankSpaceVideo = Video()
//        blankSpaceVideo.title = "Marderlian - for Keto Diet and very delicious"
//        blankSpaceVideo.thumbnailImageName = "marderlian"
//        blankSpaceVideo.channal = coffeeChannel
//        blankSpaceVideo.numberOfViews = 123124115
//        
//        var coffeeVideo = Video()
//        coffeeVideo.title = "hand punch coffee is good to drink"
//        coffeeVideo.thumbnailImageName = "coffee"
//        coffeeVideo.channal = coffeeChannel
//        coffeeVideo.numberOfViews = 123125412
//        
//        var sample1 = Video()
//        sample1.title = "鱈魚子"
//        sample1.thumbnailImageName = "sample1"
//        sample1.channal = sampleChannel
//        sample1.numberOfViews = 12318
//        
//        var sample2 = Video()
//        sample2.title = "烏魚子"
//        sample2.thumbnailImageName = "sample2"
//        sample2.channal = sampleChannel2
//        sample2.numberOfViews = 123124
//        
//        
//        return [sample1, sample2, blankSpaceVideo, coffeeVideo]
//    }()
//    
//}
