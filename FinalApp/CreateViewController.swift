//
//  CreateViewController.swift
//  FinalApp
//
//  Created by SWUCOMPUTER on 2018. 6. 19..
//  Copyright © 2018년 SWUCOMPUTER. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var textName: UITextField!
    @IBOutlet var textID: UITextField!
    @IBOutlet var textPassword: UITextField!
    @IBOutlet var pickerBirth: UIPickerView!
    @IBOutlet var labelbirthCheck: UILabel!
    @IBOutlet var labelStatus: UILabel!
    
    var yearArray: [String] = Array()
    var monthArray: [String] = Array()
    var dayArray: [String] = Array()
    
    func textFieldShouldReturn (_ textField: UITextField) -> Bool {
        if textField == self.textName {
            textField.resignFirstResponder()
            self.textID.becomeFirstResponder()
        }
        else if textField == self.textID {
            textField.resignFirstResponder()
            self.textPassword.becomeFirstResponder()
        }
        textField.resignFirstResponder()
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 1960...2018 {yearArray.append("\(i)년")}
        for i in 1...12 {monthArray.append("\(i)월")}
        for i in 1...31 {dayArray.append("\(i)일")}
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return yearArray.count
        }
        else if component == 1 {
            return monthArray.count
        }
        else {
            return dayArray.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return yearArray[row]
        }
        else if component == 1{
            return monthArray[row]
        }
        else{
            return dayArray[row]
        }
    }
    func executeRequest (request: URLRequest) -> Void {
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else {
                print("Error: calling POST")
                return
            }
            
            guard let receivedData = responseData else {
                print("Error: not receiving Data")
                return
            }
            
            if let utf8Data = String(data: receivedData, encoding: .utf8) {
                DispatchQueue.main.async {
                    self.labelStatus.text = utf8Data
                    print(utf8Data)
                }
            }
        }
        task.resume()
    }
    @IBAction func check() {
        let year: String = yearArray[self.pickerBirth.selectedRow(inComponent: 0)]
        let month: String = monthArray[self.pickerBirth.selectedRow(inComponent: 1)]
        let day: String = dayArray[self.pickerBirth.selectedRow(inComponent: 2)]
        labelbirthCheck.text = year + ", " + month + ", " + day
    }
    @IBAction func buttonSave() {
        if textName.text == "" {
            labelStatus.text = "이름을 입력하세요"; return;
        }
        if textID.text == "" {
            labelStatus.text = "아이디를 입력하세요"; return;
        }
        if textPassword.text == "" {
            labelStatus.text = "비밀번호를 입력하세요"; return;
        }
        let urlString: String = "http://condi.swu.ac.kr/student/W09iphone/insertUser.php"
        guard let requestURL = URL(string: urlString) else {
            return
        }
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        let restString: String = "id=" + textID.text! + "&password=" + textPassword.text!
            + "&name=" + textName.text!
        request.httpBody = restString.data(using: .utf8)
        self.executeRequest(request: request)
    }
}
