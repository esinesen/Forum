//
//  UsersViewModel.swift
//  UserApp
//
//  Created by Esin Esen on 10.04.2022.
//

import UIKit
class UsersViewModel {
    
    var reloadList = {() -> () in }
    var errorMessage = {(message : String) -> () in }
    
    var arrayOfList : [User] = []{
        didSet{
            reloadList()
        }
    }
    
    func getListData()  {
        guard let listURL = URL(string: "https://jsonplaceholder.typicode.com/users")else {
            return
        }
        URLSession.shared.dataTask(with: listURL){
            (data,response,error) in
            guard let jsonData = data else { return }
            do {
                let decoder = JSONDecoder()
                self.arrayOfList = try decoder.decode([User].self, from: jsonData)
            } catch let error {
                print("Error ->\(error.localizedDescription)")
                self.errorMessage(error.localizedDescription)
            }
        }.resume()
    }
}
