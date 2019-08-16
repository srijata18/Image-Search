//
//  FlickrItem.swift
//  flickr
//
//  Created by Amit Gulati on 11/12/17.
//  Copyright © 2017 Amit Gulati. All rights reserved.
//

import Foundation

class PhotoItem : Codable {
    var title:String?
    var url_s:String?
}
class Photo : Codable {
    var photo:[PhotoItem]?
    let page: Int
    let pages: Int
    let perpage: Int
    let total: String
}
class Flickr : Codable {
    var photos:Photo?
    let stat: String
}
