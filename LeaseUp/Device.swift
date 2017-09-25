//
//  Device.swift
//  RideSwap
//
//  Created by Jonah Pelfrey on 9/25/17.
//  Copyright © 2017 Jonah Pelfrey. All rights reserved.
//

import Foundation
import UIKit

enum Device {
    
    case iPhoneS
    case iPhonePlus
    
    static var sizeClass: Device {
        
        let screenWidth = UIScreen.main.bounds.width
        
        switch screenWidth {
            
        case 375:
            return .iPhoneS
            
        case 414:
            return .iPhonePlus
            
        default:
            return .iPhoneS
            
        }
        
    }
    
}
