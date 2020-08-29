//
//  ViewController.swift
//  currency
//
//  Created by 小牛 on 2020/08/29.
//  Copyright © 2020 小牛. All rights reserved.
//

import UIKit
import DropDown

class ViewController: UIViewController {
    @IBOutlet var currencyCollectionView: UICollectionView!
    override func viewDidLoad() {
        currencyCollectionView.delegate = self
        currencyCollectionView.dataSource = self
        currencyCollectionView.register(UINib(nibName: "CurrencyCell", bundle: nil), forCellWithReuseIdentifier: "CurrencyCell")
        super.viewDidLoad()
    }


    @IBAction func click(_ sender: Any) {
        
        let dropDown = DropDown()
        dropDown.dataSource = ["Car", "Motorcycle", "Truck"]
        dropDown.show()
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrencyCell", for: indexPath) as! CurrencyCell
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let horizontalSpace : CGFloat = 10
        let cellSize : CGFloat = self.view.bounds.width / 3 - horizontalSpace
        return CGSize(width: cellSize, height: cellSize)
    }
}
