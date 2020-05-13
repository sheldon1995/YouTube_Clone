//
//  VideoCell.swift
//  YouTube_Clone
//
//  Created by Sheldon on 5/6/20.
//  Copyright © 2020 wentao. All rights reserved.
//

import UIKit
class VideoCell: UICollectionViewCell {
    
    
    //MARK: - Properties
    var titleLabelHeight : CGFloat = 0
    
    var video : Video?{
        didSet{
            
            
            titleLabel.text = video?.title
            
            
           
            setupThumbnailImage()
            
            setupProfileImage()

            if let channelName = video?.channel?.name, let numberOfViews = video?.numberOfViews{
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                
                let subtitleText = "\(channelName) • \(numberFormatter.string(from: NSNumber(value: numberOfViews))!) • 2 years ago "
                subtitleTextView.text = subtitleText
            }
            
            //measure title text
            if let title = video?.title {
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], context: nil)
                
                if estimatedRect.size.height > 20 {
                    titleLabelHeight = 44
                } else {
                    titleLabelHeight = 20
                }
                
                titleLabel.text = video?.title
            }
            
        }
    }
    
    let videoImageView:CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let separarotView : UIView = {
        let view = UIView()
        view.backgroundColor = .separator
        return view
    }()
    
    let profileImageView :CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 22
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    
    let subtitleTextView : UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.textColor = .secondaryLabel
        textView.textContainerInset = UIEdgeInsets(top: 0,left: -4,bottom: 0,right: 0)
        return textView
    }()
    //MARK: - Init
    
    override init(frame : CGRect){
        super.init(frame:frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Help Functions
    func setupViews(){
        addSubview(videoImageView)
        videoImageView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16 ,height: (self.frame.width - 32) * 9 / 16)
        
        addSubview(profileImageView)
        profileImageView.anchor(top: videoImageView.bottomAnchor, left: leftAnchor, paddingTop: 6, paddingLeft: 16, width: 44, height: 44)
        
        
        addSubview(titleLabel)
        titleLabel.anchor(top: videoImageView.bottomAnchor, left: profileImageView.rightAnchor, right: rightAnchor, paddingTop: 6, paddingLeft: 6, paddingRight: 16, height: titleLabelHeight)
        
        addSubview(subtitleTextView)
        subtitleTextView.anchor(top: titleLabel.bottomAnchor, left: profileImageView.rightAnchor, right: rightAnchor, paddingTop: 6, paddingLeft: 6, paddingRight: 16, height: 24)
        
        addSubview(separarotView)
        separarotView.anchor(top:subtitleTextView.bottomAnchor ,left: leftAnchor, right: rightAnchor, paddingTop : 10, height: 1)
    }
    
    func setupProfileImage() {
        if let profileImageUrl = video?.channel?.profileImageName {
            profileImageView.loadImageUsingUrlString(urlString: profileImageUrl)
        }
    }
    
    func setupThumbnailImage() {
        if let thumbnailImageUrl = video?.thumbnailImageName {
            videoImageView.loadImageUsingUrlString(urlString: thumbnailImageUrl)
        }
    }
}
