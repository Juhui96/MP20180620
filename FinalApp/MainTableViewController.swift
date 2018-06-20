//
//  MainTableViewController.swift
//  FinalApp
//
//  Created by SWUCOMPUTER on 2018. 6. 19..
//  Copyright © 2018년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class MainTableViewController: UITableViewController {
    
    var sortDescriptors: [NSSortDescriptor]?
    var fetchedArray: [DetailData] = Array()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let alert = UIAlertController(title: "**알림**", message: "20대의 추천목록입니다!",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchedArray = []
        self.downloadDataFromServer()
    }
    func downloadDataFromServer() -> Void {
        let urlString: String = "http://condi.swu.ac.kr/student/W09iphone/favoriteTable.php"
        guard let requestURL = URL(string: urlString) else { return }
        let request = URLRequest(url: requestURL)
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (responseData, response, responseError)
            in guard responseError == nil else { print("Error: calling POST"); return; }
            guard let receivedData = responseData else {
                print("Error: not receiving Data"); return;
            }
            let response = response as! HTTPURLResponse
            if !(200...299 ~= response.statusCode) { print("HTTP response Error!"); return }
            do {
                if let jsonData = try JSONSerialization.jsonObject (with: receivedData,
                                                                    options:.allowFragments) as? [[String: Any]] {
                    for i in 0...jsonData.count-1 {
                        let newData: DetailData = DetailData()
                        var jsonElement = jsonData[i]
                        newData.category = jsonElement["category"] as! String
                        newData.shopName = jsonElement["shopName"] as! String
                        newData.address = jsonElement["address"] as! String
                        newData.phonenb = jsonElement["phonenb"] as! String
                        newData.time = jsonElement["time"] as! String
                        newData.review = jsonElement["review"] as! String
                        newData.comment = jsonElement["comment"] as! String
                        self.fetchedArray.append(newData)
                    }
                    DispatchQueue.main.async { self.tableView.reloadData() }
                }
            } catch { print("Error:") }
        }
        task.resume()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fetchedArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "List Cell", for: indexPath)
        
        let item = fetchedArray[indexPath.row]
       
        cell.textLabel?.text = "[" + item.category + "]" + item.shopName
        cell.detailTextLabel?.text = item.address // ----> Right Detail 설정
        return cell
    
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }


    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailView" {
            if let destination = segue.destination as? DetailViewController {
                if let selectedIndex = self.tableView.indexPathsForSelectedRows?.first?.row {
                    let data = fetchedArray[selectedIndex]
                    destination.selectedData = data
                }
            }
        }
    }
}
