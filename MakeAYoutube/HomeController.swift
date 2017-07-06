//
//  ViewController.swift
//  MakeAYoutube
//
//  Created by 陳 冠禎 on 2017/7/4.
//  Copyright © 2017年 陳 冠禎. All rights reserved.
//

import UIKit
import Foundation

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout, CGRectMakeable {

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

    let cellID = "Cell"
    
    
    var videos: [Video]?


    func fetchVideos() {
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if let error = error {
                print("error:", error)
                return
            }
            guard let data = data else {
                print("data is nil")
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                self.videos = [Video]()
                
                for dictionary in json as! [[String: AnyObject]] {
                    
                
                let video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    
                    
                    let channelDictionary = dictionary["channel"] as! [String: AnyObject]
                    let channel = Channel()
                    channel.name = channelDictionary["name"] as? String
                    channel.profileImageName = channelDictionary["profile_image_name"] as? String
                    video.channal = channel
                    
                self.videos?.append(video)
                }
            
                self.collectionView?.reloadData()
                
            } catch let jsonError {
                print(jsonError)
            }

            }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        fetchVideos()
        
        navigationItem.title = "Home"
        
        navigationController?.navigationBar.isTranslucent = false
        
        let frame = cgRectMake(0, 0, view.frame.width - 32, view.frame.height)
        let titleLabel = UILabel(frame: frame)
        titleLabel.textColor = UIColor.white
        titleLabel.text = "Home"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        
        navigationItem.titleView = titleLabel
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: cellID)
        
        
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        
        setupMenuBar()
        setupNavBarButtons()
    }
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    
    func setupMenuBar() {
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", view: menuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", view: menuBar)
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
    
    
    let settingsLauncher = SettingsLauncher()
    
    func handleMore() {
        settingsLauncher.showSetting()
    }
    
    
    func handleSearch() {
        print("handleSearch")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! VideoCell
        
        cell.video = videos?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let hight = (view.frame.width - 16 - 16) * 9 / 16
        return CGSize(width: view.frame.width, height: hight + 16 + 88)
    }
    
    
    
}

