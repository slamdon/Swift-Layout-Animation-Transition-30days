//
//  HomeViewController.swift
//  ExpandableButtons
//
//  Created by don chen on 2017/12/21.
//  Copyright © 2017年 Don Chen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var toggleStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = ""
    }
    
    
    @IBAction func toggle1ClickHandler(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            self.imageView1.isHidden = !self.imageView1.isHidden
        })
    }
    
    @IBAction func toggle2ClickHandler(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            self.imageView2.isHidden = !self.imageView2.isHidden
        })
    }
    
    @IBAction func toggle3ClickHandler(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            self.imageView3.isHidden = !self.imageView3.isHidden
        })
    }
    
    private func showMessage(_ message:String) {
        let alertController = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}

extension HomeViewController: SKExpandableViewDelegate {
    func didTapExpandable(button:SKExpandableButtonType) {
        print("did tap")
        switch button {
            case .card: showMessage("did tap card")
            case .camera: showMessage("did tap camera")
            case .box: showMessage("did tap box")
            case .book: showMessage("did tap book")
        }
    }
}
