//
//  BasicViewController.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 10/22/17.
//  Copyright © 2017 Zuoyuan Huang. All rights reserved.
//

import UIKit
import MBProgressHUD

extension UIViewController {
    
    func showAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "close", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func updateUIAsync(withFunction function: @escaping () -> Void) {
        DispatchQueue.main.async {
            function()
        }
    }
    
    func showLoadingHUD() {
        let loadingHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingHUD.mode = MBProgressHUDMode.indeterminate
        loadingHUD.label.text = "Uploading..."
    }
    
    func hideHUD() {
        MBProgressHUD.hide(for: self.view, animated: false)
    }
    
}

class BasicViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
