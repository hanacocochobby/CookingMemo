//
//  EditViewController.swift
//  cookingmemo
//
//  Created by 佐々木華 on 2015/12/06.
//  Copyright © 2015年 Hana sasaki. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    
    @IBOutlet weak var foodstuffTextView: UITextView!
    @IBOutlet weak var recipeTextVIew: UITextView!
    
    @IBOutlet weak var imageFromCameraRoll: UIImageView!

    let saveData: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    let recipManager = RecipManager.sharedInstance
    
    var foodstuff: String?
    var recipe: String?
    var recipetitle: String?
    var currentNumber: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        foodstuffTextView.text = foodstuff
        recipeTextVIew.text = recipe
         self.title = recipetitle
        // Do any additional setup after loading the view.
        
        let imageData = NSUserDefaults.standardUserDefaults().objectForKey("image") as! NSData
        
        let image = UIImage(data: imageData)
        imageFromCameraRoll.image = image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func saveRecip(sender: AnyObject) {
        
        
        
        let recip: [String: String] = ["title": self.title!, "content": foodstuffTextView.text, "recipe": recipeTextVIew.text]//レシピ１つの情報
        
        print(recip)
        print(recipManager.memoArray[currentNumber!])
        
        recipManager.memoArray[currentNumber!] = recip
        saveData.setObject(recipManager.memoArray, forKey: "memos")
        saveData.synchronize()
        
        let alert = UIAlertController(title: "保存", message: "メモの保存が完了しました", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
            self.dismissViewControllerAnimated(true, completion: nil)
            return
        }))
        presentViewController(alert, animated: true, completion: nil)
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
