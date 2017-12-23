//
//  HomeViewController.swift
//  ExpandableButtons
//
//  Created by don chen on 2017/12/21.
//  Copyright © 2017年 Don Chen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Expandable Buttons"
        setupView()
    }
    
    private func setupView() {
        let screenSize = UIScreen.main.bounds
        let menu = SKExpandableView(frame: CGRect(x: screenSize.width - 50, y: screenSize.height - 400, width: 44, height: 220))
        menu.delegate = self
        view.addSubview(menu)
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
        switch button {
            case .card: showMessage("did tap card")
            case .camera: showMessage("did tap camera")
            case .box: showMessage("did tap box")
            case .book: showMessage("did tap book")
        }
    }
}
