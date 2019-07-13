//
//  WebViewController.swift
//  RAMAX_1
//
//  Created by Филипп on 13.07.2019.
//  Copyright © 2019 Филипп. All rights reserved.
//

import UIKit
import MessageUI

class WebViewController: UIViewController, MFMailComposeViewControllerDelegate{

    @IBOutlet weak var webView: UIWebView!
    
    var pdfManager: PdfManager?
    
    @IBAction func tapSendButton(_ sender: Any) {
        self.sendEmail()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.loadRequest(URLRequest(url: (pdfManager?.pathUrl)!))
    }
    
    func sendEmail(){
        if( MFMailComposeViewController.canSendMail() ) {
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self
            
            mailComposer.setToRecipients([])
            mailComposer.setSubject("Наш продукт")
            
            do{
                let fileData = try Data(contentsOf: (self.pdfManager?.pathUrl)!)
                mailComposer.addAttachmentData(fileData, mimeType: "application/pdf", fileName: "Наш продукт.pdf")
            }
            catch{
                
            }
            
            self.present(mailComposer, animated: true, completion: nil)
            return
        }
        print("Email is not configured")
        
    }
    
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?){
        self.dismiss(animated: true, completion: nil)
        print("send")
    }

}
