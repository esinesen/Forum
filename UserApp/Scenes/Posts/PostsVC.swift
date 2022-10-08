//
//  PostsVC.swift
//  UserApp
//
//  Created by Esin Esen on 5.04.2022.
//

import UIKit

class PostsVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    private var viewModel = PostsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageSetup()
        
        nameLabel.text = PostsViewModel.selectedUser[0].name
        usernameLabel.text = PostsViewModel.selectedUser[0].username
    }
    
    private func pageSetup()  {
        viewModel.getListData()
        viewModel.reloadList = { [weak self] ()  in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        viewModel.errorMessage = { (message) in
            DispatchQueue.main.async {
                print(message)
            }
        }
    }
}

extension PostsVC : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath as IndexPath) as! PostCell
        
        let listObj = viewModel.arrayOfList[indexPath.row]
        cell.configure(model: listObj)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.arrayOfList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath as IndexPath) as! PostCell
        let listObj = viewModel.arrayOfList[indexPath.row]
        selectedItem.configure(model: listObj)
        
        PostDetailsVC.id = selectedItem.id
        
        let postsDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "PostDetailsVC") as! PostDetailsVC
        postsDetailsVC.modalPresentationStyle = .fullScreen
        postsDetailsVC.modalTransitionStyle = .crossDissolve
        
        present(postsDetailsVC, animated: true, completion: nil)
    }
}
