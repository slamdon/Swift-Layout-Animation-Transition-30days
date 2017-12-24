//
//  ProductInfoHeaderView.swift
//  ExpandableTableView
//
//  Created by don chen on 2017/12/23.
//  Copyright © 2017年 Don Chen. All rights reserved.
//

import UIKit

class ProductInfoHeaderView: UITableViewHeaderFooterView {
    
    fileprivate var highlightLabel: UILabel!
    fileprivate var normalLabel: UILabel!
    fileprivate var arrowView : ArrowView!
    
    weak var tableView  : UITableView?
    var model: ShopModel?
    var section:Int?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        let screen = UIScreen.main.bounds
        
        let contentView = UIView.CreateLine(CGRect(x: 0, y: 2, width: screen.width, height: 26), lineColor: UIColor.gray.alpha(0.05))
        self.addSubview(contentView)
        contentView.addSubview(UIView.CreateLine(CGRect(x: 0, y: 0, width: screen.width, height: 0.5), lineColor: UIColor.gray.alpha(0.25)))
        contentView.addSubview(UIView.CreateLine(CGRect(x: 0, y: 25.5, width: screen.width, height: 0.5), lineColor: UIColor.gray.alpha(0.25)))
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: screen.width, height: 30))
        button.addTarget(self, action: #selector(ProductInfoHeaderView.buttonEvent), for: .touchUpInside)
        self.addSubview(button)
        
        normalLabel      = UILabel(frame: CGRect(x: 10, y: 0, width: 100, height: 26))
        contentView.addSubview(normalLabel)
        
        highlightLabel           = UILabel(frame: normalLabel.frame)
        highlightLabel.textColor = UIColor.red
        contentView.addSubview(highlightLabel)
        
        arrowView = ArrowView(frame: CGRect(x: screen.width - 25, y: 5, width: 20, height: 20))
        self.addSubview(arrowView)
        
        let arrowImageView    = UIImageView(frame: CGRect(x: 0, y: 0, width: 20 / 3.0, height: 36 / 3.0))
        arrowImageView.image  = UIImage(named: "icon-arrow-right")
        arrowImageView.center = arrowView.middlePoint
        arrowView.addSubview(arrowImageView)
    }
    
    func loadContent() {
        if(model == nil){
            return
        }
        
        normalLabel.text = model!.name
        highlightLabel.text = model!.name
        
        if(model!.isExpanded){
            extendStateAnimated(false)
        } else {
            normalStateAnimated(false)
        }
    }
    
    @objc func buttonEvent() {
        if(model == nil || section == nil){
            print("model or section is nil when tap header")
            return
        }

        if model!.isExpanded == true {
            model!.isExpanded = false
            normalStateAnimated(true)

            var indexPaths = [IndexPath]()
            let index      = model!.products.count
            for i in 0 ..< index {

                indexPaths.append(IndexPath(item: i, section: section!))
            }
            tableView?.deleteRows(at: indexPaths, with: .automatic)

        } else {
            model!.isExpanded = true
            extendStateAnimated(true)

            var indexPaths = [IndexPath]()
            let index      = model!.products.count
            for i in 0 ..< index {
                indexPaths.append(IndexPath(item: i, section: section!))
            }
            tableView?.insertRows(at: indexPaths, with: .automatic)
        }
    }
    
    func normalStateAnimated(_ animated : Bool) {
        
        UIView.animate(withDuration: animated == true ? 0.5 : 0, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
            
            self.normalLabel.alpha = 1;
            self.normalLabel.frame = CGRect(x: 10, y: 0, width: 100, height: 26);
            self.highlightLabel.alpha   = 0;
            self.highlightLabel.frame   = CGRect(x: 10, y: 0, width: 100, height: 26);
            
        }, completion: nil)
        
        arrowView.changeToUpAnimated(animated)
    }
    
    func extendStateAnimated(_ animated : Bool) {
        
        UIView.animate(withDuration: animated == true ? 0.5 : 0, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
            
            self.normalLabel.alpha = 0;
            self.normalLabel.frame = CGRect(x: 10 + 10, y: 0, width: 100, height: 26);
            self.highlightLabel.alpha   = 1;
            self.highlightLabel.frame   = CGRect(x: 10 + 10, y: 0, width: 100, height: 26);
            
        }, completion: nil)
        
        arrowView.changeToRightAnimated(animated)
    }
}
