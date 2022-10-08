//
//  PostDetailsViewModel.swift
//  UserApp
//
//  Created by Esin Esen on 10.04.2022.
//

import UIKit
class PostDetailsViewModel {
    
    var reloadList = {() -> () in }
    var errorMessage = {(message : String) -> () in }
    
    var arrayOfList : [Comment] = []{
        didSet{
            reloadList()
        }
    }
    
    //parsing json for comments
    func getListData()  {
        guard let listURL = URL(string: "https://jsonplaceholder.typicode.com/comments")else {
            return
        }
        URLSession.shared.dataTask(with: listURL){
            (data,response,error) in
            guard let jsonData = data else { return }
            do {
                let decoder = JSONDecoder()
                if let jsonPosts = try? decoder.decode([Comment].self, from: jsonData) {
                    //filtering comments to see only selected post's comments
                    self.arrayOfList = jsonPosts.filter{$0.postId == Int(PostDetailsVC.id)}
                }
            } catch let error {
                print("Error ->\(error.localizedDescription)")
                self.errorMessage(error.localizedDescription)
            }
        }.resume()
    }
    
    //parsing json for post details
    func getUrl(postId : String){
            
        var postDetails : Post
            
        let urlStr = "https://jsonplaceholder.typicode.com/posts/\(postId)"
        guard let postURL = URL(string: urlStr) else { return }
        let postList = try? JSONDecoder().decode(Post.self, from: Data(contentsOf: postURL))
        guard let posts = postList else { return }
        postDetails = posts

        let model = postDetails
        PostDetailsVC.title = model.title ?? "no title"
        PostDetailsVC.body = model.body ?? "no body"
    }
}
