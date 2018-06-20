//
//  SelfAddViewController.swift
//  FinalApp
//
//  Created by SWUCOMPUTER on 2018. 6. 20..
//  Copyright © 2018년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class SelfAddViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var categoryPickerTwo: UIPickerView!
    
    @IBOutlet var categoryTextFieldTwo: UITextField!
    @IBOutlet var shopnameTextFieldTwo: UITextField!
    @IBOutlet var addressTextFiedTwo: UITextField!
    @IBOutlet var PhoneTextFieldTwo: UITextField!
    @IBOutlet var timeTexFieldTwo: UITextField!
    @IBOutlet var reviewTextViewTwo: UITextView!
    
    var categoryArrayTwo: [String] = ["FOOD", "HEALTHY", "PLAY", "SHOPPING"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        categoryTextFieldTwo.isHidden = true
    }
    func textFieldShouldReturn (_ textField: UITextField) -> Bool {
        if textField == self.shopnameTextFieldTwo {
            textField.resignFirstResponder()
            self.addressTextFiedTwo.becomeFirstResponder()
        }
        else if textField == self.addressTextFiedTwo {
            textField.resignFirstResponder()
            self.PhoneTextFieldTwo.becomeFirstResponder()
        }
        else if textField == self.PhoneTextFieldTwo {
            timeTexFieldTwo.resignFirstResponder()
            self.reviewTextViewTwo.becomeFirstResponder()
        }
        textField.resignFirstResponder()
        return true
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryArrayTwo.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryArrayTwo[row]
    }
    @IBAction func getValue() {
        let cate: String = categoryArrayTwo[self.categoryPickerTwo.selectedRow(inComponent: 0)]
        categoryTextFieldTwo.text = cate
    }
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        let category = categoryTextFieldTwo.text!
        let shopName = shopnameTextFieldTwo.text!
        let address = addressTextFiedTwo.text!
        let phonenb = PhoneTextFieldTwo.text!
        let time = timeTexFieldTwo.text!
        let review = reviewTextViewTwo.text!
        
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
