//
//  RecipeTableViewCell.swift
//  cookingmemo
//
//  Created by 佐々木華 on 2015/09/27.
//  Copyright (c) 2015年 Hana sasaki. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    @IBOutlet weak var RecipeTextField: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
