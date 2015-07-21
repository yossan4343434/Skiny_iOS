//
//  SKSelectOptionCell.swift
//  Skiny_iOS
//
//  Created by Yoshiyuki Kuga on 2015/07/20.
//  Copyright (c) 2015年 Gruppy. All rights reserved.
//

import UIKit

class SKSelectOptionCell: UITableViewCell {

    @IBOutlet weak var optionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    class func cellHeight() -> CGFloat {
        return 46
    }
    
}
