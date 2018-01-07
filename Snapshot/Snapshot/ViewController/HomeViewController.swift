//
//  HomeViewController.swift
//  Snapshot
//
//  Created by don chen on 2018/1/7.
//  Copyright © 2018年 Don Chen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var snapshotButton: UIButton!
    var captureView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Snapshot"
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    fileprivate func setupView() {
        let screen = UIScreen.main.bounds
        
        snapshotButton.layer.cornerRadius = 22
        snapshotButton.backgroundColor = UIColor(red: 17/255, green: 151/255, blue: 128/255, alpha: 1.0)
        snapshotButton.setTitleColor(UIColor.white, for: .normal)
        
        captureView = UIView(frame: CGRect(x: screen.midX - 60 , y: 40, width: 200, height: 200))
        captureView.layer.borderColor = UIColor.yellow.cgColor
        captureView.layer.borderWidth = 2
        captureView.backgroundColor = UIColor.black
        captureView.alpha = 0.4
        
        view.addSubview(captureView)
    }
    
    @IBAction func snapshotClickHandler(_ sender: Any) {
        let image = captureSunImageView()
        let VC = DetailViewController()
        VC.snapshotImage = image
        navigationController?.pushViewController(VC, animated: true)
    }
    
    fileprivate func captureSunImageView() ->  UIImage {
        // 抓一張SourceView的圖（HomeViewController）
        UIGraphicsBeginImageContextWithOptions((view.bounds.size), true, 1)
        view?.drawHierarchy(in: view.bounds, afterScreenUpdates: false)
        let snapShot = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // SnapShot的圖
        let tempImageRef = snapShot.cgImage!
        let croppedImageRef = tempImageRef.cropping(to: captureView.frame)
        
        let croppedImage = UIImage(cgImage: croppedImageRef!, scale: snapShot.scale, orientation: UIImageOrientation.up)
        
        return croppedImage
    }
    
}
