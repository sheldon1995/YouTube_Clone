//
//  MenuCell.swift
//  YouTube_Clone
//
//  Created by Sheldon on 5/7/20.
//  Copyright © 2020 wentao. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        return iv
    }()

    override var isSelected: Bool{
        didSet{
            imageView.tintColor = isSelected ? UIColor.white : UIColor(red: 91/255, green: 14/255, blue: 13/255, alpha: 1)
        }
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame:frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView(){
        addSubview(imageView)
        imageView.centerY(inView: self)
        imageView.centerX(inView: self)
        imageView.setDimensions(height: 32, width: 32)
    }
    
}
