//
//  ApiService.swift
//  MakeAYoutube
//
//  Created by 陳 冠禎 on 2017/7/7.
//  Copyright © 2017年 陳 冠禎. All rights reserved.
//

import UIKit

typealias completed = ([Video]) -> ()

class ApiService: NSObject {
    
    static let shared = ApiService()
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets/"
    
    //    func fecthData(urlString: String, completed: @escaping completed) {
    //
    //        let url = URL(string: "\(baseUrl)home.json")
    //
    //    }
    
    func fetchHomeData(completed: @escaping completed) {
        
        fetchFeedfor(urlString: "home", completed: completed)
        
    }
    
    func fetchTrendingData(completed: @escaping completed) {
        
        fetchFeedfor(urlString: "trending", completed: completed)
    }
    
    func fetchSubscriptionsData(completed: @escaping completed) {
        
        fetchFeedfor(urlString: "subscriptions", completed: completed)
    }
    
    func fetchFeedfor(urlString: String, completed: @escaping completed) {
       
        let url = URL(string: "\(baseUrl)\(urlString).json")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if let error = error {
                print("error:", error)
                return
            }
            
            do {
                guard let data = data, let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: AnyObject]] else { return }
                
                let videos = jsonDictionary.map { Video(dictionary: $0)  }
                
                DispatchQueue.main.async {
                    completed(videos)
                }
                
                
            } catch let jsonError {
                print(jsonError)
            }
            
            }.resume()
        
        
    }
    
}


//
//        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
//        var videos = [Video]()
//
//        for dictionary in json as! [[String: AnyObject]] {
//
//
//            let video = Video()
//
//            //                    video.title = dictionary["title"] as? String
//            //                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
//            //                    video.numberOfViews = dictionary["number_of_views"] as? NSNumber
//            //
//
//            video.setValuesForKeys(dictionary)
//
//            let channelDictionary = dictionary["channel"] as! [String: AnyObject]
//            let channel = Channel()
//
//            channel.setValuesForKeys(channelDictionary)
//
//            //                    channel.name = channelDictionary["name"] as? String
//            //                    channel.profileImageName = channelDictionary["profile_image_name"] as? String
//            video.channal = channel
//
//            videos.append(video)
//        }
//        DispatchQueue.main.async {
//
//            completed(videos)
//        }
//
//
//    } catch let jsonError {
//        print(jsonError)
//    }
//
//}.resume()
