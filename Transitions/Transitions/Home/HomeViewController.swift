//
//  HomeViewController.swift
//  Transitions
//
//  Created by don chen on 2018/1/10.
//  Copyright © 2018年 Don Chen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var goButton: UIButton!
    let owlImageView = UIImageView(image: UIImage(named:"img-owl"))
    let catImageView = UIImageView(image: UIImage(named:"img-cat"))
    
    @IBOutlet weak var optionsSegment: UISegmentedControl!
    var isReverseNeeded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Transitions"
        setupView()
    }
    
    fileprivate func setupView() {
        let screen = UIScreen.main.bounds
        goButton.layer.cornerRadius = 22
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
        containerView.backgroundColor = UIColor(red: 6/255, green: 111/255, blue: 165/255, alpha: 1.0)
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.layer.borderWidth = 2
        containerView.layer.cornerRadius = 20
        containerView.center = CGPoint(x: screen.midX, y: screen.midY)
        view.addSubview(containerView)
        
        catImageView.frame.size = CGSize(width: 100, height: 100)
        catImageView.center = CGPoint(x: containerView.frame.width/2, y: containerView.frame.height/2)
        catImageView.layer.cornerRadius = 50
        catImageView.clipsToBounds = true
        
        owlImageView.frame.size = CGSize(width: 100, height: 100)
        owlImageView.center = CGPoint(x: containerView.frame.width/2, y: containerView.frame.height/2)
        owlImageView.layer.cornerRadius = 50
        owlImageView.clipsToBounds = true
        
        containerView.addSubview(owlImageView)
    }
    
    @IBAction func goButtonClickHandler(_ sender: Any) {
        doTransition()
    }
    
    fileprivate func doTransition() {
        let duration = 0.5
        
        var option:UIViewAnimationOptions = .transitionCrossDissolve
        switch optionsSegment.selectedSegmentIndex {
            case 0: option = .transitionFlipFromLeft
            case 1: option = .transitionFlipFromRight
            case 2: option = .transitionCurlUp
            case 3: option = .transitionCurlDown
            case 4: option = .transitionCrossDissolve
            case 5: option = .transitionFlipFromTop
            case 6: option = .transitionFlipFromBottom
            default:break
        }
        
        if isReverseNeeded {
            UIView.transition(from: catImageView, to: owlImageView, duration: duration, options: option, completion: nil)
            
        } else {
            UIView.transition(from: owlImageView, to: catImageView, duration: duration, options: option, completion: nil)
            
        }
        
        isReverseNeeded = !isReverseNeeded
        
    }
    



}
