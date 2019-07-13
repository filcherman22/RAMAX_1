//
//  PdfManager.swift
//  RAMAX_1
//
//  Created by Филипп on 13.07.2019.
//  Copyright © 2019 Филипп. All rights reserved.
//

import UIKit

class PdfManager{
    
    var pathUrl: URL?
    var pathStr: String?
    let heightView: CGFloat = 877.0
    let widthView: CGFloat = 620.0
    
    init(title: String, description: String, price: String) {
        let path = self.createPath(title: title, description: description, price: price)
        self.pathUrl = URL(fileURLWithPath: path)
        self.pathStr = path
    }
    
    deinit {
        deleteFile()
    }
    
    private func createPath(title: String, description: String, price: String) -> String{
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.widthView, height: self.heightView))
        
        let titleLabel = createLabel(text: title, sizeFont: 35)
        let priceLabel = createLabel(text: price, sizeFont: 30)
        let descriptionLabel = createLabel(text: description, sizeFont: 30)
        let imageView = createImageView()
        
        editCoord(logoView: imageView, titleLabel: titleLabel, priceLabel: priceLabel, descriptionLabel: descriptionLabel)
        
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(priceLabel)
        view.addSubview(descriptionLabel)
        
        let path = createPdf(view: view)
        return path
    }
    
    private func createImageView() -> UIImageView{
        let image = UIImage(named: "Shop.png")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        
        imageView.image = image
        return imageView
    }
    
    private func createLabel(text: String, sizeFont: CGFloat)-> UILabel{
        let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: self.widthView, height: sizeFont + 3))
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: label.font.fontName, size: sizeFont)
        label.text = text
        return label
    }
    
    private func editCoord(logoView: UIImageView, titleLabel: UILabel, priceLabel: UILabel, descriptionLabel: UILabel){
        logoView.center = CGPoint(x: self.widthView / 2, y: 150)
        titleLabel.center = CGPoint(x: self.widthView / 2, y: logoView.center.y + logoView.frame.size.height / 2 + titleLabel.frame.size.height / 2 + 50)
        priceLabel.center = CGPoint(x: self.widthView / 2, y: titleLabel.center.y + titleLabel.frame.size.height / 2 + priceLabel.frame.size.height)
        descriptionLabel.bounds.size.height = self.heightView - (priceLabel.center.y + priceLabel.frame.size.height / 2 + 200)
        descriptionLabel.center = CGPoint(x: self.widthView / 2, y: priceLabel.center.y + priceLabel.frame.size.height / 2 + descriptionLabel.frame.size.height / 2)
    }
    
    private func createPdf(view: UIView) -> String{
        let path = view.exportAsPdfFromView()
        return path
    }
    
    private func deleteFile(){
        let fileManager = FileManager.default
        do{
            try fileManager.removeItem(at: self.pathUrl!)
        }
        catch{
            print("error delete file")
        }
    }
    
    
}
