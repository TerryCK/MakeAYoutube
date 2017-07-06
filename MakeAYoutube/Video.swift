//
//  Video.swift
//  MakeAYoutube
//
//  Created by 陳 冠禎 on 2017/7/5.
//  Copyright © 2017年 陳 冠禎. All rights reserved.
//

import UIKit
import Foundation

class Video: NSObject {
    var thumbnailImageName: String?
    var title: String?
    var numberOfViews: NSNumber?
    var uploadData: NSData?

    var channal: Channel?
}


class Channel: NSObject {
    var name: String?
    var profileImageName: String?
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

