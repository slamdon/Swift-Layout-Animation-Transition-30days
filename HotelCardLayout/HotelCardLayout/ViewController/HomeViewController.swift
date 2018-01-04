//
//  HomeViewController.swift
//  HotelCardLayout
//
//  Created by don chen on 2018/1/3.
//  Copyright © 2018年 Don Chen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var hotels = [HotelModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Hotel Card Layout"
        
        setupData()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(red: 247/255, green: 243/255, blue: 233/255, alpha: 1.0)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = HotelCardCollectionViewFlowLayout()
        
        let cellNib = UINib(nibName: "HotelCardCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "cardCell")
    }
    
    private func setupData() {
        let colors = ["00204A", "005792", "00BBF0", "3F3F3F",
                      "3C67C0", "8594E4", "6643B5", "430F58",
                      "4ABDAC", "C5F0A4", "35B0AB", "226B80",
                      "EE87C0", "D971AE", "9D56B9", "903FB1",
                      "00204A", "005792", "00BBF0", "3F3F3F",
                      "3C67C0", "8594E4", "6643B5", "430F58",
                      "4ABDAC", "C5F0A4", "35B0AB", "226B80",
                      "EE87C0", "D971AE", "9D56B9", "903FB1"]
        
        let names = ["Burj al Arab", "Amansura", "Las Ventanas al Paraiso", "Amangani",
                     "Mandarin Oriental", "Langham Hotel", "Soho House Berlin", "Hotel Amigo",
                     "Four Seasons Resort", "Wentworth Mansion", "Four Seasons Gresham", "Hotel de Crillon",
                     "Ritz-Carlton Shanghai", "Peninsula Hotel", "Amandari", "Amansara, Siem Reap",
                     "Burj al Arab", "Amansura", "Las Ventanas al Paraiso", "Amangani",
                     "Mandarin Oriental", "Langham Hotel", "Soho House Berlin", "Hotel Amigo",
                     "Four Seasons Resort", "Wentworth Mansion", "Four Seasons Gresham", "Hotel de Crillon",
                     "Ritz-Carlton Shanghai", "Peninsula Hotel", "Amandari", "Amansara, Siem Reap"]
        
        for i in 0..<colors.count {
            let price = Float(arc4random() % 500)
            let hotel = HotelModel(color: UIColor().HexToColor(hexString: colors[i]), name: names[i], price: price)
            hotels.append(hotel)
        }
        
    }


}

// MARK: UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hotels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! HotelCardCell
        cell.data = hotels[indexPath.row]
        cell.loadContent()
        
        return cell
    }
    
}

// MARK: UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

