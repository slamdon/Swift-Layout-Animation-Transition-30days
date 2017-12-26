//
//  HomeViewController.swift
//  ScratchCard
//
//  Created by don chen on 2017/12/26.
//  Copyright © 2017年 Don Chen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var scratchCardView:SKScratchCardView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Scratch Card"
        setupView()
    }
    
    private func setupView() {
        let imageView = UIImageView(image: UIImage(named: "img-1"))
        imageView.contentMode = .scaleAspectFill
        
        let coverView = UIImageView(image: UIImage(named: "bg-home"))
        coverView.contentMode = .scaleAspectFill
        
        let screen = UIScreen.main.bounds
        scratchCardView = SKScratchCardView(frame: screen)
        scratchCardView!.setupWith(coverView: coverView, contentView: imageView)
        view.addSubview(scratchCardView!)
                
        let barButtonItem = UIBarButtonItem(image: UIImage(named:"icon-eraser")?.withRenderingMode(.alwaysOriginal),
                                            style: .done,
                                            target: self,
                                            action: #selector(clearButtonClickHandler))
        navigationItem.setRightBarButton(barButtonItem, animated: false)
    }
    
    @objc private func clearButtonClickHandler(){
        print("clear")
        scratchCardView?.clearCanvas()
    }


}
