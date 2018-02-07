//
//  ViewController.swift
//  BookExplore
//
//  Created by liurenchi on 2/6/18.
//  Copyright © 2018 lrc. All rights reserved.
//

import UIKit
import Parse
import SDWebImage

class ViewController: UIViewController {
    var booksDisplay:[Book] = []
    
    @IBOutlet var bookImage: UIImageView!
    @IBOutlet var bookTitle: UILabel!
    @IBOutlet var bookRate: UILabel!
    @IBOutlet var bookAuthor: UILabel!
    @IBOutlet var bookPrice: UILabel!
    @IBOutlet var bookISBN: UILabel!
    
    
    @IBOutlet var displayView: UIView!
    var oriCenter: CGPoint!
    
    var viewedID: [String] = []
    
   
    
    
    
    override func viewWillAppear(_ animated: Bool) {
         getBookData()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        oriCenter = displayView.center
        //  initBook()
        bookImage.layer.shadowColor = UIColor.lightGray.cgColor
        bookImage.layer.shadowOpacity = 0.8
        bookImage.layer.shadowRadius = 4
        
       
    }
    
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
       
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y)
        }
       //  the translation will keep compounding each time
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        // after drag.
        if recognizer.state == .ended{
           
            
            if recognizer.view!.center.x < view.bounds.width / 2 - 100 || recognizer.view!.center.x > view.bounds.width / 2 + 100{
                self.updateBookView()
            }
             recognizer.view?.center = oriCenter
           
            
        }
        
    }
    
    
    
    
    
    
    func updateBookView(){
        
        
        
        
        if let currentBook = booksDisplay.popLast(){
            
            if let imageurl = currentBook.image{
                bookImage.sd_setImage(with: URL(string: imageurl), placeholderImage: UIImage(named: "nodata"))
            }
            if let title = currentBook.title{
                bookTitle.text = "Title: " + title
            }
            if let Rate = currentBook.rate{
                bookRate.text = "Rate: " + Rate
            }
            if let author = currentBook.author{
                bookAuthor.text = "Author: " + author
            }
            if let price = currentBook.price{
                bookPrice.text = "Price: " + price
            }
            if let isbn = currentBook.ISBN{
                bookISBN.text = "ISBN: " + isbn
            }
            
        }else{
            bookImage.image = UIImage(named:"nodata")
            
            bookTitle.text = "There is no Data to display"

            bookRate.text = ""
            
            bookAuthor.text = ""
            
            bookPrice.text = ""
            
            bookISBN.text = ""
        }
        
        
        
        
        
    }
    
    
    func getBookData() {
        
        let query = PFQuery(className:"BOOK")
        
        query.findObjectsInBackground { (objects, error) in
            if error == nil {
                // The find succeeded.
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        let book = Book(thisbook: object)
                        self.booksDisplay.append(book)
                    }
                    
                    self.updateBookView()
                }
            } else {
                print(error!)
            }
            
            
            
        }
        
        
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    func initBook()  {
        let input:[String] = [
            "你在哪里3",
            "9.2",
            "[法] 马克·李维",
            "2017",
            "42",
            "9787540483500",
            "https://img3.doubanio.com/lpic/s29597786.jpg",
            "苏珊与菲利普从小一起长大，他们是彼此生命里的一切，然而命运却让 他们不断分离。过早经历家庭变故的苏珊一直学不会与这个世界和平相处，即便是在最爱她的人身边，她也无法克服内心的慌乱。于是，她不断地逃离，远走他乡去帮助那些因飓风失去家园的人。苏珊知道，不管她走到哪里，不管岁月带给他们多少变化，菲利普都是她最后的依靠，是她唯一可以托付生命的人。这是他们彼此的承诺，而这个承诺将给他们的命运带来不可预",
            "法国作家，作品热销49个国家，总销量超过4000万册，连续17年蝉联“法国十大畅销书作家”。已在中国出版《偷影子的人》《伊斯坦布尔假期》《如果一切重来》《比恐惧更强烈的情感》《第一日》《第一夜》《幸福的另一种含义》《那些我们没谈过的事》 《在另一种生命里》《生命里最美好的春天》《假如这是真的》《她和他》《与你重逢》《倒悬的地平线》《你在哪里？》等。",
            "https://book.douban.com/subject/27188298/?icn=index-editionrecommend",
            
            ]
        
        self.createBook(inputInformation: input)
        
    }
    
    
    func createBook(inputInformation:[String]){
        let thisbook = PFObject(className:"BOOK")
        var information = ["title","rate","author","year","price","ISBN","image","bookDetail","authorDetail","url"]
        var count = 0
        for item in inputInformation{
            thisbook[information[count]] = item
            thisbook.saveInBackground {
                (success: Bool, error: Error?) in
                if (success) {
                    print( "The object has been saved.")
                } else {
                    print( "There was a problem, check error.description")
                }
            }
            count = count + 1
            
        }
    }
    
    
    
    
    
}

