//
//  HeaderView.swift
//  UPchieve
//
//  Created by Jasmeet Kaur on 02/10/18.
//  Copyright © 2018 Zuoyuan Huang. All rights reserved.
//

import Foundation
import UIKit
class HeaderView: UIView {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    @IBOutlet weak var login:UIButton!
    @IBOutlet weak var register:UIButton!
    @IBOutlet weak var headerView:UIView!
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    fileprivate func sharedInit(){
        Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)
        
        
        self.addSubview(headerView)
        headerView.frame = self.bounds
        headerView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
        //translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        sharedInit()
    }

    
    override func layoutSubviews() {
        checkforParentViewController()
    }
    func checkforParentViewController(){
        self.register.setTitleColor(#colorLiteral(red: 0.3725490196, green: 0.8784313725, blue: 0.7882352941, alpha: 1), for: .disabled)
        self.register.setTitleColor( #colorLiteral(red: 0.4509336352, green: 0.4510141015, blue: 0.4766838551, alpha: 1), for: .focused)
        
        self.login.setTitleColor(#colorLiteral(red: 0.3725490196, green: 0.8784313725, blue: 0.7882352941, alpha: 1), for: .disabled)
        self.login.setTitleColor( #colorLiteral(red: 0.4509336352, green: 0.4510141015, blue: 0.4766838551, alpha: 1), for: .focused)
        
        
        if parentViewController is LoginViewController{
            self.login.isEnabled = false
           
            self.register.isEnabled = true
        }else{
            
            self.register.isEnabled = false
            
           
            self.login.isEnabled = true
            
        }
            
            
        
        
        
    }
    
    
    @IBAction func loginButtonClicked(button:UIButton){
    
        let destination = parentViewController.storyboard?.instantiateViewController(withIdentifier: "login") as! LoginViewController
        AuthService.logout(onError: {
            self.parentViewController.updateUIAsync {
              self.parentViewController.navigationController?.popViewController(animated: false)
                self.parentViewController.navigationController?.pushViewController(destination, animated: false)
            }
        }) {
            self.parentViewController.updateUIAsync {
               self.parentViewController.navigationController?.popViewController(animated: false)
                self.parentViewController.navigationController?.pushViewController(destination, animated: false)
            }
        }

        
    }
    
    
    @IBAction func registerButtonClicked(button:UIButton){
        
        let destination = parentViewController.navigationController?.storyboard?.instantiateViewController(withIdentifier: "studentVolunteer") as! StudentVolunteerViewController
       
        parentViewController.navigationController?.popViewController(animated: false)
        parentViewController.navigationController?.pushViewController(destination, animated: false)
        
        
    }
}
