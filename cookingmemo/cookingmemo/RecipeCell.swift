//
//  RecipeCell.swift
//  cookingmemo
//
//  Created by 松下慶大 on 2016/02/07.
//  Copyright © 2016年 Hana sasaki. All rights reserved.
//

import UIKit

class RecipeCell: UITableViewCell {
    @IBOutlet weak var RecipeTextField: UILabel!
    @IBOutlet weak var imageFromCameraRoll: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageFromCameraRoll.clipsToBounds = true
        imageFromCameraRoll.frame.size = CGSize(width: 78, height: 78)
        imageFromCameraRoll.contentMode = UIViewContentMode.ScaleAspectFill
        print("====")

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
