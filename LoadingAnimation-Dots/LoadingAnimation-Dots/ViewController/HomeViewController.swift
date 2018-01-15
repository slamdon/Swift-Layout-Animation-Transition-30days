//
//  HomeViewController.swift
//  LoadingAnimation-Dots
//
//  Created by don chen on 2018/1/14.
//  Copyright © 2018年 Don Chen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Loading - Zhihu"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupView()
    }
    
    fileprivate func setupView() {
        view.backgroundColor = UIColor.black
        
        let loadingView = LoadingView(frame: CGRect(x: view.frame.midX - 40, y: view.frame.midY - 100, width: 80, height: 80))
        loadingView.startLoading()
        view.addSubview(loadingView)
    }
    

    
    

}
