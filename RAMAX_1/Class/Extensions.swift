//
//  Extensions.swift
//  RAMAX_1
//
//  Created by Филипп on 10.07.2019.
//  Copyright © 2019 Филипп. All rights reserved.
//

import UIKit

extension Notification.Name {
    static let addProduct = Notification.Name("addProduct")
    static let removeProduct = Notification.Name("removeProduct")
}

extension UITableView {
    func reloadData(with animation: UITableView.RowAnimation) {
        reloadSections(IndexSet(integersIn: 0..<numberOfSections), with: animation)
    }
}
