//
//  SettingLauncher.swift
//  MakeAYoutube
//
//  Created by 陳 冠禎 on 2017/7/6.
//  Copyright © 2017年 陳 冠禎. All rights reserved.
//

import UIKit

struct Setting {
    let title: String
    let imageName: String
}

class SettingsLauncher: NSObject, CGMakeable, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    let cellID = "cellID"
    let cellHeight = 50
    
    let blackView = UIView()
    
    let settings: [Setting] = {
        
        return [
        Setting(title: "Settings", imageName: "settings"),
        Setting(title: "Terms & privacy policy", imageName: "privacy"),
        Setting(title: "Send Feedback", imageName: "feedback"),
        Setting(title: "Help", imageName: "help"),
        Setting(title: "Switch Account", imageName: "switchAccount"),
        Setting(title: "Cancel", imageName: "cancel")
        ]
        
    }()
    
    
    let collectView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    func showSetting() {
        
        if let window = UIApplication.shared.keyWindow {
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDissmiss)))
            
            window.addSubview(blackView)
            window.addSubview(collectView)
            let blurEffect = UIBlurEffect(style: .dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            
            collectView.backgroundView = blurEffectView
            collectView.backgroundColor = UIColor.clear
            
            let height = CGFloat(settings.count * cellHeight)
            let y = window.frame.height - height
            
            collectView.frame = cgRectMake(0, window.frame.height, window.frame.width, height)
            blackView.frame = window.frame
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.blackView.alpha = 1
                self.collectView.frame = self.cgRectMake(0, y, window.frame.width, height)
                
            }, completion: nil)
        }
    }
    
    func handleDissmiss() {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            
            guard let window = UIApplication.shared.keyWindow else { return }
            self.collectView.frame = self.cgRectMake(0, window.frame.height, self.collectView.frame.width, self.collectView.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SettingCell
        let setting = settings[indexPath.item]
        cell.setting = setting
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cgSizeMake(collectView.frame.width, CGFloat(cellHeight))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override init() {
        super.init()
        
        collectView.dataSource = self
        collectView.delegate = self
        collectView.register(SettingCell.self, forCellWithReuseIdentifier: cellID)
    }
}
