//
//  AlbumViewController.swift
//  FinalApp
//
//  Created by SWUCOMPUTER on 2018. 6. 19..
//  Copyright © 2018년 SWUCOMPUTER. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController,UICollectionViewDelegate ,UICollectionViewDataSource  {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let Cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AlbumCollectionViewCell
        
        let ImageName = Data[indexPath.row]["TitleImage"]
        let Image = UIImage(named: ImageName!)
        
        Cell.TitleImage.image = Image
        Cell.TitleLabel.text = Data[indexPath.row]["TitleLabel"]
        
        return Cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toAutoAddView", sender: self)
    }
}
