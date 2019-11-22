//
//  CustomDetail.swift
//  NearbyAirports
//
//  Created by Jeelakarra Shyam on 22/11/19.
//  Copyright © 2019 Shyam. All rights reserved.
//

import UIKit
import MapKit

class CustomDetail: MKAnnotationView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var numberOFLoc: UIPageControl!
    @IBOutlet weak var collectionV: UICollectionView!
    
    var locationsArray : Array<Results>!
    
    func loadLocations(locationsArray: Array<Results>) {
        if locationsArray.count > 1 {
            numberOFLoc.isHidden = false
            numberOFLoc.numberOfPages = locationsArray.count
        } else {
            numberOFLoc.isHidden = true
        }
        
        self.locationsArray = locationsArray
        
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.register(UINib.init(nibName: "CustomDetailCell", bundle: nil), forCellWithReuseIdentifier: "CustomDetailCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locationsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomDetailCell", for: indexPath) as! CustomDetailCell
        cell.configure(with: locationsArray[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionV.frame.width, height: collectionV.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.numberOFLoc.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
}
