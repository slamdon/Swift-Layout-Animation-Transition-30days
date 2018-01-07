//
//  DetailViewController.swift
//  Snapshot
//
//  Created by don chen on 2018/1/7.
//  Copyright © 2018年 Don Chen. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var snapshotImageView: UIImageView!
    var snapshotImage:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Snapshot"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if snapshotImage != nil {
            snapshotImageView.image = snapshotImage!
        }
    }

}
