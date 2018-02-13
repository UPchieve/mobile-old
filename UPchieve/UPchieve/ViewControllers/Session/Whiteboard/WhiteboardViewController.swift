//
//  WhiteboardViewController.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 11/11/17.
//  Copyright © 2017 Zuoyuan Huang. All rights reserved.
//

import UIKit

class WhiteboardViewController: UIViewController {
    
    var currentSession: UPchieveSession?
    var userBrushes = [WhiteboardPencil(), WhiteboardEraser()]
    var imageSent = 0
    
    var sessionViewController: SessionViewController?
    
    @IBOutlet weak var whiteboard: Whiteboard!
    @IBOutlet weak var colorOne: UIButton!
    @IBOutlet weak var colorTwo: UIButton!
    @IBOutlet weak var colorThree: UIButton!
    @IBOutlet weak var colorFour: UIButton!
    @IBOutlet weak var colorFive: UIButton!
    @IBOutlet weak var colorSix: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initializeWhiteboard() {
        mapColorSelection()
        whiteboard.userBrush = userBrushes[0]
        whiteboard.serverBrush = WhiteboardPencil()
        whiteboard.currentSession = currentSession
    }
    
    func enableSync() {
        self.whiteboard.syncEnabled = true
        whiteboard.listen()
    }
    
    func mapColorSelection() {
        SessionService.colorsToServerColors[colorOne.backgroundColor!] = "rgba(244,71,71,1)"
        SessionService.serverColorToColors["rgba(244, 71, 71, 1)"] = colorOne.backgroundColor

        SessionService.colorsToServerColors[colorTwo.backgroundColor!] = "rgba(255,208,115,.6)"
        SessionService.serverColorToColors["rgba(255, 208, 115, 0.6)"] = colorTwo.backgroundColor
        
        SessionService.colorsToServerColors[colorThree.backgroundColor!] = "rgba(22,210,170,.6)"
        SessionService.serverColorToColors["rgba(22, 210, 170, 0.6)"] = colorThree.backgroundColor
        
        SessionService.colorsToServerColors[colorFour.backgroundColor!] = "rgba(24,85,209,.6)"
        SessionService.serverColorToColors["rgba(24, 85, 209, 0.6)"] = colorFour.backgroundColor
        
        SessionService.colorsToServerColors[colorFive.backgroundColor!] = "rgba(52,52,64,.6)"
        SessionService.serverColorToColors["rgba(52, 52, 64, 0.6)"] = colorFive.backgroundColor
        
        SessionService.colorsToServerColors[colorSix.backgroundColor!] = "rgba(38,51,104,1)"
        SessionService.serverColorToColors["rgb(38, 51, 104)"] = colorSix.backgroundColor
    }
    
    func updateSession(_ session: UPchieveSession?) {
        self.currentSession = session
        self.whiteboard.currentSession = session
    }
    
    @IBAction func newBrushSelected(_ sender: UISegmentedControl) {
        whiteboard.switchBrush(userBrushes[sender.selectedSegmentIndex])
    }

    @IBAction func colorButtonClicked(_ sender: UIButton) {
        whiteboard.switchColor(color: sender.backgroundColor!, brush: whiteboard.userBrush!)
    }
    
    @IBAction func clearButtonClicked(_ sender: Any) {
        whiteboard.clear()
    }
    
    @IBAction func sendButtonClicked(_ sender: Any) {
        let filename = currentSession!.sessionId + "_" + String(imageSent) + ".jpg"
        imageSent += 1
        showLoadingHUD()
        if let image = whiteboard.drawedImage {
            guard let data = UIImageJPEGRepresentation(image, 0.8) else {
                return
            }
            let fileManager = FileManager.default
            let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(filename)
            fileManager.createFile(atPath: paths as String, contents: data, attributes: nil)
            NetworkService.uploadToFTP(filePath: paths, filename: filename) {
                self.updateUIAsync {
                    self.sessionViewController?.didSentWhiteboardImage(image: image)
                    self.navigationController?.popViewController(animated: true)
                    self.whiteboard.clear()
                    self.hideHUD()
                }
            }
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

}
