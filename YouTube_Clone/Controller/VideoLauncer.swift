//
//  VideoLauncer.swift
//  YouTube_Clone
//
//  Created by Sheldon on 5/11/20.
//  Copyright © 2020 wentao. All rights reserved.
//

import UIKit
import AVFoundation


class VideoLauncher : VideoPlayedDelegae{
    
    var view : UIView?
    
    func dissmissVideoPlayerView() {
        
        if let keyWindow = keyWindow{
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.view?.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            }) { (_) in
                
            }
        }
    }
    
    func showVideoPlayer(){
        
        if let keyWindow = keyWindow{
            
            view = UIView(frame: keyWindow.frame)
            
            view?.backgroundColor = .white
            
            view?.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            // 16 * 9 is the aspect ratio of all HD videos
            let viedeoPlayerHeight = keyWindow.frame.width * 9 / 16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: viedeoPlayerHeight)
            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            
            videoPlayerView.delegate = self
            
            view?.addSubview(videoPlayerView)
            keyWindow.addSubview(view!)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.view?.frame = keyWindow.frame
            }) { (_) in
                
            }
        }
        
    }
    
    
}
