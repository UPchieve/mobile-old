//
//  SessionViewController.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 10/23/17.
//  Copyright © 2017 Zuoyuan Huang. All rights reserved.
//

import UIKit

class SessionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var currentUser: UPchieveUser?
    var currentSession: UPchieveSession?
    var chatMessages = [UPchieveChatMessage]()
    var heightChange: CGFloat = 0.0
    var whiteboardViewController: WhiteboardViewController?
    
    @IBOutlet weak var tutorInfoLabel: UILabel!
    @IBOutlet weak var tutorInfoHeader: UIView!
    @IBOutlet weak var chatMessageBar: UIView!
    @IBOutlet weak var chatMessageTextBox: UITextField!
    @IBOutlet weak var chatLogTable: UITableView!
    @IBOutlet weak var sendButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        chatMessageTextBox.isUserInteractionEnabled = false
        sendButton.isUserInteractionEnabled = false
        NotificationCenter.default.addObserver(self, selector: #selector(SessionViewController.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SessionViewController.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SessionViewController.touchOutsideInputBar(sender:)))
        tapGestureRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGestureRecognizer)
        whiteboardViewController = self.storyboard?.instantiateViewController(withIdentifier: "whiteboard") as? WhiteboardViewController
        whiteboardViewController!.currentSession = currentSession
        let _ = whiteboardViewController?.view
        whiteboardViewController?.initializeWhiteboard()
        SessionService.listenSessionChange {
            (newSession) in
            self.loadSession(session: newSession)
            if let volunteer = self.currentSession?.volunteer {
                self.updateUIAsync {
                    self.tutorInfoLabel.text = "In session with " + volunteer.firstname!
                    self.chatMessageTextBox.isUserInteractionEnabled = true
                    self.sendButton.isUserInteractionEnabled = true
                }
            }
        }
        SessionService.listenNewMessage {
            (newMessage) in
            if let newMessage = newMessage {
                self.didReceiveNewMessage(message: newMessage)
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func endSessionButtonClicked(_ sender: Any) {
        SessionService.endSession()
        self.navigationController?.popViewController(animated: true)
    }
    
    func loadSession(session: UPchieveSession?) {
        self.currentSession = session
        self.whiteboardViewController?.updateSession(session)
    }
    
    func keyboardWillShow(notification: Notification) {
        let userInfo = notification.userInfo! as NSDictionary
        let bounds = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        self.view.convert(bounds, to: nil)
        heightChange = bounds.size.height
        let animations: (() -> Void) = {
            self.chatMessageBar.transform = CGAffineTransform(translationX: 0, y: 0-self.heightChange)
        }
        if duration > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).intValue << 16))
            self.chatLogTable.frame = CGRect(origin: self.chatLogTable.frame.origin, size: CGSize(width: self.chatLogTable.frame.size.width, height: self.chatLogTable.frame.size.height-self.heightChange))
            UIView.animate(withDuration: duration, delay: 0, options: options, animations: animations, completion: nil)
            if chatMessages.count > 0 {
                chatLogTable.scrollToRow(at: IndexPath(row: chatMessages.count-1, section: 0), at: .bottom, animated: true)
            }
        } else {
            animations()
        }
    }
    
    func keyboardWillHide(notification: Notification) {
        let userInfo = notification.userInfo! as NSDictionary
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let animations:(() -> Void) = {
            self.chatMessageBar.transform = CGAffineTransform.identity
        }
        if duration > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).intValue << 16))
            UIView.animate(withDuration: duration, delay: 0, options: options, animations: animations, completion: nil)
            self.chatLogTable.frame = CGRect(origin: self.chatLogTable.frame.origin, size: CGSize(width: self.chatLogTable.frame.size.width, height: self.chatLogTable.frame.size.height+self.heightChange))
        } else {
            animations()
        }
    }
    
    func touchOutsideInputBar(sender: UITapGestureRecognizer) {
        if sender.location(in: self.view).y < self.chatMessageBar.frame.origin.y {
            chatMessageTextBox.resignFirstResponder()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return chatMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatLogCell", for: indexPath) as! ChatMessageTableViewCell
        cell.configure(withMessage: chatMessages[indexPath.row])
        return cell
    }
    
    @IBAction func sendButtonClicked(_ sender: Any) {
        let message = UPchieveChatMessage(fromUser: "", time: "", content: chatMessageTextBox.text!, outgoing: true)
        chatMessageTextBox.text = ""
        SessionService.sendMessage(message: message, byUser: currentUser!, toSession: currentSession!)
    }
    
    @IBAction func whiteboardButtonClicked(_ sender: Any) {
        if let destination = whiteboardViewController {
            self.navigationController?.pushViewController(destination, animated: true)
        }
    }
    
    func didReceiveNewMessage(message: UPchieveChatMessage) {
        chatMessages.append(message)
        chatLogTable.beginUpdates()
        chatLogTable.insertRows(at: [IndexPath(row: chatMessages.count-1, section: 0)], with: .automatic)
        chatLogTable.endUpdates()
        chatLogTable.scrollToRow(at: IndexPath(row: chatMessages.count-1, section: 0), at: .bottom, animated: true)
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
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
