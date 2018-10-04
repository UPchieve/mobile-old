//
//  StudentVolunteerViewController.swift
//  UPchieve
//
//  Created by Jasmeet Kaur on 02/10/18.
//  Copyright © 2018 Zuoyuan Huang. All rights reserved.
//

import UIKit

class StudentVolunteerViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func  studentButtonClicked(sender:UIButton){
        let destination = self.storyboard?.instantiateViewController(withIdentifier: "register_1") as! RegisterInfoViewController
        self.navigationController?.pushViewController(destination, animated: false)
        
    
    }

    
    @IBAction func  volunteerButtonClicked(sender:UIButton){
    self.showAlert(withTitle: "Sorry", message: "Currently app is not uptodate for volunteer ")
    
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
