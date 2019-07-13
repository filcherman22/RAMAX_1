//
//  DataManager.swift
//  RAMAX_1
//
//  Created by Филипп on 10.07.2019.
//  Copyright © 2019 Филипп. All rights reserved.
//

import UIKit
import CoreData

class DataManager {
    
    let testDataProduct: Products?
    let nameKey = NameKey()
    var context: NSManagedObjectContext
    
    init() {
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        testDataProduct = Products()
    }
    
    private func getProduct() -> ProductsEntities{
        return ProductsEntities(entity: ProductsEntities.entity(), insertInto: context)
    }
    
    func startCoreData(){
        do{
            let arr = try self.context.fetch(ProductsEntities.fetchRequest()) as! [ProductsEntities]
            if arr.count == 0{
                createStartElements()
            }
        }catch{
            print("error StartCoreData")
        }
    }
    
    
    
    private func createStartElements(){
        
        let startArr = testDataProduct?.getArrProduct()
        do{
            for el in startArr!{
                createProduct(name: el[nameKey.nameKey] as! String, description: el[nameKey.descriptionKey] as! String, price: String(el[nameKey.priceKey] as! Int))
                try context.save()
            }
        }
        catch{
            print("create start element error")
        }
    }
    
    private func createProduct(name: String, description: String, price: String){
        let products = getProduct()
        products.setValue(name, forKey: nameKey.nameKey)
        products.setValue(description, forKey: nameKey.descriptionKey)
        products.setValue(price, forKey: nameKey.priceKey)
        products.setValue(true, forKey: nameKey.isActiveKey)
        products.setValue(String(Date().timeIntervalSince1970), forKey: nameKey.timeIntervalKey)
    }
    
    func getArrProducts() -> [NSDictionary]{
        var dict: [NSDictionary] = []
        let productArr = getEntitiesArr()
        for productEl in productArr{
            dict.append(createDict(product: productEl))
        }
        return dict
    }
    
    private func getEntitiesArr() -> [ProductsEntities]{
        var productArr: [ProductsEntities] = []
        do{
            let result = try context.fetch(ProductsEntities.fetchRequest())
            productArr = result as! [ProductsEntities]
        }
        catch{
            print("error")
        }
        
        return productArr
    }
    
    private func createDict(product: ProductsEntities) -> NSDictionary{
        let name = product.name
        let desc = product.info
        let price = product.price
        let isActive = product.isActive
        let timeInterval = product.timeInterval
        let el: NSDictionary = [
            nameKey.nameKey: name!,
            nameKey.descriptionKey: desc!,
            nameKey.priceKey: price!,
            nameKey.isActiveKey: isActive,
            nameKey.timeIntervalKey: timeInterval!
        ]
        return el
    }
    
    func getEl(index: Int) -> NSDictionary {
        var el: NSDictionary = [:]
        do{
            let result = try context.fetch(ProductsEntities.fetchRequest())
            let productArr = result as! [ProductsEntities]
            el = createDict(product: productArr[index])
        }
        catch{
            print("error get total")
        }
        return el
    }
    
    func addProduct(name: String, description: String, price: String){
        do{
            createProduct(name: name, description: description, price: price)
            try context.save()
        }
        catch{
            print("error add product")
        }
    }
    
    func setFalseIsActive(timeInterval: String){
        let productsArr = getEntitiesArr()
        for i in 0...productsArr.count - 1{
            if productsArr[i].timeInterval! == timeInterval{
                productsArr[i].setValue(false, forKey: nameKey.isActiveKey)
                break
            }
        }
        do{
            try context.save()
        }
        catch{
            print("save error")
        }
    }
    
    func remove(timeInterval: String) {
        let productsArr = getEntitiesArr()
        for i in 0...productsArr.count - 1{
            if productsArr[i].timeInterval! == timeInterval{
                context.delete(productsArr[i])
                break
            }
        }
        do{
            try context.save()
        }
        catch{
            print("error save")
        }
    }
}
