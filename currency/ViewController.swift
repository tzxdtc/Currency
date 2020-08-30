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
    @IBOutlet weak var inputNumber: UITextField!
    @IBOutlet weak var currencySelectBtn: UIButton!
    
    var timer: Timer?
    var currencyDetail: CurrencyDetailModel?
    var currencyKeys: [String]?
    var currencyValues: [Any]?
    var currencyDict: [String:Any]?
    var inputNumberMoney: String?
    var selectedCurrency = "USDUSD"
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyCollectionView.delegate = self
        currencyCollectionView.dataSource = self
        currencyCollectionView.register(UINib(nibName: "CurrencyCell", bundle: nil), forCellWithReuseIdentifier: "CurrencyCell")
        
        inputNumber.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), for: .editingChanged)
        // call every 30 mins
//        timer = Timer.scheduledTimer(timeInterval: 1800, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        
        EasyRequest<CurrencyInfo>.get(self, url: "http://apilayer.net/api/live?access_key=a9cafb950f5142c3b84aa9473626dc2c") { (results) in
            self.currencyDetail = results.quotes
            if let dict = self.currencyDetail?.asDictionary{
                self.currencyDict = dict
                self.currencyKeys = Array(dict.keys)
                self.currencyValues = Array(dict.values)
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer?.invalidate()
    }


    @IBAction func click(_ sender: Any) {
        let dropDown = DropDown()
        if let currencyKeys = self.currencyKeys{
            dropDown.dataSource = currencyKeys
        }
        dropDown.anchorView = currencyCollectionView
        dropDown.selectionAction = {index, title in
            self.inputNumber.text = "0"
            self.currencySelectBtn.setTitle(title, for: .normal)
            self.selectedCurrency = title
            print("index \(index) title \(title)")
            if let dict = self.currencyDetail?.asDictionary{
                print("value \(dict["\(title)"] ?? "")")
            }
        }
        dropDown.show()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let myString = textField.text{
            self.inputNumberMoney = myString
            self.currencyCollectionView.reloadData()
        }
        
    }
    
    @objc func runTimedCode(){
        EasyRequest<CurrencyInfo>.get(self, url: "http://apilayer.net/api/live?access_key=a9cafb950f5142c3b84aa9473626dc2c") { (results) in

            let encoder = JSONEncoder()
            let defaults = UserDefaults.standard
            if let encoded = try? encoder.encode(results) {
                defaults.set(encoded, forKey: "currencyInfo")
            }
            
            if let currencyInfo = defaults.object(forKey: "currencyInfo") as? Data {
                let decoder = JSONDecoder()
                if let loadedCurrencyInfo = try? decoder.decode(CurrencyInfo.self, from: currencyInfo) {
                    self.currencyDetail = loadedCurrencyInfo.quotes
                     if let dict = self.currencyDetail?.asDictionary{
                         self.currencyKeys = Array(dict.keys)
                         self.currencyValues = Array(dict.values)
                     }
                }
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.currencyDetail?.asDictionary.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrencyCell", for: indexPath) as! CurrencyCell
        if let currencyKeys = self.currencyKeys{
            cell.currencyName.text = currencyKeys[indexPath.row]
        }
        if let currencyValues = self.currencyValues as? [Float],let inputMoney = self.inputNumberMoney,let currencyDict = self.currencyDict,let currencyValue = currencyDict["\(String(describing: self.selectedCurrency))"] as? Float{
            cell.currencyConvert.text = String(describing: (inputMoney as NSString).floatValue / currencyValue * currencyValues[indexPath.row])
        }else{
            cell.currencyConvert.text = "0"
        }
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
