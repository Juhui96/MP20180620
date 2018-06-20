//
//  AutoUploadViewController.swift
//  FinalApp
//
//  Created by SWUCOMPUTER on 2018. 6. 20..
//  Copyright © 2018년 SWUCOMPUTER. All rights reserved.
//

import UIKit

class AutoUploadViewController: UIViewController,UINavigationControllerDelegate {
    
    @IBOutlet var menuImageView: UIImageView!
    @IBOutlet var commentTextField: UITextField!
    @IBOutlet var commentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func menuImageSelected(_ sender: UIButton) {
        if sender.isTouchInside{
            let Image = UIImage(named: "스와레 메뉴.png")
            self.menuImageView.image = Image
        }
    }
    @IBAction func savePressed(_ sender: UIButton) {
        let comment = commentTextField.text!
        
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
        restString += "&comment=" + comment
        request.httpBody = restString.data(using: .utf8)
        let session2 = URLSession.shared
        let task2 = session2.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else { return }
            guard let receivedData = responseData else { return }
            if let utf8Data = String(data: receivedData, encoding: .utf8) { print(utf8Data) }
        }
        task2.resume()
    }
}

