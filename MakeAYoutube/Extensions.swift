//
//  Extensions.swift
//  MakeAYoutube
//
//  Created by 陳 冠禎 on 2017/7/4.
//  Copyright © 2017年 陳 冠禎. All rights reserved.
//

import UIKit


protocol CGRectMakeable { }
protocol CGSizeMakeable { }
protocol CGMakeable: CGRectMakeable, CGSizeMakeable { }

extension CGRectMakeable {
    
    func cgRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
}
extension CGSizeMakeable {
    func cgSizeMake( _ width: CGFloat, _ height: CGFloat) -> CGSize {
        return CGSize(width: width, height: height)
    }
}


extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}


extension UIView {
    func addConstraintsWithFormat(format: String, view: UIView...) {
       
        var viewsDictionary = [String: UIView]()
        
        for (index, view) in view.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()



class CustomImageView: UIImageView {

    
    var imageUrlString: String?
    
    func loadImageUsingUrlString(urlString: String) {
        let url = URL(string: urlString)
        
        image = nil
        
        imageUrlString = urlString
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard error == nil else {
                print(error!)
                return
            }
            
            guard let data = data else {
                print("data not found")
                return
            }
            
            
            DispatchQueue.main.async {
                
                let imageToCache = UIImage(data: data)
                
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                    
                imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
            }
            
            
            }.resume()
    }

    
}
