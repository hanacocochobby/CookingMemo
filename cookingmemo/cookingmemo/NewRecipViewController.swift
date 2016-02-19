//
//  NewRecipViewController.swift
//  cookingmemo
//
//  Created by 佐々木華 on 2015/11/22.
//  Copyright © 2015年 Hana sasaki. All rights reserved.
//

import UIKit

class NewRecipViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var recipe: UITextView!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var imageFromCameraRoll: UIImageView!
    
    let saveData: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    let recipManager = RecipManager.sharedInstance
    var selectImage =  NSData()
    
    
        override func viewDidLoad() {
        super.viewDidLoad()
        
            imageFromCameraRoll.contentMode = .ScaleAspectFit
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickImageFromLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            
            //写真ライブラリ(カメラロール)表示用のViewControllerを宣言
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
            
//            NSUserDefaults.standardUserDefaults().setObject(imageData, forKey: "image")
//            NSUserDefaults.standardUserDefaults().synchronize()
    }
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func tapBackButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func pressCameraRoll(sender: AnyObject) {
        pickImageFromLibrary()  //ライブラリから写真を選択する
    }
    
    @IBAction func saveRecip(sender: AnyObject) {
        if titleTextField.text == "" {
            let alert = UIAlertController(title: "未入力項目があります", message: "タイトルを入力してください", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
                self.dismissViewControllerAnimated(true, completion: nil)
                return
            }))
            presentViewController(alert, animated: true, completion: nil)
        }else {
            let recip = ["title": titleTextField.text!, "content": titleTextView.text! , "recipe": recipe.text!, "image": self.selectImage] //レシピ１つの情報
            
            recipManager.memoArray.insert(recip, atIndex: 0)
            saveData.setObject(recipManager.memoArray, forKey: "memos")
            saveData.synchronize()
            
            let alert = UIAlertController(title: "保存", message: "メモの保存が完了しました", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
                self.dismissViewControllerAnimated(true, completion: nil)
                return
            }))
            presentViewController(alert, animated: true, completion: nil)
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
