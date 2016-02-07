//
//  RecipManager.swift
//  cookingmemo
//
//  Created by 佐々木華 on 2015/11/22.
//  Copyright © 2015年 Hana sasaki. All rights reserved.
//

import UIKit

class RecipManager: NSObject {
    static let sharedInstance = RecipManager()
    var memoArray: [Dictionary<String, String>] = []
}
