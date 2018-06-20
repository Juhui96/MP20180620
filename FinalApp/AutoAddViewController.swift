//
//  AutoAddViewController.swift
//  FinalApp
//
//  Created by SWUCOMPUTER on 2018. 6. 19..
//  Copyright © 2018년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class AutoAddViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate, UIPickerViewDataSource {
    
     @IBOutlet var categoryPicker: UIPickerView!
    
     @IBOutlet var categoryTextField: UITextField!
     @IBOutlet var shopnameTextField: UITextField!
     @IBOutlet var addressTextFied: UITextField!
     @IBOutlet var PhoneTextField: UITextField!
     @IBOutlet var timeTexField: UITextField!
     @IBOutlet var reviewTextView: UITextView!
    
    var categoryArray: [String] = ["FOOD", "HEALTHY", "PLAY", "SHOPPING"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        shopnameTextField.text = "스와레"
        addressTextFied.text = "서울 노원구 화랑로51길 20"
        categoryTextField.text = "FOOD"
        PhoneTextField.text = "02-928-4011"
        timeTexField.text = "매일 12:00 - 23:00Break time 15:00~18:00"
        
        categoryTextField.isHidden = true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryArray[row]
    }
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        let category = categoryTextField.text!
        let shopName = shopnameTextField.text!
        let address = addressTextFied.text!
        let phonenb = PhoneTextField.text!
        let time = timeTexField.text!
        let review = reviewTextView.text!
        
        let myUrl = URL(string: "http://condi.swu.ac.kr/student/W09iphone/upload.php");
        var request = URLRequest(url:myUrl!);
        request.httpMethod = "POST";
        
        let urlString: String = "http://condi.swu.ac.kr/student/W09iphone/insertFavorite.php"
        guard let requestURL = URL(string: urlString) else { return }
        request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        guard let userID = appDelegate.ID else { return }
        var restString: String = "id=" + userID
        restString += "&category=" + category
        restString += "&shopName=" + shopName
        restString += "&address=" + address
        restString += "&phonenb=" + phonenb
        restString += "&time=" + time
        restString += "&review=" + review
        request.httpBody = restString.data(using: .utf8)
        let session2 = URLSession.shared
        let task2 = session2.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else { return }
            guard let receivedData = responseData else { return }
            if let utf8Data = String(data: receivedData, encoding: .utf8) { print(utf8Data) }
        }
        task2.resume()
        _ = self.navigationController?.popViewController(animated: true)
    }
}
