//
//  PostDetailsVC.swift
//  UserApp
//
//  Created by Esin Esen on 6.04.2022.
//

import UIKit

class PostDetailsVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var commentsBtn: UIButton!
    
    static var id = " "
    static var title = ""
    static var body = ""
    
    private var viewModel = PostDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageSetup()
        
        titleLabel.text = PostDetailsVC.title
        bodyLabel.text = PostDetailsVC.body
        
        collectionView.isHidden = true
    }
    
    private func pageSetup()  {
        viewModel.getListData()
        viewModel.getUrl(postId: PostDetailsVC.id)
        viewModel.reloadList = { [weak self] ()  in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        viewModel.errorMessage = { (message)  in
            DispatchQueue.main.async {
                print(message)
            }
        }
    }
    
    @IBAction func commentsBtnClicked(_ sender: UIButton) {
        if collectionView.isHidden == true {
            commentsBtn.setTitle("Hide Comments", for: .normal)
            collectionView.isHidden = false
        } else if collectionView.isHidden == false {
            commentsBtn.setTitle("Show Comments", for: .normal)
            collectionView.isHidden = true
        }
    }
}

extension PostDetailsVC : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "commentsCell", for: indexPath as IndexPath) as! CommentsCell
        
        let listObj = viewModel.arrayOfList[indexPath.row]
        cell.configure(model: listObj)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.arrayOfList.count
    }
}
