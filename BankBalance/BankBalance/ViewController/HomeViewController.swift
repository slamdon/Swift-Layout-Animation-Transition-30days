//
//  HomeViewController.swift
//  LabelNumbersAnimation
//
//  Created by don chen on 2017/3/9.
//  Copyright © 2017年 Don Chen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var aTableView: UITableView!
    @IBOutlet var currentMoneyLabel: SKAnimationLabel!
    
    let prices:[Float] = [6.0, 64.0 , 128.0, 256.0, 512.0, 1024.0, 2048.0]
    var currentMoney:Float = 0.0
    
    var mainCell:HomeMainCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Balance"
        
        setupView()
    }
    
    fileprivate func setupView() {
        let mainNib = UINib(nibName: "HomeMainCell", bundle: nil)
        aTableView.register(mainNib, forCellReuseIdentifier: "mainCell")
        
        let buyNib = UINib(nibName: "HomeBuyCell", bundle: nil)
        aTableView.register(buyNib, forCellReuseIdentifier: "buyCell")
        
        let clearNib = UINib(nibName: "HomeClearCell", bundle: nil)
        aTableView.register(clearNib, forCellReuseIdentifier: "clearCell")
        
        let footerNib = UINib(nibName: "HomeFooterCell", bundle: nil)
        aTableView.register(footerNib, forCellReuseIdentifier: "footerCell")
        
//         remove extra cell seprator
        aTableView.tableFooterView = UIView()
    }
    
}

// MARK: UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
            
        } else if section == 1{
            // section - buy cell
            return prices.count
            
        } else {
            // section - clear cell / footer cell
            return 2
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 0 {
            mainCell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as? HomeMainCell
            mainCell?.aLabel.text = "$ \(currentMoney)"
            mainCell!.selectionStyle = .none
            return mainCell!
            
        } else if section == 1{
            let aCell = tableView.dequeueReusableCell(withIdentifier: "buyCell", for: indexPath) as! HomeBuyCell
            aCell.delegate = self
            aCell.cellIndexPath = indexPath
            if row <= prices.count {
                aCell.setupCell(price: prices[row])
            }
            aCell.selectionStyle = .none
            return aCell
            
        } else {
            if row == 0 {
                let aCell = tableView.dequeueReusableCell(withIdentifier: "clearCell", for: indexPath) as! HomeClearCell
                aCell.delegate = self
                aCell.selectionStyle = .none
                return aCell
            } else {
                let aCell = tableView.dequeueReusableCell(withIdentifier: "footerCell", for: indexPath) as! HomeFooterCell
                return aCell
            }

        }
    }
    
    
}

// MARK: UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 140
        } else {
            return 50
        }
        
    }
    
}

// MARK: Cell Delegates
extension HomeViewController: HomeBuyCellDelegate, HomeClearCellDelegate {
    
    // HomeBuyCellDelegate
    func didTapBuy(at: IndexPath) {
        if at.row <= prices.count {
            currentMoney += prices[at.row]
            mainCell?.aLabel.countFromCurrent(to: currentMoney, duration: 1)
        }

    }
    // HomeClearCellDelegate
    func didTapClear() {
        currentMoney = 0
        mainCell?.aLabel.countFromCurrent(to: 0, duration: 1)
    }
}
