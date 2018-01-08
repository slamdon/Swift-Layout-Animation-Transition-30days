//
//  DetailViewController.swift
//  ColorDiffusionTransition
//
//  Created by don chen on 2018/1/8.
//  Copyright © 2018年 Don Chen. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Detail ViewController"
        view.backgroundColor = UIColor(red: 244/255, green: 109/255, blue: 120/255, alpha: 1.0)
    }

    @IBAction func buttonClickHandler(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
