//
//  SettingCell.swift
//  MakeAYoutube
//
//  Created by 陳 冠禎 on 2017/7/6.
//  Copyright © 2017年 陳 冠禎. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    
    var setting: Setting? {
       
        didSet {
            nameLabel.text = setting?.title.rawValue
            if let imageName = setting?.imageName {
                iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                iconImageView.tintColor = UIColor.white
            }
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            print(isHighlighted)
            iconImageView.tintColor = isHighlighted ?  UIColor.darkGray : UIColor.white
            nameLabel.textColor = isHighlighted ? UIColor.darkGray : UIColor.white
            backgroundColor = isHighlighted ? UIColor.white : UIColor.clear
        }
    }
    
    let nameLabel: UILabel = {
       let label = UILabel()
        label.text = "Setting"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.white
        return label
    }()
    
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "settings")
        imageView.contentMode = .scaleAspectFill
        
        
        return imageView
    }()
    
    override func setupViews() {
        
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        addConstraintsWithFormat(format: "H:|-16-[v0(30)]-8-[v1]|", view: iconImageView, nameLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", view: nameLabel)
        addConstraintsWithFormat(format: "V:[v0(30)]", view: iconImageView)
        
        
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        
        
    
    }
    
}
