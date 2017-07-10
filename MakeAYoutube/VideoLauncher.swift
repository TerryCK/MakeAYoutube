//
//  VideoLauncher.swift
//  MakeAYoutube
//
//  Created by 陳 冠禎 on 2017/7/10.
//  Copyright © 2017年 陳 冠禎. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView()
        aiv.activityIndicatorViewStyle = .whiteLarge
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    let videoLengthLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return(label)
    }()
    
    var currentLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return(label)
    }()
    
    var isPlaying = false
    
    lazy var pausePlayButton: UIButton = {
        let btn = UIButton(type: UIButtonType.system)
        let image = UIImage(named: "pause")
        btn.setImage(image, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tintColor = UIColor.white
        btn.isHidden = false
        btn.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        return btn
    }()
    
    let videoSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = UIColor.red
        slider.maximumTrackTintColor = UIColor.white
        slider.setThumbImage(UIImage(named: "redPoint"), for: .normal)
        
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        return slider
    }()
    
    
    func handleSliderChange() {
        if let duration = player?.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            
            guard !(totalSeconds.isNaN || totalSeconds.isInfinite) else {
                print("totalSeconds error"); return // or do some error handling
            }
            let value = Float64(videoSlider.value) * totalSeconds
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            player?.seek(to: seekTime, completionHandler: { (completedSeek) in
                
            })
        }
    }
    
    func handlePause() {
        
        if isPlaying {
            player?.pause()
            pausePlayButton.setImage(UIImage(named: "play"), for: .normal)
        } else {
            player?.play()
            pausePlayButton.setImage(UIImage(named: "pause"), for: .normal)
        }
        
        isPlaying = !isPlaying
        
    }
    
    let controllerContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    
    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.red.cgColor]
        gradientLayer.locations = [0.7, 1.2]
        controllerContainerView.layer.addSublayer(gradientLayer)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        controllerContainerView.frame = frame
        setupPlayView()
        setupGradientLayer()
        
        addSubview(controllerContainerView)
        controllerContainerView.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        controllerContainerView.addSubview(pausePlayButton)
        
        
        pausePlayButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pausePlayButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        pausePlayButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pausePlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        controllerContainerView.addSubview(videoLengthLabel)
        
        videoLengthLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        videoLengthLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
        videoLengthLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        videoLengthLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        
        
        controllerContainerView.addSubview(currentLabel)
        currentLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        currentLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
        currentLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        currentLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        
        
        controllerContainerView.addSubview(videoSlider)
        videoSlider.rightAnchor.constraint(equalTo: videoLengthLabel.leftAnchor).isActive = true
        videoSlider.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        videoSlider.leftAnchor.constraint(equalTo: currentLabel.rightAnchor).isActive = true
        videoSlider.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        backgroundColor = UIColor.black
        
        
    }
    
    var player: AVPlayer?
    
    private func setupPlayView() {
        let urlString = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
        
        if let url = URL(string: urlString) {
            player = AVPlayer(url: url)
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            player?.play()
            
            
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            
            
            let interval = CMTime(value: 1, timescale: 2)
            player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
                let seconds = CMTimeGetSeconds(progressTime)
                let secondsString = String(format: "%02d", Int(seconds) % 60)
                let minutesString = String(format: "%02d", Int(seconds) / 60)
                
                self.currentLabel.text = "\(minutesString):\(secondsString)"

                
                if let duration = self.player?.currentItem?.duration {
                    let durationSeconds = CMTimeGetSeconds(duration)
                    self.videoSlider.value = Float(seconds / durationSeconds)
                }
            
            })
            
        }
        
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicatorView.stopAnimating()
            controllerContainerView.backgroundColor = UIColor.clear
            pausePlayButton.isHidden = false
            isPlaying = true
            
            if let duration = player?.currentItem?.duration {
                let seconds = CMTimeGetSeconds(duration)
                let seconsText = Int(seconds) % 60
                let minutesText = String(format: "%02d", Int(seconds) / 60)
                
                videoLengthLabel.text = "\(minutesText):\(seconsText)"
            }

        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class VideoLauncher {
    func showVideoPlayer() {
        print("Showing video player animation....")
        if let keyWindow = UIApplication.shared.keyWindow {
            
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = UIColor.white
            
            view.frame =  CGRect(x: keyWindow.frame.width - 10 , y: keyWindow.frame.height - 10 , width: 10, height: 10)
            
            let width = keyWindow.frame.width
            let hight = width * 9 / 16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: width, height: hight)
            
            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            view.addSubview(videoPlayerView)
            
            keyWindow.addSubview(view)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                view.frame = keyWindow.frame
                
            }, completion: { (completedAnimation) in
                
                UIApplication.shared.isStatusBarHidden = true
            })
        }
    }
}
