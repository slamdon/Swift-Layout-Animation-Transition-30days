//
//  HomeViewController.swift
//  ImageFilter
//
//  Created by don chen on 2017/12/28.
//  Copyright © 2017年 Don Chen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
   
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var filterTitleList = ["Normal"]
    var filterNameList = ["Normal"]
    var filteredSmallImages = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Image Filter"

        setupView()
        
        print(CIFilter.filterNames(inCategory: kCICategoryBuiltIn).count)
        for filterName in CIFilter.filterNames(inCategory: kCICategoryBuiltIn) {
            let filter = CIFilter(name: filterName)
            print("\(filterName) - \(filter?.attributes)")
        }
    }
    
    private func setupView() {
        // set filter title list array.
        filterTitleList = ["Normal" ,"PhotoEffectChrome", "PhotoEffectFade", "PhotoEffectInstant", "PhotoEffectMono", "PhotoEffectNoir", "PhotoEffectProcess", "PhotoEffectTonal", "PhotoEffectTransfer"]

        // set filter name list array.
        filterNameList = ["Normal" ,"CIPhotoEffectChrome", "CIPhotoEffectFade", "CIPhotoEffectInstant", "CIPhotoEffectMono", "CIPhotoEffectNoir", "CIPhotoEffectProcess", "CIPhotoEffectTonal", "CIPhotoEffectTransfer"]
        
        for filterName in CIFilter.filterNames(inCategory: kCICategoryBuiltIn) {
//            filterNameList.append(filterName)
//            var filterTitle = filterName
            // remove 'CI'
//            filterTitle.removeFirst()
//            filterTitle.removeFirst()
//            filterTitleList.append(filterName)
        }
        
        
        let cellNib = UINib(nibName: "ImageCardCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "imageCell")
        
        filteredSmallImages.append(UIImage(named: "img-beach2-s")!)
        for i in 1..<filterNameList.count {
            if let image = renderImage(image: UIImage(named:"img-beach2-s")!, filterName: filterNameList[i]) {
                filteredSmallImages.append(image)
            }
        }
        
    }
    
    fileprivate func renderImage(image:UIImage, filterName:String) -> UIImage? {
        // 1 - copy cgImage from image
        let sourceImage = CIImage(cgImage: image.cgImage!)
        
        // 2 - init filter
        let filter = CIFilter(name: filterName)
        filter?.setDefaults()
        filter?.setValue(sourceImage, forKey: kCIInputImageKey)
        
        if filter == nil { return nil}
        
        // 3 - init context
        let context = CIContext(options: nil)
        
        // 4 - output filtered image
        if(filter!.outputImage != nil){
            let outputCGImage = context.createCGImage(filter!.outputImage!, from: filter!.outputImage!.extent)
            if  outputCGImage != nil {
                return UIImage(cgImage: outputCGImage!)
            }
        }
        
        return nil

    }

}

// MARK: UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterNameList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = indexPath.row
        let cardModel = ImageCardModel(title: filterTitleList[row], image: filteredSmallImages[row])
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCardCell
        cell.data = cardModel
        cell.loadContent()
        return cell

    }
    
}

// MARK: UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = indexPath.row
        if row == 0 {
            imageView.image = UIImage(named:"img-beach2")!
            
        } else if let image = renderImage(image: UIImage(named:"img-beach2")!, filterName: filterNameList[row]) {
            imageView.image = image
            
        }
    }
}

// MARK: UICollectionVieDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 150, height: 120)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsetsMake(10, 10, 10, 10)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
        
    }
    
}


