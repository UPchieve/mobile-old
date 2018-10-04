//
//  FooterView.swift
//  UPchieve
//
//  Created by Jasmeet Kaur on 16/09/18.
//  Copyright © 2018 Zuoyuan Huang. All rights reserved.
//

import UIKit

class FooterView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBOutlet weak var contactUs:UIButton!
    @IBOutlet weak var legalPolicy:UIButton!
    @IBOutlet weak var footerView:UIView!
    
    
    var webViewController:WebViewController = WebViewController()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    fileprivate func sharedInit(){
        Bundle.main.loadNibNamed("FooterView", owner: self, options: nil)
        loadWebViewController()

        self.addSubview(footerView)
        footerView.frame = self.bounds
        footerView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
        //translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        sharedInit()
    }
    
    
    
    
    func loadWebViewController(){
        
        
            DispatchQueue.main.async(execute: {
                
                self.webViewController.view.setNeedsLayout()
            })
        
    }

    
    @IBAction func contactUsClicked(button:UIButton){
        
        self.webViewController.url = "https://app.upchieve.org/#/contact"
        webViewController.changeURL()
        parentViewController.navigationController?.pushViewController(self.webViewController, animated: false)
        
        
    }

    
    @IBAction func legalPolicyClicked(button:UIButton){
        

        
       self.webViewController.url = "https://app.upchieve.org/#/legal"
        webViewController.changeURL()
        parentViewController.navigationController?.pushViewController(self.webViewController, animated: false)
        
    }
}


extension UIView {
    var parentViewController: UIViewController {
        
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return UIViewController()
}
    
}
