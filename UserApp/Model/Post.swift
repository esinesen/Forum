//
//  Post.swift
//  UserApp
//
//  Created by Esin Esen on 5.04.2022.
//

import Foundation

struct Post : Decodable {
    let userId : Int?
    let id : Int?
    let title : String?
    let body : String?
}
