//
//  WebViewController.swift
//  UPchieve
//
//  Created by Jasmeet Kaur on 16/09/18.
//  Copyright © 2018 Zuoyuan Huang. All rights reserved.
//

import UIKit
import WebKit
class WebViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    var url:String = "https://www.google.com/"
    
    @IBOutlet weak var doneButton:UIButton!
  
    override func loadView() {
        super.loadView()
        let webConfiguration = WKWebViewConfiguration()
        let frame = CGRect(x:0,y:0,width:self.view.frame.size.width,height:self.view.frame.size.height)
        webView = WKWebView(frame: frame, configuration: webConfiguration)
        webView.uiDelegate = self
        //self.view.addSubview(doneButton)
        self.view.addSubview(webView)
        //view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: url)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }


    func changeURL(){
        let myURL = URL(string: url)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    
    
    }

    func webViewDidStartLoad(_ webView: UIWebView)
    {
        
        showLoadingHUD()
        
    }
    func webViewDidFinishLoad(_ webView: UIWebView){
        
        hideHUD()
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error)
    {
        
        self.updateUIAsync {
            self.hideHUD()
            self.showAlert(withTitle: "Sorry", message: "We are not able to load the page")
        }
        
    }
    @IBAction func doneButtonClicked(sender:UIButton){
        
        self.navigationController?.dismiss(animated:false, completion: nil)
        
    }
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

