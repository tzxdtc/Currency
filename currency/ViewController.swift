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
    @IBOutlet weak var inputNumberTextField: UITextField!
    @IBOutlet weak var currencySelectBtn: UIButton!
    
    var timer: Timer?
    var currencyDetail: CurrencyDetailModel?
    var currencyKeys: [String]?
    var currencyValues: [Any]?
    var currencyDict: [String:Any]?
    var inputNumberMoney: String?
    var selectedCurrency = Constants.usd
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyCollectionView.delegate = self
        currencyCollectionView.dataSource = self
        currencyCollectionView.register(UINib(nibName: Constants.Cell.cellNibName, bundle: nil), forCellWithReuseIdentifier: Constants.Cell.cellIdentifier)
        
        //observe inputNumberTextField change
        inputNumberTextField.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), for: .editingChanged)
        
        fetchData()
        
        // call every 30 mins
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(Constants.timer), target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)

        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        //stop timer when view disappear
        timer?.invalidate()
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }


    @IBAction func click(_ sender: Any) {
        let dropDown = DropDown()
        if let currencyKeys = self.currencyKeys{
            dropDown.dataSource = currencyKeys
        }
        dropDown.anchorView = currencyCollectionView
        dropDown.selectionAction = {index, title in
            self.currencySelectBtn.setTitle(title, for: .normal)
            self.selectedCurrency = title
            self.currencyCollectionView.reloadData()
        }
        dropDown.show()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let myString = textField.text{
            self.inputNumberMoney = myString
            self.currencyCollectionView.reloadData()
        }
        
    }
    
    func fetchData(){
        EasyRequest<CurrencyInfo>.get(self, url: "\(Constants.API.url)?access_key=\(Constants.API.accessKey)") { (results) in
            self.currencyDetail = results.quotes
            if let dict = self.currencyDetail?.asDictionary{
                self.currencyDict = dict
                // get rid of USD
                self.currencyKeys = Array(dict.keys).map{
                    String($0.dropFirst(3))
                }
                self.currencyValues = Array(dict.values)
            }
        }
        self.currencyCollectionView.reloadData()
    }
    
    @objc func runTimedCode(){
        fetchData()
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.currencyDetail?.asDictionary.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Cell.cellIdentifier, for: indexPath) as! CurrencyCell
        if let currencyKeys = self.currencyKeys{
            cell.currencyName.text = currencyKeys[indexPath.row]
        }
        if let currencyValues = self.currencyValues as? [Float],let inputMoney = self.inputNumberMoney,let currencyDict = self.currencyDict,let currencyValue = currencyDict["\(String(describing: Constants.usd + self.selectedCurrency))"] as? Float{
            cell.currencyConvert.text = String(describing: (inputMoney as NSString).floatValue / currencyValue * currencyValues[indexPath.row])
        }else{
            cell.currencyConvert.text = "0"
        }
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let horizontalSpace : CGFloat = CGFloat(Constants.Cell.space)
        let cellSize : CGFloat = self.view.bounds.width / 3 - horizontalSpace
        return CGSize(width: cellSize, height: cellSize)
    }
}

extension ViewController: EasyRequestDelegate {
    func onError() {
        DispatchQueue.main.async() {
            let alert = UIAlertController(title: Constants.ErrorMessage.title, message: Constants.ErrorMessage.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: Constants.ErrorMessage.actionTitle, style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
}
