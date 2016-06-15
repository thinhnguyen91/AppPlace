//
//  SingletionClass.swift
//  Baitaplon
//
//  Created by ThinhNX on 4/27/16.
//  Copyright © 2016 AsianTech. All rights reserved.
//

import UIKit

class SingletionClass: NSObject {

    var isSingletionClass: Bool!
    
    class var sharedInstance:SingletionClass{
        struct Singletion {
            static let  instance = SingletionClass()
            
        }
        return Singletion.instance
        
    }
    
    
}
