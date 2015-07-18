//
//  SKCosmeticListCell.swift
//  Skiny_iOS
//
//  Created by Yoshiyuki Kuga on 2015/07/18.
//  Copyright (c) 2015年 Gruppy. All rights reserved.
//

import UIKit

class SKCosmeticListCell: UITableViewCell {

    @IBOutlet weak var cosmeticImageView: UIImageView!
    @IBOutlet weak var cosmeticCategoryLabel: UILabel!
    @IBOutlet weak var cosmeticBrandLabel: UILabel!
    @IBOutlet weak var cosmeticNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    class func cellHeight() -> CGFloat {
        return 120
    }
    
}
