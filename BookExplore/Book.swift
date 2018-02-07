//
//  Book.swift
//  BookExplore
//
//  Created by liurenchi on 2/6/18.
//  Copyright © 2018 lrc. All rights reserved.
//

import Foundation
import Parse

class Book {
    var title:String?
    var rate:String?
    var author: String?
    var year: String?
    var price: String?
    var ISBN: String?
    var image: String?
    
    var bookDetail: String?
    var authorDetail: String?
    var url: String?
    
    
    
    init(thisbook: PFObject) {
        title = thisbook["title"] as? String
        rate = thisbook["rating"] as? String
        author = thisbook["author"] as? String
        year = thisbook["year"] as? String
        price = thisbook["price"] as? String
        ISBN = thisbook["isbn10"] as? String
        image = thisbook["images"] as? String
        bookDetail = thisbook["summary"] as? String
        authorDetail = thisbook["author_intro"] as? String
        url = thisbook["url"] as? String
    }
    
    
    
}
