//
//  HomeViewController.swift
//  ParallaxScrolling
//
//  Created by don chen on 2017/12/24.
//  Copyright © 2017年 Don Chen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    fileprivate var scrollView: UIScrollView!
    fileprivate var baseTag = 1024
    fileprivate var images  = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Parallax Scrolling"
        setupView()
    }
    
    private func setupView() {
        // setup images
        images.append(UIImage(named: "img-1")!)
        images.append(UIImage(named: "img-2")!)
        images.append(UIImage(named: "img-3")!)
        images.append(UIImage(named: "img-4")!)
        images.append(UIImage(named: "img-5")!)
        
        // setup ScrollView
        scrollView                                = UIScrollView(frame: view.bounds)
        scrollView.delegate                       = self
        scrollView.isPagingEnabled                = true
        scrollView.bounces                        = false
        scrollView.backgroundColor                = UIColor.black
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.contentSize = CGSize(width: CGFloat(images.count) * UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        view.addSubview(scrollView)
        
        for (pos, image) in images.enumerated() {
            let parallexView = ParallexView(frame: CGRect(x: CGFloat(pos) * UIScreen.main.bounds.width, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
            parallexView.imageView.image = image
            parallexView.tag = baseTag + pos
            scrollView.addSubview(parallexView)
            print("x: \(parallexView.frame.origin.x)")
        }
    }

}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let rate = 300 / view.bounds.width
        let offset = scrollView.contentOffset.x
        for i in 0 ..< images.count {
            // update imageView's frame
            let parallaxView = scrollView.viewWithTag(baseTag + i) as! ParallexView
            let newX:CGFloat = rate * (offset - CGFloat(i) * UIScreen.main.bounds.width)
            parallaxView.imageView.frame = CGRect(x: newX,
                                                  y: parallaxView.imageView.frame.origin.y,
                                                  width: parallaxView.imageView.frame.width,
                                                  height: parallaxView.imageView.frame.height)
        }
    }
}
