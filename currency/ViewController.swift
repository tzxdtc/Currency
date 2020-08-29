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
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyCollectionView.delegate = self
        currencyCollectionView.dataSource = self
        currencyCollectionView.register(UINib(nibName: "CurrencyCell", bundle: nil), forCellWithReuseIdentifier: "CurrencyCell")
//        EasyRequest<CurrencyInfo>.get(self, url: "http://apilayer.net/api/live?access_key=a9cafb950f5142c3b84aa9473626dc2c") { (results) in
//
//            DispatchQueue.main.async() {
//            }
//        }
        
        // call every 30 mins
        timer = Timer.scheduledTimer(timeInterval: 1800, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer?.invalidate()
    }


    @IBAction func click(_ sender: Any) {
        
        let dropDown = DropDown()
        dropDown.dataSource = ["Car", "Motorcycle", "Truck"]
        dropDown.show()
    }
    
    @objc func runTimedCode(){
        print("hello world")
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

extension ViewController: EasyRequestDelegate {

    func onError() {
        DispatchQueue.main.async() {
            let alert = UIAlertController(title: "Ups", message: "An error has occurred...", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }

}
