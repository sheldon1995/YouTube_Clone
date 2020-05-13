//
//  Extension.swift
//  YouTube_Clone
//
//  Created by Sheldon on 5/6/20.
//  Copyright © 2020 wentao. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?=nil, left: NSLayoutXAxisAnchor?=nil, bottom: NSLayoutYAxisAnchor?=nil, right: NSLayoutXAxisAnchor?=nil, paddingTop: CGFloat = 0, paddingLeft: CGFloat = 0, paddingBottom: CGFloat = 0, paddingRight: CGFloat = 0, width: CGFloat = 0, height: CGFloat = 0){
        
        // This is the way to activate programmatic constrains
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func centerX(inView view: UIView, constant: CGFloat = 0){
        // This is the way to activate programmatic constrains
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor,constant: constant).isActive = true
    }
    
    func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil, paddingLeft :CGFloat=0, constant: CGFloat = 0){
        // This is the way to activate programmatic constrains
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
        if let left = leftAnchor{
            anchor(left: left, paddingLeft:paddingLeft)
        }
    }
    
    func setDimensions(height:CGFloat, width:CGFloat){
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func addShadow(){
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 5;
        layer.shadowOffset = CGSize(width: 0.3, height: 0.3)
        layer.masksToBounds = false
    }
    
}

var imageCache = [String:UIImage]()

class CustomImageView: UIImageView {
    
    var lastImageUrlUsedToLoad:String?
    
    func loadImageUsingUrlString(urlString: String) {
        let url = URL(string: urlString)!
        
        image = nil
        
        lastImageUrlUsedToLoad = urlString
        
        // Check if image exists in cache
        if let cachedImage = imageCache[urlString] {
            self.image = cachedImage
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, respones, error) in
            
            if error != nil {
                print(error ?? "")
                return
            }
            
            // To make sure the image url that is being to load the image is actually equal to the post image that we are loading.
            //  This function is called until we get the right url parameter.
            if self.lastImageUrlUsedToLoad != url.absoluteString{
                return
            }
            
            guard let imageToCache = UIImage(data: data!) else {return}
            
            imageCache[urlString] = imageToCache
            
            DispatchQueue.main.async {
                
                self.image = imageToCache
            }
            
        }).resume()
    }
    
}
