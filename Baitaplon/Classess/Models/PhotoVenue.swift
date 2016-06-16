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
    var img = UIImage(named: "no_image")
    
    func getURLPath(sizeW: Int,sizeH: Int) -> String {
        
        return prefix + "\(sizeW)x\(sizeH)" + suffix
    }
    func getURLOriginal() -> String {
        return prefix + "original" + suffix
        
    }

}
