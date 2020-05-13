//
//  SettingCell.swift
//  YouTube_Clone
//
//  Created by Sheldon on 5/9/20.
//  Copyright © 2020 wentao. All rights reserved.
//

import UIKit

class SettingCell : UICollectionViewCell{
    
    
    override var isHighlighted: Bool{
        didSet{
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
        }
    }
    
    let iconImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupViews(){
        
        addSubview(iconImageView)
        iconImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor , paddingTop: 6, paddingLeft: 12, paddingBottom: 6, width: 40)
        
        addSubview(nameLabel)
        nameLabel.anchor(top:topAnchor,left: iconImageView.rightAnchor, bottom: bottomAnchor,right: rightAnchor, paddingLeft: 18)
       
    }
    
}
