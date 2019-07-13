//
//  DataInterface.swift
//  RAMAX_1
//
//  Created by Филипп on 08.07.2019.
//  Copyright © 2019 Филипп. All rights reserved.
//

import UIKit
//import SQLite3

class Products {
    
    init() {
        
//        print(getArrProduct())
    }
    
    func getArrProduct() -> [NSDictionary]{
        var nsArray: NSArray?
        if let path = Bundle.main.path(forResource: "TestProduct", ofType: "plist") {
            nsArray = NSArray(contentsOfFile: path)
        }
        return nsArray as? [NSDictionary] ?? []
    }
    
}
