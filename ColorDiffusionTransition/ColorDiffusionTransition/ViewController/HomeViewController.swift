//
//  HomeViewController.swift
//  ColorDiffusionTransition
//
//  Created by don chen on 2018/1/8.
//  Copyright © 2018年 Don Chen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    var diffustionTransition:SKDiffussionTransition!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Color Diffusion Transition"
        view.backgroundColor = UIColor(red: 11/255, green: 155/255, blue: 169/255, alpha: 1.0)
        
        diffustionTransition = SKDiffussionTransition(animatedView: button)
    }
    
    
    @IBAction func buttonClickHandler(_ sender: Any) {
        let VC = DetailViewController()
        VC.modalPresentationStyle = .custom
        VC.transitioningDelegate = diffustionTransition
        present(VC, animated: true, completion: nil)
    }
    
}
