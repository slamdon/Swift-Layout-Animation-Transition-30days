//
//  ViewController.swift
//  Test
//
//  Created by don chen on 2017/12/20.
//  Copyright © 2017年 Don Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var aLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonClickHandler(_ sender: Any) {
        
        UIView.animate(withDuration: 1000, animations: {
            self.aLabel.text = "10"
        })
    }
    
    
}

