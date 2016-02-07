//
//  ViewController.swift
//  TechPod
//
//  Created by 佐々木華 on 2015/09/27.
//  Copyright (c) 2015年 Hana sasaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITextFieldDelegate, UITextViewDelegate, UITableViewDelegate {
    
    @IBOutlet var table: UITableView!    
    let saveData: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    let recipManager = RecipManager.sharedInstance
    var memoArray = [Dictionary<String, AnyObject>]()
    
    var currentRecipeDic: Dictionary<String, AnyObject>?
    var currentNumber: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //         Do any additional setup after loading the view, typically from a nib.
        
//        [UINavigationBar appearance].barTintColor = [UIColor :0.000 green:0.549 blue:0.890 alpha:1.000];        
        UINavigationBar.appearance().barTintColor = UIColor(red: 223/255, green: 98/255, blue: 89/255, alpha: 1)
        
        table.separatorStyle = .None
        table.dataSource = self
        table.delegate = self
        
        let nib  = UINib(nibName: "PostTableViewCell", bundle:nil)
        self.table.registerNib(nib, forCellReuseIdentifier:"PostTableViewCell")
        
        let recipenib  = UINib(nibName: "RecipeCell", bundle:nil)
        self.table.registerNib(recipenib, forCellReuseIdentifier:"RecipeCell")
        if saveData.objectForKey("memos") != nil {
            recipManager.memoArray =  saveData.objectForKey("memos") as!  [Dictionary<String, AnyObject>]
        }
        print(memoArray.count)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
            table.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        // super.didReciveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
            return recipManager.memoArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCellWithIdentifier("RecipeCell") as! RecipeCell
                let recip = recipManager.memoArray[indexPath.row]
                cell.RecipeTextField.text = recip["title"] as? String
                 cell.imageView?.image = UIImage(data: (recip["image"] as? NSData)!)
//                cell.RecipeTextView.text = recip["content"]
                return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let recipDic =  recipManager.memoArray[indexPath.row]
        self.currentRecipeDic = recipDic
        self.currentNumber = Int(indexPath.row)
         performSegueWithIdentifier("showTweetVC", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showTweetVC"{
            let recipeViewController = segue.destinationViewController as! RecipeViewController
            recipeViewController.foodstuff = self.currentRecipeDic!["content"] as? String
            recipeViewController.recipe = self.currentRecipeDic!["recipe"] as? String
            recipeViewController.currentNumber = self.currentNumber
            recipeViewController.recipetitle = self.currentRecipeDic!["title"] as? String
            
            recipeViewController.imageData = self.currentRecipeDic!["image"] as? NSData
        }
    }
    

    @IBAction func postMemo(){
        performSegueWithIdentifier("modalNewRecip", sender: self)
    }
}

