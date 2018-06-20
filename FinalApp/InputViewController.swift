//
//  InputViewController.swift
//  FinalApp
//
//  Created by SWUCOMPUTER on 2018. 6. 19..
//  Copyright © 2018년 SWUCOMPUTER. All rights reserved.
//

import UIKit

class InputViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var timeText: UITextField!
    @IBOutlet var nowText: UITextField!
    @IBOutlet var positionText: UITextField!
    @IBOutlet var segment: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let name = appDelegate.userName {
            self.title = name + "님 안녕하세요:)"
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func buttonLogout(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginView = storyboard.instantiateViewController(withIdentifier: "LoginView")
        
        let alert = UIAlertController(title:"로그아웃 하시겠습니까?",message: "",preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            let urlString: String = "http://condi.swu.ac.kr/student/W09iphone/logout.php"
            guard let requestURL = URL(string: urlString) else { return }
            var request = URLRequest(url: requestURL)
            request.httpMethod = "POST"
            let session = URLSession.shared
            let task = session.dataTask(with: request) { (responseData, response, responseError) in
                guard responseError == nil else { return }
            }
            task.resume()
            self.present(loginView, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    @IBAction func inputPressed(_ sender: UIButton) {
        if sender.isTouchInside{
            let now = Date()
            let date = DateFormatter()
            date.locale = Locale(identifier: "ko_kr")
            date.timeZone = TimeZone(abbreviation: "KST")
            date.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            let kr = date.string(from: now)
            nowText.text = kr
        }
    }
    @IBAction func switchSeg(_ sender: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0{
            positionText.text = "서울여자대학교 정문"
        }
        else {
            positionText.text = ""
        }
    }
}
