//
//  HomeViewController.swift
//  3DCardLayout
//
//  Created by don chen on 2018/1/6.
//  Copyright © 2018年 Don Chen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    var photos = [CardModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "3D Card Layout"
        
        setupView()
    }
    
    fileprivate func setupView() {
        view.backgroundColor = UIColor(red: 213/255, green: 235/255, blue: 221/255, alpha: 1)
        
        let cellNib = UINib(nibName: "CardCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "cardCell")
        collectionView.collectionViewLayout = Card3DFlowLayout()
        collectionView.dataSource = self
        
        photos.append(CardModel(name: "Joseph Yates", image: UIImage(named:"Joseph-Yates")!))
        photos.append(CardModel(name: "Michael Baird", image: UIImage(named:"Michael-Baird")!))
        photos.append(CardModel(name: "Antoine Beauvillain", image: UIImage(named:"Antoine-Beauvillain")!))
        photos.append(CardModel(name: "Owen Walters", image: UIImage(named:"Owen-Walters")!))
        photos.append(CardModel(name: "Frank Mckenna", image: UIImage(named:"Frank-Mckenna")!))
    }
    
    
}

// MARK: UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photo = photos[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! CardCell
        cell.data = photo
        cell.loadContent()
        return cell
        
    }
    
}
