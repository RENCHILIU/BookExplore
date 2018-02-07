//
//  addBookViewController.swift
//  BookExplore
//
//  Created by liurenchi on 2/6/18.
//  Copyright © 2018 lrc. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Eureka
import Parse
class addBookViewController: FormViewController {
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        
        form +++ Section("Add the book id")
            <<< IntRow(){
                $0.tag = "book_id"
            }
        form +++ Section("Function")
            <<< ButtonRow(){
                $0.title = "Add this book to the back-end server"
                }.onCellSelection({ (cell, row) in
                    if let book_id = (self.form.rowBy(tag: "book_id") as! IntRow).value{
                        print(book_id)
                        
                        //                        // init data
                        //                        for id in boodID {
                        
          
                        let requestUrl: String = "https://api.douban.com/v2/book/" + String(book_id)
                        
                        Alamofire.request(requestUrl).responseJSON(completionHandler: { (response) in
                            if let json = response.result.value {
                                let responseResult = JSON(json)
                                
                                self.createPFObject(json: responseResult, className: "BOOK")
                                
                                
                            }
                        })
                        
                        //                        }
                    }
                })
            <<< ButtonRow(){
                $0.title = "Back to book explore"
                }.onCellSelection({ (cell, row) in
                    self.dismiss(animated: true, completion: nil)
                })
        
        
    }
    
    
    
    func createPFObject(json: JSON, className: String) {
        let thisbook = PFObject(className: className)
        
        thisbook["rating"] = json["rating"]["average"].stringValue
        thisbook["author"] = json["author"][0].stringValue
        thisbook["images"] = json["images"]["large"].stringValue
        thisbook["title"] = json["title"].stringValue
        thisbook["summary"] = json["summary"].stringValue
        thisbook["author_intro"] = json["author_intro"].stringValue
        thisbook["isbn10"] = json["isbn10"].stringValue
        thisbook["publisher"] = json["publisher"].stringValue
        thisbook["id"] = json["id"].stringValue
        thisbook["price"] = json["price"].stringValue
        thisbook.saveInBackground(block: { (success, error) in
            if error == nil{
                 self.dismiss(animated: true, completion: nil)
                print("success!")
            }else{
                self.displayAlert(title: "Error", message: error as! String)
            }
        })
        
        
        
    }
    
    
    
    
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func displayAlert(title:String, message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
