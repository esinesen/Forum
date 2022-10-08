//
//  UsersVC.swift
//  UserApp
//
//  Created by Esin Esen on 4.04.2022.
//

import UIKit

class UsersVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = UsersViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageSetup()
    }
    
    private func pageSetup()  {
        viewModel.getListData()
        viewModel.reloadList = { [weak self] ()  in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        viewModel.errorMessage = { (message)  in
            DispatchQueue.main.async {
                print(message)
            }
        }
    }
}

extension UsersVC : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath as IndexPath) as! UserCell
        
        let listObj = viewModel.arrayOfList[indexPath.row]
        cell.configure(model: listObj)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.arrayOfList.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath as IndexPath) as! UserCell
        let listObj = viewModel.arrayOfList[indexPath.row]
        selectedItem.configure(model: listObj)
     
        let postsVC = self.storyboard?.instantiateViewController(withIdentifier: "PostsVC") as! PostsVC
        postsVC.modalPresentationStyle = .fullScreen
        postsVC.modalTransitionStyle = .crossDissolve
        
        PostsViewModel.selectedUser.insert((User(id: Int(selectedItem.id)!, name: selectedItem.nameLabel.text!, username: selectedItem.usernameLabel.text!, email: "")), at: 0)
        
        present(postsVC, animated: true, completion: nil)
    }
}
