//
//  myTableView.swift
//  BJ_HouseOwner
//
//  Created by Project X on 2/22/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import Foundation
import UIKit

class myTableView: UITableViewController{
//    let model : [[UIColor]] = [[UIColor.red],[UIColor.red]]
    
    
    override func viewDidLoad() {
        navigationItem.hidesBackButton = true
    }
    
    let model : [[UIColor]] = [
           [UIColor.red,UIColor.blue,UIColor.green,UIColor.red,UIColor.blue,UIColor.green,UIColor.red,UIColor.blue,UIColor.green],

           [UIColor.blue,UIColor.yellow,UIColor.green,UIColor.red,UIColor.blue,UIColor.green,UIColor.brown,UIColor.blue,UIColor.green],
           [UIColor.white,UIColor.blue,UIColor.green,UIColor.red,UIColor.white,UIColor.green,UIColor.red,UIColor.blue,UIColor.green]]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        
        return tableCell
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? myTableViewCell else {
            return // casting did not succeed
        }
        
        tableViewCell.setCollectionViewSourceAndDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }
}

extension myTableView: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return model[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
        cell.backgroundColor = model[collectionView.tag][indexPath.item]
        
        return cell
    }
    

    
}
