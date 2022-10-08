//
//  Comment.swift
//  UserApp
//
//  Created by Esin Esen on 6.04.2022.
//

import Foundation

struct Comment : Decodable {
    let postId : Int?
    let id : Int?
    let name : String?
    let email : String?
    let body : String?
}
