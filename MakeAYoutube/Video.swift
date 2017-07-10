//
//  Video.swift
//  MakeAYoutube
//
//  Created by 陳 冠禎 on 2017/7/5.
//  Copyright © 2017年 陳 冠禎. All rights reserved.
//

import UIKit
import Foundation

class SafeJsonObject: NSObject {
    override func setValue(_ value: Any?, forKey key: String) {
        let uppercasedFirstCharacter = String(key.characters.first!).uppercased()
        let range = key.startIndex..<key.index(key.startIndex, offsetBy: 1)
        let selectorString = key.replacingCharacters(in: range, with: uppercasedFirstCharacter)
        let selector = NSSelectorFromString("set\(selectorString):")
        let responds = self.responds(to: selector)
        
        if !responds {
            return
        }
    super.setValue(value, forKey: key)
    }
}


class Video: SafeJsonObject {
    var thumbnail_image_name: String?
    var title: String?
    var number_of_views: NSNumber?
    var uploadData: NSData?
    var duration: NSNumber?
    
    var channel: Channel?
    
    override func setValue(_ value: Any?, forKey key: String) {
        
        if key == "channel" {
            self.channel = Channel()
            self.channel?.setValuesForKeys(value as! [String: AnyObject])
        } else {
            super.setValue(value, forKey: key)
        }
    }
    
    init(dictionary: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dictionary)
        
    }
    
}

class Channel: SafeJsonObject {
    var name: String?
    var profile_image_name: String?
}

struct Setting {
    let title: Settings
    let imageName: String
}



// for xcode 9 , Swift 4 , Parsing JSON
//struct Video: Codable {
//    let title: String
//    let numberOfViews: Double
//    let thumbnailImageName: String
//    let channel: Channel
//
//    struct Channel: Codable {
//        let name: String
//        let profileImageName: String
//
//        private enum CodingKeys: String, CodingKey {
//            case name
//            case profileImageName = "profile_image_name"
//        }
//    }
//
//    let duration: Double
//
//    private enum CodingKeys: String, CodingKey {
//        case title
//        case numberOfViews = "number_of_views"
//        case thumbnailImageName = "thumbnail_image_name"
//        case channel
//        case duration
//    }
//}

