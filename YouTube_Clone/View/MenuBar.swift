//
//  MenuBar.swift
//  YouTube_Clone
//
//  Created by Sheldon on 5/7/20.
//  Copyright © 2020 wentao. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    let imageNames = ["home","trending","subscriptions","account"]
    
    var homeVC : HomeController?
    
    // Add a UICollection View
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .red
        cv.delegate = self
        cv.dataSource = self
        return cv
        
    }()
    
    override init(frame : CGRect) {
        super.init(frame:frame)
        backgroundColor = .red
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: "MenuBarCell")
        
        addSubview(collectionView)
        collectionView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
  
        let selectdIndexPah = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectdIndexPah, animated: false, scrollPosition: .top)
        
        setupHorizontalWhiteBar()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UICollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    // Cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuBarCell", for: indexPath) as! MenuCell
        cell.imageView.image = UIImage(named: imageNames[indexPath.row])?.withRenderingMode(.alwaysTemplate)
        
        if indexPath.row != 0{
            cell.imageView.tintColor = UIColor(red: 91/255, green: 14/255, blue: 13/255, alpha: 1)
        }
        return cell
    }
    
    // Size for row
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width : CGFloat = frame.width / 4
        return CGSize(width: width, height: frame.height)
    }
    
    // Minimum inter item space
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // Did select row at
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Let collection view scroll to the position when click menu bar
        homeVC?.scolltoMenIndex(menuIndex: indexPath.item)
        homeVC?.titleLabel.text = "  " + imageNames[indexPath.row].capitalized

    }
    
    //MARK: - Help Functions
    var horizontalBarLeftAnchorConstraint : NSLayoutConstraint?
    
    func setupHorizontalWhiteBar(){
        
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        
        addSubview(whiteView)
        horizontalBarLeftAnchorConstraint = whiteView.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalBarLeftAnchorConstraint?.isActive = true
        
        whiteView.anchor(bottom: bottomAnchor, height: 4)
        whiteView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
    }
    
}


