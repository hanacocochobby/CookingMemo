//
//  EditViewController.swift
//  cookingmemo
//
//  Created by 佐々木華 on 2015/12/06.
//  Copyright © 2015年 Hana sasaki. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var foodstuffTextView: UITextView!
    @IBOutlet weak var recipeTextVIew: UITextView!
    
    @IBOutlet weak var imageFromCameraRoll: UIImageView!
    
    let saveData: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    let recipManager = RecipManager.sharedInstance
    
    var foodstuff: String?
    var recipe: String?
    var recipetitle: String?
    var currentNumber: Int?
    var selectImage:  NSData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodstuffTextView.text = foodstuff
        recipeTextVIew.text = recipe
        self.title = recipetitle
        // Do any additional setup after loading the view.
        
        let image = UIImage(data: self.selectImage!)
        imageFromCameraRoll.image = image
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickImageFromLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let controller = UIImagePickerController()
            controller.delegate = self
            
            //新しく宣言したViewControllerでカメラとカメラロールのどちらを表示するかを指定
            controller.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            
            //新たに追加したカメラロール表示ViewControllerをpresentViewControllerにする
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo: [String: AnyObject]) {
        
        if didFinishPickingMediaWithInfo[UIImagePickerControllerOriginalImage] != nil {
            let image = didFinishPickingMediaWithInfo[UIImagePickerControllerOriginalImage] as? UIImage
            
            //didFinishPickingMediaWithInfo通して渡された画像情報をUIImageにCastする
            //それを宣言済みのimageViewへ入れる
            imageFromCameraRoll.image = image
            
            let imageData = UIImagePNGRepresentation(image!)
            self.selectImage = imageData!
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveRecip(sender: AnyObject) {
        
        // TODO:  画像のNSDataをStringに変換するときにnilになってしまうので、完了ボタンを押すと落ちてしまう
//        let recip = ["title": self.title!, "content": foodstuffTextView.text, "recipe": recipeTextVIew.text, "image": self.selectImage]//レシピ１つの情報
        
        let recip = ["title":  self.title!, "content":  foodstuffTextView.text, "recipe":  recipeTextVIew.text, "image":  self.selectImage] //レシピ１つの情報
        
        
//                let recip: [String: AbyObject] = ["title": self.title!, "content": foodstuffTextView.text, "recipe": recipeTextVIew.text, "image": String(data: self.selectImage!, encoding: NSUTF8StringEncoding)!]//レシピ１つの情報
        
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
    
    @IBAction func pressCameraRoll(sender: AnyObject) {
        pickImageFromLibrary()  //ライブラリから写真を選択する
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
