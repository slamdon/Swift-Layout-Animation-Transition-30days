//
//  HomeViewController.swift
//  ExpandableTableView
//
//  Created by don chen on 2017/12/23.
//  Copyright © 2017年 Don Chen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var shops = [ShopModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupData()
    }
    
    private func setupView(){
        tableView.rowHeight = 60
        tableView.sectionHeaderHeight = 30
        tableView.separatorStyle = .none
        
        tableView.register(ProductInfoHeaderView.self, forHeaderFooterViewReuseIdentifier: "customHeaderView")
        tableView.register(ProductInfoCell.self, forCellReuseIdentifier: "customCell")
    }
    
    private func setupData(){
        let shopApple = ShopModel()
        shopApple.name = "Apple"
        shopApple.products.append(ProductModel(name: "iPhone", price: 100))
        shopApple.products.append(ProductModel(name: "Macbook Pro", price: 200))
        shopApple.products.append(ProductModel(name: "iPad", price: 300))
        shopApple.products.append(ProductModel(name: "iWatch", price: 50))
        shopApple.products.append(ProductModel(name: "Apple TV", price: 70))
        
        let shopMicrosoft = ShopModel()
        shopMicrosoft.name = "Microsoft"
        shopMicrosoft.products.append(ProductModel(name: "Window 98", price: 100))
        shopMicrosoft.products.append(ProductModel(name: "Window 2000", price: 500))
        shopMicrosoft.products.append(ProductModel(name: "Window XP", price: 1000))
        shopMicrosoft.products.append(ProductModel(name: "Window 8", price: 200))
        shopMicrosoft.products.append(ProductModel(name: "Window 10", price: 3000))
        shopMicrosoft.products.append(ProductModel(name: "Surface", price: 300))

        
        let shopGoogle = ShopModel()
        shopGoogle.name = "Google"
        shopGoogle.products.append(ProductModel(name: "Pixel 1", price: 100))
        shopGoogle.products.append(ProductModel(name: "Pixel 2", price: 200))
        shopGoogle.products.append(ProductModel(name: "Google Home", price: 300))
        
        let shopAmazon = ShopModel()
        shopAmazon.name = "Amazon"
        shopAmazon.products.append(ProductModel(name: "Kindle Fire", price: 100))
        shopAmazon.products.append(ProductModel(name: "Amazon Fire TV", price: 100))
        shopAmazon.products.append(ProductModel(name: "Echo", price: 30))
        
        shops.append(shopApple)
        shops.append(shopMicrosoft)
        shops.append(shopGoogle)
        shops.append(shopAmazon)
    }
}

// MARK: UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return shops.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shops[section].isExpanded {
            return shops[section].products.count
        } else {
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = shops[indexPath.section].products[indexPath.row]
        let productCell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! ProductInfoCell
        productCell.model = model
        productCell.loadContent()
        return productCell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let model = shops[section]
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "customHeaderView") as! ProductInfoHeaderView
        headerView.tableView = tableView
        headerView.model = model
        headerView.section = section
        headerView.loadContent()
        
        return headerView
    }
    
    
    
}

// MARK: UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

