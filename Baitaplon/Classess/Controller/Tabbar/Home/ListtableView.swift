//
//  ListtableView.swift
//  Baitaplon
//
//  Created by ThinhNX on 4/27/16.
//  Copyright © 2016 AsianTech. All rights reserved.
//

import UIKit

class ListtableView: UITableViewCell {
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var nameLable: UILabel!  
    @IBOutlet weak var phoneLable: UILabel!

    @IBOutlet weak var imageList: UIImageView!
    @IBOutlet weak var nameList: UILabel!
    @IBOutlet weak var addessList: UILabel!
    @IBOutlet weak var startList: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
