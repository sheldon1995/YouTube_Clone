//
//  VideoPlayerView.swift
//  YouTube_Clone
//
//  Created by Sheldon on 5/12/20.
//  Copyright © 2020 wentao. All rights reserved.
//

import UIKit
import AVFoundation


class VideoPlayerView : UIView {
    
    //MARK: - Properties
    var delegate : VideoPlayedDelegae?
    var isPlayed = false
    
    let activityIndicatorView : UIActivityIndicatorView = {
        let av = UIActivityIndicatorView(style: .large)
        av.color = .white
        av.startAnimating()
        return av
    }()
    
    let controlsContainerView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    var player : AVPlayer?
    
    let pauseButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "pause").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.alpha = 0
        button.addTarget(self, action: #selector(handlePauseTapped), for: .touchUpInside)
        return button
    }()
    
    let videoLengthLabel : UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }()
    
    let videoSlider : UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .white
        slider.thumbTintColor = .red
        slider.setThumbImage(#imageLiteral(resourceName: "redDot"), for: .normal)
        slider.addTarget(self, action: #selector(handleSliderDragged), for: .valueChanged)
        return slider
    }()
    
    let videoCurrentTimeLabel : UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }()
    
    
    let backButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("<-", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.alpha = 0.85
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPlayerView()
        
        setupGradientLayer()
        
        controlsContainerView.frame = frame
        addSubview(controlsContainerView)
        
        controlsContainerView.addSubview(activityIndicatorView)
        activityIndicatorView.centerX(inView: controlsContainerView)
        activityIndicatorView.centerY(inView: controlsContainerView)
        
        
        controlsContainerView.addSubview(pauseButton)
        pauseButton.centerX(inView: controlsContainerView)
        pauseButton.centerY(inView: controlsContainerView)
        pauseButton.setDimensions(height: 45, width: 45)
        
        controlsContainerView.addSubview(videoLengthLabel)
        videoLengthLabel.anchor(bottom: bottomAnchor, right: rightAnchor, paddingRight: 8, width: 50, height: 20)
        
        controlsContainerView.addSubview(videoCurrentTimeLabel)
        videoCurrentTimeLabel.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 8, width: 50, height: 20)
        
        
        controlsContainerView.addSubview(videoSlider)
        videoSlider.anchor(left: videoCurrentTimeLabel.rightAnchor , bottom: bottomAnchor, right: videoLengthLabel.leftAnchor, paddingLeft: 4, paddingBottom: 8, paddingRight: 4, height: 2)
        
        
        controlsContainerView.addSubview(backButton)
        backButton.anchor(top: topAnchor, left: leftAnchor, paddingTop: 30, paddingLeft: 12, width: 30, height: 30)
        
        backgroundColor = .black
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Help Functions
    @objc func handleBack(){
        delegate?.dissmissVideoPlayerView()
    }
    
    func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.frame = bounds
        gradientLayer.locations = [0.7,1]
        controlsContainerView.layer.addSublayer(gradientLayer)
        
    }
    @objc func handleSliderDragged(){
        
        if let duration = player?.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            
            let value = Float64(videoSlider.value) * totalSeconds
            
            let seekTIME = CMTime(value: Int64(value), timescale: 1)
            player?.seek(to: seekTIME, completionHandler: { (_) in
                
                self.videoCurrentTimeLabel.text = self.displayTime(withTime: seekTIME)
            })
        }
        
    }
    
    func setupPlayerView(){
        
        
        let urlString = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
        
        if let url = URL(string: urlString){
            player = AVPlayer(url: url)
            
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = self.frame
            
            self.layer.addSublayer(playerLayer)
            
            player?.play()
            
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            
            let interval = CMTime(value: 1, timescale: 2)
            player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
                
                if let duration = self.player?.currentItem?.duration{
                    let durationTime = CMTimeGetSeconds(duration)
                    let progress = CMTimeGetSeconds(progressTime)
                    let percent = progress / durationTime
                    self.videoSlider.value = Float(percent)
                    
                }

                self.videoCurrentTimeLabel.text = self.displayTime(withTime: progressTime)
                
            })
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges"{
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = .clear
            pauseButton.alpha = 1
            isPlayed = true
            
            // How long the vide is
            
            if let duration = player?.currentItem?.duration{
                
                videoLengthLabel.text = self.displayTime(withTime: duration)
            }
            
        }
    }
    
    @objc func handlePauseTapped(){
        
        if isPlayed{
            player?.pause()
            pauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        }
        else{
            player?.play()
            pauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        }
        
        
        
        isPlayed.toggle()
    }
    
    func displayTime(withTime time : CMTime) -> String{
        let seconds = CMTimeGetSeconds(time)
        
        let secdonsText = String(format: "%02d", Int(seconds) % 60)
        
        let minutesText = String(format: "%02d", Int(seconds / 60))
        
        return "\(minutesText):\(secdonsText)"
    }
}
