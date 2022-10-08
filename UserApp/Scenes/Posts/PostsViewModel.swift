//
//  PostsViewModel.swift
//  UserApp
//
//  Created by Esin Esen on 10.04.2022.
//

import UIKit
class PostsViewModel {
    
    var reloadList = {() -> () in }
    var errorMessage = {(message : String) -> () in }
    
    var arrayOfList : [Post] = []{
        didSet{
            reloadList()
        }
    }
    
    static var selectedUser = [User]()
    
    func getListData()  {
        guard let listURL = URL(string: "https://jsonplaceholder.typicode.com/posts")else {
            return
        }
        URLSession.shared.dataTask(with: listURL){
            (data,response,error) in
            guard let jsonData = data else { return }
            do {
                let decoder = JSONDecoder()
                if let jsonPosts = try? decoder.decode([Post].self, from: jsonData) {
                    //filtering posts to see only selected user's posts
                    self.arrayOfList = jsonPosts.filter{$0.userId == PostsViewModel.selectedUser[0].id}
                }
            } catch let error {
                print("Error ->\(error.localizedDescription)")
                self.errorMessage(error.localizedDescription)
            }
        }.resume()
    }
}
