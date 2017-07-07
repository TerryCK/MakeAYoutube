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
    
    
    func fetchData(completed: @escaping completed) {
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
                var videos = [Video]()
                
                for dictionary in json as! [[String: AnyObject]] {
                    
                    
                    let video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    
                    
                    let channelDictionary = dictionary["channel"] as! [String: AnyObject]
                    let channel = Channel()
                    channel.name = channelDictionary["name"] as? String
                    channel.profileImageName = channelDictionary["profile_image_name"] as? String
                    video.channal = channel
                    
                    videos.append(video)
                }
                DispatchQueue.main.async {
               
                    completed(videos)
                }
                
                
            } catch let jsonError {
                print(jsonError)
            }
            
            }.resume()
    }
    
    
}
