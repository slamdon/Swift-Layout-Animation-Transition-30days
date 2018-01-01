//
//  HomeViewController.swift
//  LineageCollection
//
//  Created by don chen on 2018/1/1.
//  Copyright © 2018年 Don Chen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var filterAllButton: UIButton!
    @IBOutlet weak var filterRedButton: UIButton!
    @IBOutlet weak var filterBlueButton: UIButton!
    @IBOutlet weak var filterGreenButton: UIButton!
    @IBOutlet weak var filterGrayButton: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var cards = [CardModel]()
    var filterdCards = [CardModel]()
    var currentFilterLevel:CardLevel = .all
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Lineage Collection"
        
        let cellNib = UINib(nibName: "CardViewCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "cardCell")
        
        setupCards()
    }
    
    private func setupCards() {
        for i in 1...95 {
            let randomNumber = arc4random_uniform(4)
            var cardLevel:CardLevel = .gray
            switch randomNumber % 4 {
                case 0: cardLevel = .gray
                case 1: cardLevel = .green
                case 2: cardLevel = .blue
                case 3: cardLevel = .red
                default: break
            }
            
            let card = CardModel(level: cardLevel, image: UIImage(named:"monster-\(i)")!)
            cards.append(card)
        }
        
        filterdCards = cards
    }
    

    @IBAction func filterAllClickHandler(_ sender: Any) {
        switchFilterTo(.all)
    }
    
    @IBAction func filterRedClickHandler(_ sender: Any) {
        switchFilterTo(.red)
    }
    
    @IBAction func filterBlueClickHandler(_ sender: Any) {
        switchFilterTo(.blue)
    }
    
    @IBAction func filterGreenClickHandler(_ sender: Any) {
        switchFilterTo(.green)
    }
    
    @IBAction func filterGrayClickHandler(_ sender: Any) {
        switchFilterTo(.gray)
    }
    
    private func switchFilterTo(_ type:CardLevel) {
        filterAllButton.setBackgroundImage(UIImage(named:"btn-black"), for: .normal)
        filterRedButton.setBackgroundImage(UIImage(named:"btn-black"), for: .normal)
        filterBlueButton.setBackgroundImage(UIImage(named:"btn-black"), for: .normal)
        filterGreenButton.setBackgroundImage(UIImage(named:"btn-black"), for: .normal)
        filterGrayButton.setBackgroundImage(UIImage(named:"btn-black"), for: .normal)
        
        filterAllButton.setTitleColor(UIColor.linGray, for: .normal)
        filterRedButton.setTitleColor(UIColor.linGray, for: .normal)
        filterBlueButton.setTitleColor(UIColor.linGray, for: .normal)
        filterGreenButton.setTitleColor(UIColor.linGray, for: .normal)
        filterGrayButton.setTitleColor(UIColor.linGray, for: .normal)
        
        switch type {
            case .all:
                filterAllButton.setBackgroundImage(UIImage(named:"btn-yellow"), for: .normal)
                filterAllButton.setTitleColor(UIColor.linYellow, for: .normal)
                currentFilterLevel = .all
            
            case .gray:
                filterGrayButton.setBackgroundImage(UIImage(named:"btn-gray"), for: .normal)
                filterGrayButton.setTitleColor(UIColor.linWhite, for: .normal)
                currentFilterLevel = .gray
            
            case .green:
                filterGreenButton.setBackgroundImage(UIImage(named:"btn-green"), for: .normal)
                filterGreenButton.setTitleColor(UIColor.linGreen, for: .normal)
                currentFilterLevel = .green
            
            case .blue:
                filterBlueButton.setBackgroundImage(UIImage(named:"btn-blue"), for: .normal)
                filterBlueButton.setTitleColor(UIColor.linBlue, for: .normal)
                currentFilterLevel = .blue
            
            case .red:
                filterRedButton.setBackgroundImage(UIImage(named:"btn-red"), for: .normal)
                filterRedButton.setTitleColor(UIColor.linRed, for: .normal)
                currentFilterLevel = .red
        }
        
        
        if currentFilterLevel == .all {
            filterdCards = cards
        } else {
            filterdCards = cards.filter{ $0.level == self.currentFilterLevel }
        }
        
        collectionView.reloadData()
    }
    
}

// MARK: UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterdCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let card = filterdCards[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! CardViewCell
        cell.model = card
        cell.loadContent()
        
        return cell
        
    }
    
}

// MARK: UICollectionVieDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 75, height: 98)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsetsMake(10, 0, 0, 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
        
    }
    
}


