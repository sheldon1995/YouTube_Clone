//
//  Constant.swift
//  YouTube_Clone
//
//  Created by Sheldon on 5/9/20.
//  Copyright © 2020 wentao. All rights reserved.
//

import UIKit

let keyWindow = UIApplication.shared.connectedScenes
.filter({$0.activationState == .foregroundActive})
.map({$0 as? UIWindowScene})
.compactMap({$0})
.first?.windows
.filter({$0.isKeyWindow}).first
