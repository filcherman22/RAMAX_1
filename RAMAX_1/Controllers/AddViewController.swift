//
//  AddViewController.swift
//  RAMAX_1
//
//  Created by Филипп on 08.07.2019.
//  Copyright © 2019 Филипп. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var hideBatton: UIButton!
    
    @IBAction func tapHideButton(_ sender: UIButton) {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil,from:nil,for:nil)
        self.hideBatton.isHidden = true
    }
    @IBAction func addProductAction(_ sender: Any) {
        addProduct()
    }
    
    let dataProduct = DataManager()
    let timeAddDelay: Int = 5
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hideBatton.isHidden = true
        self.editButton(isEnabled: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createObservers()
        // Do any additional setup after loading the view.
    }
    
    func addProduct(){
        let name = self.nameTextField.text
        let desc = self.descriptionTextField.text
        let price = self.priceTextField.text
        if (name?.count)! > 0 && (desc?.count)! > 0 && (price?.count)! > 0{
            clearTextFields()
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(self.timeAddDelay), execute: {
                self.dataProduct.addProduct(name: name!, description: desc!, price: price!)
                NotificationCenter.default.post(name: .addProduct, object: nil)
            })
        }
    }
    
    private func clearTextFields(){
        self.nameTextField.text = ""
        self.descriptionTextField.text = ""
        self.priceTextField.text = ""
    }
    
    private func editButton(isEnabled: Bool){
        self.addButton.isEnabled = isEnabled
    }

    func createObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(AddViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {
        self.hideBatton.isHidden = false
    }

}
