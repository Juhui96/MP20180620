//
//  CameraViewController.swift
//  FinalApp
//
//  Created by SWUCOMPUTER on 2018. 6. 19..
//  Copyright © 2018년 SWUCOMPUTER. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController {
    
    @IBOutlet var buttonCamera: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if !(UIImagePickerController.isSourceTypeAvailable(.camera)) {
            let alert = UIAlertController(title: "Error!!", message: "카메라가 없습니다",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            buttonCamera.isEnabled = false
        }
    }

}
