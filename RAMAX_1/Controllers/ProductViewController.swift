//
//  ProductViewController.swift
//  RAMAX_1
//
//  Created by Филипп on 08.07.2019.
//  Copyright © 2019 Филипп. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var pdfButton: UIButton!
    
    @IBAction func tapBuyButton(_ sender: Any) {
        self.buyButton.isEnabled = false
        self.pdfButton.isEnabled = false
        let timeInt = product![nameKey.timeIntervalKey] as! String
        dataProduct.setFalseIsActive(timeInterval: timeInt)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(self.timeAddDelay), execute: {
            self.dataProduct.remove(timeInterval: timeInt)
            NotificationCenter.default.post(name: .removeProduct, object: nil)
        })
    }
    @IBAction func tapPdfButton(_ sender: Any) {
    }
    
    var product: NSDictionary?
    let nameKey = NameKey()
    let dataProduct = DataManager()
    let timeAddDelay: Int = 3
    
    override func viewWillAppear(_ animated: Bool) {
        if self.product != nil{
            self.nameLabel.text = self.product?[nameKey.nameKey] as? String
            let price = self.product?[nameKey.priceKey] as? String
            if price != nil{
                self.priceLabel.text = price! + " руб."
            }else{
                self.priceLabel.text = ""
            }
            self.descriptionLabel.text = self.product?[nameKey.descriptionKey] as? String
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startEditButton()
        // Do any additional setup after loading the view.
    }
    
    private func startEditButton(){
        let isActive = self.product![nameKey.isActiveKey] as! Bool
        if !isActive{
            self.pdfButton.isEnabled = false
            self.buyButton.isEnabled = false
        }
    }

}
