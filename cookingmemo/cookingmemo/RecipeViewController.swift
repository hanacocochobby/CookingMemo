//
//  RecipeViewController.swift
//  cookingmemo
//
//  Created by 佐々木華 on 2015/12/06.
//  Copyright © 2015年 Hana sasaki. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {

    @IBOutlet weak var foodstuffTextView: UITextView!
    @IBOutlet weak var recipeTextVIew: UITextView!
    
    @IBOutlet weak var imageFromCameraRoll: UIImageView!
    
    var foodstuff: String?
    var recipe: String?
    //①タイトルを保持するための変数を定義
    var recipetitle: String?
    var currentNumber: Int?
    var imageData: NSData?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        foodstuffTextView.text = foodstuff
        recipeTextVIew.text = recipe
        
        //②
        self.title = recipetitle
        
//        let imageData = NSUserDefaults.standardUserDefaults().objectForKey("image") as! NSData
            let image = UIImage(data: self.imageData!)
            imageFromCameraRoll.image = image
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editVC"{
            let editViewController = segue.destinationViewController as! EditViewController
            editViewController.foodstuff = foodstuff
            editViewController.recipe = recipe
            editViewController.recipetitle = recipetitle
            editViewController.currentNumber = currentNumber
            editViewController.selectImage = imageData
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
