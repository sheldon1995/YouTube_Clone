//
//  SettingLauncher.swift
//  YouTube_Clone
//
//  Created by Sheldon on 5/9/20.
//  Copyright © 2020 wentao. All rights reserved.
//

import UIKit


enum SettingName : String{
    case Cancel = "Cancel & Dismiss"
    case Settings = "Settings"
    case TermsPrivacy = "Terms & privacy policy"
    case SendFeedBack = "Send Feedback"
    case Help = "Help"
    case SwitchAccount = "Switch Account"
}


class SettingLauncher : NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    
    //MARK: - Properties
    
    var homeVC : HomeController?
    let settingIconNames = ["settings","privacy","feedback","help","switch_account","cancel"]
    
    let settingTitles : [SettingName] = [.Settings,.TermsPrivacy,.SendFeedBack,.Help,.SwitchAccount,.Cancel]
   
    let blackView = UIView()
    
    let cellID = "SettingCell"
    
    let height : CGFloat = 300
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    
    //MARK: - Collection View
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settingIconNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SettingCell
        cell.iconImageView.image = UIImage(named: settingIconNames[indexPath.row])?.withRenderingMode(.alwaysTemplate)
        cell.iconImageView.tintColor = .darkGray
        cell.nameLabel.text = settingTitles[indexPath.row].rawValue
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let window = keyWindow{
            return CGSize(width: window.frame.width, height: (height - 15) / CGFloat(settingIconNames.count))
        }
        
        return CGSize(width: 0, height: 0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedSetting = self.settingTitles[indexPath.row]
        handleDismiss(setting: selectedSetting)
        
        
    }
    
    //MARK: - Init
    override init() {
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.isScrollEnabled = false
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellID)
    }
    
    //MARK: - Help Functions
    func showSettings(){
        if let window = keyWindow{
            
            blackView.backgroundColor = .black
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCancel))
            tapGesture.numberOfTapsRequired = 1
            blackView.addGestureRecognizer(tapGesture)
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.blackView.alpha = 0.6
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
            
            
        }
        
    }
    @objc func handleCancel() {
        handleDismiss(setting: settingTitles.first { $0 == .Cancel }!)
    }
    
     func handleDismiss(setting: SettingName){
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.blackView.alpha = 0
            
            if let window = keyWindow{
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
            
        }) { (_) in
           
            if setting != .Cancel{
                self.homeVC?.showControllerForSetting(withSetting: setting.rawValue)
            }
        }
    }
    
}
