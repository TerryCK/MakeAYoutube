//
//  VideoCell.swift
//  MakeAYoutube
//
//  Created by 陳 冠禎 on 2017/7/4.
//  Copyright © 2017年 陳 冠禎. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    
    func setupViews() {  }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



class VideoCell: BaseCell, CGMakeable {
    
    var video: Video? {
        
        didSet {
            titleLabel.text = video?.title
//            thumbnailImageView.image = UIImage(named: (video?.thumbnailImageName)! )
//            userProfileImageView.image = UIImage(named: (video?.channal?.profileImageName)!)
            
            setupProfileImage()
            setupThumbnailImage()
            
           
            if let name = video?.channal?.name, let numberOfViews = video?.numberOfViews {
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                let numberViews = numberFormatter.string(from: numberOfViews)!
                
                let subtitleText = "\(name) ·\(numberViews)· 1 years ago "
                subtitleTextView.text = subtitleText
            }
            
            // mesure title text
            if let title = video?.title {
                let size = cgSizeMake(frame.width - 16 - 44 - 8 - 16, 1000)
                
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
                
                titleLabelHeightContraint?.constant = estimatedRect.size.height > 20 ? 44 : 20
            }
        }
        
    }
    
    
    
    func setupProfileImage() {
        if let profileImageUrl = video?.channal?.profileImageName {
            userProfileImageView.loadImageUsingUrlString(urlString: profileImageUrl)
        }
        
    }
    func setupThumbnailImage() {
        if let thumbnailImageUrl = video?.thumbnailImageName {
            thumbnailImageView.loadImageUsingUrlString(urlString: thumbnailImageUrl)
        }
    }
    
    
    var titleLabelHeightContraint: NSLayoutConstraint?
    
    
    
    
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.backgroundColor = UIColor.blue
        imageView.image = UIImage(named: "marderlian")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        var white: CGFloat { return 230 / 255 }
        view.backgroundColor = UIColor(red: white, green: white, blue: white, alpha: 1)
        
        
        return view
    }()
    
    let userProfileImageView: CustomImageView = {
        let imageView = CustomImageView()
        
        imageView.backgroundColor = UIColor.green
        imageView.image = UIImage(named: "userProfile")
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.text = "It's available for keto diet"
        return label
    }()
    
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Delicious!  1,212,125,223 views    2 years ago"
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textView.textColor = UIColor.lightGray
        return textView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
        
        
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", view: thumbnailImageView, userProfileImageView, separatorView)
        
        // horizontal constraints
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", view: thumbnailImageView)
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]", view: userProfileImageView)
        addConstraintsWithFormat(format: "H:|[v0]|", view: separatorView)
        
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: userProfileImageView, attribute: .top, multiplier: 1, constant: 0))
        
        // left constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        
        // right constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        
        
        
        titleLabelHeightContraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20)
        
        // hight constraint
        addConstraint(titleLabelHeightContraint!)
        
        
        
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        
        //left constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        
        // right constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        
        // hight constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
        
        
        
        
        
        thumbnailImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
    }
    
    
    
    
    
}

