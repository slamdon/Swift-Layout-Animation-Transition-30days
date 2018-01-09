//
//  DetailViewController.swift
//  Expand
//
//  Created by don chen on 2017/2/3.
//  Copyright © 2017年 Don Chen. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    var image:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if image != nil {
            backgroundImageView.image = image
        }
        
    }
    
}
