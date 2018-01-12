//
//  HomeViewController.swift
//  StartPageMovie
//
//  Created by don chen on 2018/1/12.
//  Copyright © 2018年 Don Chen. All rights reserved.
//

import UIKit
import AVKit

class HomeViewController: UIViewController {
    var movieController:AVPlayerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Start Page Movie"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupView()
    }
    
    fileprivate func setupView() {
        if let path = Bundle.main.path(forResource: "movie", ofType: "mp4") {
            let movieURL = URL(fileURLWithPath: path)
            let player = AVPlayer(url: movieURL)
            player.actionAtItemEnd = .none
            
            movieController = AVPlayerViewController()
            movieController?.player = player
            movieController?.view.frame = view.bounds
            movieController?.showsPlaybackControls = false
            movieController?.videoGravity = AVLayerVideoGravity.resizeAspectFill.rawValue
            movieController?.player?.play()
            movieController?.view.alpha = 0
            view.addSubview(movieController!.view)
            
            UIView.animate(withDuration: 3, animations: {
                self.movieController?.view.alpha = 1
            })
        }
        
        let button = UIButton()
        button.frame.size = CGSize(width: 160, height: 44)
        button.center = CGPoint(x: view.frame.midX, y: view.frame.maxY - 100)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 22
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 2
        button.setTitle("START", for: .normal)
        
        view.addSubview(button)

    }

}
