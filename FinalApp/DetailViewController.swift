//
//  DetailViewController.swift
//  FinalApp
//
//  Created by SWUCOMPUTER on 2018. 6. 19..
//  Copyright © 2018년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    @IBOutlet var mapImageView: UIImageView!
    @IBOutlet var shopNameLabel: UILabel!
    @IBOutlet var phonenbLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var reviewLabel: UILabel!
    
    
    var selectedData: DetailData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let detailData = selectedData else { return }
        shopNameLabel.text = detailData.shopName
        phonenbLabel.text = detailData.phonenb
        addressLabel.text = detailData.address
        timeLabel.text = detailData.time
        reviewLabel.numberOfLines = 0 // multiple lines
        reviewLabel.text = detailData.review
    }
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    @IBAction func mapImageSelected(_ sender: UIButton) {
        if sender.isTouchInside{
            let Image = UIImage(named: "스와레 지도.png")
            self.mapImageView.image = Image
        }
    }
    @IBAction func goToList(_ sender: UIButton) {
    _ = self.navigationController?.popViewController(animated: true)
    }
    @IBAction func buttonDelete() {
        let alert=UIAlertController(title:"정말 삭제 하시겠습니까?", message: "",preferredStyle:.alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .cancel, handler: { action in
            let urlString: String = "http://condi.swu.ac.kr/student/W09iphone/deleteFavorite.php"
            guard let requestURL = URL(string: urlString) else { return }
            var request = URLRequest(url: requestURL)
            request.httpMethod = "POST"
            guard let categoRY = self.selectedData?.category else { return }
            let restString: String = "category=" + categoRY
            request.httpBody = restString.data(using: .utf8)
            let session = URLSession.shared
            let task = session.dataTask(with: request) { (responseData, response, responseError) in
                guard responseError == nil else { return }
                guard let receivedData = responseData else { return }
                if let utf8Data = String(data: receivedData, encoding: .utf8) { print(utf8Data) }
            }
            task.resume()
            self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
