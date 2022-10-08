//
//  LoadingVC.swift
//  UserApp
//
//  Created by Esin Esen on 10.04.2022.
//

import UIKit

class LoadingVC: UIViewController {
    
    private var loadingActivityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        
        indicator.style = .large
        indicator.color = .white

        indicator.startAnimating()
        indicator.autoresizingMask = [
            .flexibleLeftMargin, .flexibleRightMargin,
            .flexibleTopMargin, .flexibleBottomMargin
        ]
            
        return indicator
    }()
    
    private var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.alpha = 0.5
        blurEffectView.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
        
        return blurEffectView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.dismissVC), userInfo: nil, repeats: false)
        
        view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        
        blurEffectView.frame = self.view.bounds
        view.insertSubview(blurEffectView, at: 0)
        loadingActivityIndicator.center = CGPoint(
            x: view.bounds.midX,
            y: view.bounds.midY
        )
        view.addSubview(loadingActivityIndicator)
    }
    
    @objc func dismissVC() {
        let usersVC = self.storyboard?.instantiateViewController(withIdentifier: "UsersVC") as! UsersVC
        usersVC.modalPresentationStyle = .fullScreen
        usersVC.modalTransitionStyle = .crossDissolve
        present(usersVC, animated: true, completion: nil)
    }
}
