//
//  PhotoVenue.swift
//  Baitaplon
//
//  Created by ThinhNX on 6/15/16.
//  Copyright © 2016 AsianTech. All rights reserved.
//

import UIKit

class PhotoVenue: NSObject {
    var id = ""
    var prefix = ""
    var suffix = ""
    var width = 0
    var height =  0
    var urlpath = ""
    var img = UIImage()
    
    func getURLPath(sizeW: Int,sizeH: Int) -> String {
        
        return "\(sizeW)x\(sizeH)"
    }
    func getURLOriginal() -> String {
        return prefix + getURLPath(69, sizeH: 63) + suffix
    }

}
