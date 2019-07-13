//
//  BuyTableViewController.swift
//  RAMAX_1
//
//  Created by Филипп on 08.07.2019.
//  Copyright © 2019 Филипп. All rights reserved.
//

import UIKit

class BuyTableViewController: UITableViewController {

    let dataProduct = DataManager()
    let nameKey = NameKey()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCustomObserver()
        dataProduct.startCoreData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.dataProduct.getArrProducts().count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BuyCell", for: indexPath)

        let product = self.dataProduct.getArrProducts()[indexPath.row]
        cell.textLabel?.text = product[nameKey.nameKey] as? String
        cell.selectionStyle = .none

        return cell
    }
    
    @objc private func reloadData(notfication: NSNotification){
        self.tableView.reloadData()
    }
 
    private func addCustomObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData(notfication:)), name: Notification.Name.addProduct, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData(notfication:)), name: Notification.Name.removeProduct, object: nil)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toBuyProductPage"{
            if let list = segue.destination as? ProductViewController{
                let index = self.tableView.indexPathForSelectedRow
                list.product = self.dataProduct.getArrProducts()[(index?.row)!]
            }
            
        }
    }
 

}
