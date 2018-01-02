//
//  HomeViewController.swift
//  CardLayout
//
//  Created by don chen on 2018/1/2.
//  Copyright © 2018年 Don Chen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let imageNames = ["img-1", "img-2", "img-3", "img-4", "img-5", "img-6"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Card Layout"
        
        setupView()
    }
    
    fileprivate func setupView() {
        view.backgroundColor = UIColor(red: 208/255, green: 233/255, blue: 230/255, alpha: 1.0)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.collectionViewLayout = CardCollectionViewLayout()
        
        let cellNib = UINib(nibName: "CardCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "cardCell")

    }
}

// MARK: UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! CardCell
        cell.imageName = imageNames[indexPath.row]
        cell.loadContent()
        return cell
    }
    
}

// MARK: UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
