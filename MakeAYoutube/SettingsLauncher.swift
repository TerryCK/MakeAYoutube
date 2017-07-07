//
//  SettingLauncher.swift
//  MakeAYoutube
//
//  Created by 陳 冠禎 on 2017/7/6.
//  Copyright © 2017年 陳 冠禎. All rights reserved.
//

import UIKit

enum Settings: String {
    case settings = "Settings"
    case privacy = "Terms & privacy policy"
    case feedback = "Send Feedback"
    case help = "Help"
    case switchAccount = "Switch Account"
    case cancel = "Cancel & Dismiss"
}

class SettingsLauncher: NSObject, CGMakeable, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    let cellID = "cellID"
    let cellHeight = 50
    
    let blackView = UIView()
    
    let settings: [Setting] = {
        let seteingBtn = Setting(title: .settings, imageName: "settings"),
            privacyBtn = Setting(title: .privacy, imageName: "privacy"),
            feedbackBtn = Setting(title: .feedback, imageName: "feedback"),
            helpBtn = Setting(title: .help, imageName: "help"),
            switchAccountBtn = Setting(title: .switchAccount, imageName: "switchAccount"),
            cancel = Setting(title: .cancel, imageName: "cancel")
        return [
            seteingBtn, privacyBtn, feedbackBtn, helpBtn, switchAccountBtn, cancel
        ]
    }()
    
    var homeController: HomeController?
    
    let collectView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    func showSetting() {
        
        if let window = UIApplication.shared.keyWindow {
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismissbyGestrue)))
            
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
            
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.blackView.alpha = 1
                self.collectView.frame = self.cgRectMake(0, y, window.frame.width, height)
                
            }, completion: nil)
        }
    }
    
    func handleDismiss(for setting: Setting?) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            
            guard let window = UIApplication.shared.keyWindow else { return }
            self.collectView.frame = self.cgRectMake(0, window.frame.height, self.collectView.frame.width, self.collectView.frame.height)
        }, completion: { (bool) in
            if let setting = setting {
                if setting.title != .cancel {
                    self.homeController?.showController(for: setting)
                }
            }
        })
    }
    
    func handleDismissbyGestrue() {
        handleDismiss(for: nil)
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
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let setting = self.settings[indexPath.item]
        handleDismiss(for: setting)
    }
    
    override init() {
        super.init()
        
        collectView.dataSource = self
        collectView.delegate = self
        collectView.register(SettingCell.self, forCellWithReuseIdentifier: cellID)
    }
}
