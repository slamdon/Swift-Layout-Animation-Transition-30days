//
//  HomeViewController.swift
//  ImageSlider
//
//  Created by don chen on 2017/12/23.
//  Copyright © 2017年 Don Chen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    fileprivate var timer: Timer!
    fileprivate var currentPos:Int = 0
    fileprivate var images:[UIImage] = [UIImage]()
    fileprivate var imageSliderView: ImageSliderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Image Slider"
        setupData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer.invalidate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupView()
    }
    
    private func setupData() {
        images.append(UIImage(named: "img-1")!)
        images.append(UIImage(named: "img-2")!)
        images.append(UIImage(named: "img-3")!)
        images.append(UIImage(named: "img-4")!)
        images.append(UIImage(named: "img-5")!)
        images.append(UIImage(named: "img-6")!)
    }
    
    private func setupView() {
        // setup imageSliderView
        let screen = UIScreen.main.bounds
        let image = images[0]
        let imageWidth =  screen.width - 20
        let imageHeight = ((screen.width - 20) / image.size.width) * image.size.height
        imageSliderView = ImageSliderView(frame: CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight))
        imageSliderView.center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2)
        imageSliderView.layer.borderWidth = 3
        imageSliderView.layer.borderColor = UIColor.black.cgColor
        imageSliderView.setImage(image, animated: false)
        view.addSubview(imageSliderView)
        
        // setup timer
        timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(HomeViewController.changeImageEvent), userInfo: nil, repeats: true)
    }
    
    @objc func changeImageEvent() {
        // take next image
        let nextPos = currentPos % images.count
        currentPos += 1
        imageSliderView.setImage(images[nextPos], animated: true)
        
        // image changing animation
        let screen = UIScreen.main.bounds
        UIView.animate(withDuration: 0.5, animations: {
            // calculate new iamge bounds
            let imageWidth =  screen.width - 20
            let imageHeight = ((screen.width - 20) / self.imageSliderView.image!.size.width) * self.imageSliderView.image!.size.height
            var tempRect = self.imageSliderView.bounds
            tempRect.size = CGSize(width: imageWidth, height: imageHeight)
            
            // update imageSliderView's bounds & center
            self.imageSliderView.bounds = tempRect
            self.imageSliderView.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
        })
    }

}
