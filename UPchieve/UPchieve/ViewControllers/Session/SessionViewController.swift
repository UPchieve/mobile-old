//
//  SessionViewController.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 10/23/17.
//  Copyright © 2017 Zuoyuan Huang. All rights reserved.
//

import UIKit
import SideMenu

class SessionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SidebarViewControllerSource {
    
    let navigationBarInactiveBackground = UIColor(red:0.45, green:0.45, blue:0.47, alpha:1.0).image
    let navigationBarActiveBackgound = globalTintColor.image
    let chatTextBoxBorderColor = UIColor(red:0.60, green:0.60, blue:0.62, alpha:1.0)
    
    var currentUser: UserModel?
    var currentSession: UPchieveSession?
    var chatMessages = [UPchieveChatMessage]()
    var heightChange: CGFloat = 0.0
    var whiteboardViewController: WhiteboardViewController?
    var menuLeftNavigationController: SidebarSlideMenuNavigationController?

    @IBOutlet weak var contactingMessageLabel: UILabel!
    @IBOutlet weak var chatMessageBar: UIView!
    @IBOutlet weak var chatMessageTextBox: UITextField!
    @IBOutlet weak var chatLogTable: UITableView!
    @IBOutlet weak var sendButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewElements()
        SessionService.listenSessionChange {
            (newSession) in
            self.loadSession(session: newSession)
            if let volunteer = self.currentSession?.volunteer {
                self.updateUIAsync {
                    self.navigationController?.navigationBar.setBackgroundImage(self.navigationBarActiveBackgound, for: .default)
                    self.navigationItem.title = (volunteer.firstname ?? "Volunteer")
                    self.contactingMessageLabel.isHidden = true
                    self.chatMessageTextBox.isUserInteractionEnabled = true
                    self.sendButton.isUserInteractionEnabled = true
                }
            }
        }
        SessionService.listenNewMessage(currentUser: currentUser?.user) {
            (newMessage) in
            if let newMessage = newMessage {
                self.didReceiveNewMessage(message: newMessage)
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func configureViewElements() {
        chatMessageTextBox.isUserInteractionEnabled = false
        chatMessageTextBox.placeholder = "Type here."
        chatMessageTextBox.layer.borderColor = chatTextBoxBorderColor.cgColor
        chatMessageTextBox.setPadding(width: 10)
        sendButton.isUserInteractionEnabled = false
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(navigationBarInactiveBackground, for: .default)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        setupSidebar()
        NotificationCenter.default.addObserver(self, selector: #selector(SessionViewController.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SessionViewController.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SessionViewController.touchOutsideInputBar(sender:)))
        tapGestureRecognizer.cancelsTouchesInView = false
        chatLogTable.rowHeight = UITableViewAutomaticDimension
        chatLogTable.estimatedRowHeight = 86
        chatLogTable.separatorColor = UIColor.clear
        self.view.addGestureRecognizer(tapGestureRecognizer)
        whiteboardViewController = self.storyboard?.instantiateViewController(withIdentifier: "whiteboard") as? WhiteboardViewController
        whiteboardViewController!.currentSession = currentSession
        whiteboardViewController?.sessionViewController = self
        let _ = whiteboardViewController?.view
        whiteboardViewController?.initializeWhiteboard()
        if UIDevice().model == "iPad" {
            whiteboardViewController?.enableSync()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func endSessionButtonClicked(_ sender: Any) {
        SessionService.endSession()
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupSidebar() {
        menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "sideMenuNavigationController") as? SidebarSlideMenuNavigationController
        SideMenuManager.menuLeftNavigationController = menuLeftNavigationController
        SideMenuManager.menuFadeStatusBar = false
        menuLeftNavigationController?.currentUser = currentUser?.user
        let sidebarMenuButton = UIBarButtonItem(title: "Sidebar", style: .plain, target: self, action: #selector(sidebarButtonClicked))
        self.navigationItem.setLeftBarButton(sidebarMenuButton, animated: false)
        menuLeftNavigationController?.sourceViewController = self
    }
    
    func sidebarButtonClicked() {
        present(SideMenuManager.menuLeftNavigationController!, animated: true, completion: nil)
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
        let message = chatMessages[indexPath.row]
        var cell: ChatMessageTableViewCell?
        if message.outgoing {
            if message.isImage {
                cell = tableView.dequeueReusableCell(withIdentifier: "outgoingImageCell", for: indexPath) as! ChatMessageOutgoingImageTableViewCell
                cell?.sessionViewController = self
            } else {
                cell = tableView.dequeueReusableCell(withIdentifier: "outgoingChatLogCell", for: indexPath) as! ChatMessageOutgoingTableViewCell
            }
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "incomingChatLogCell", for: indexPath) as! ChatMessageIncomingTableViewCell
        }
        cell?.configure(withMessage: chatMessages[indexPath.row])
        return cell!
    }
    
    func handleSidebarAction(action: SidebarAction) {
        if action == SidebarAction.dashboard {
            SessionService.endSession()
            dismiss(animated: true, completion: nil)
            let destination = self.storyboard?.instantiateViewController(withIdentifier: "dashboard") as! DashboardViewController
            // destination.currentUser = currentUser
            self.navigationController?.pushViewController(destination, animated: true)
        }
    }
    
    func showFullScreenImage(image: UIImage?) {
        let destination = self.storyboard?.instantiateViewController(withIdentifier: "fullScreenImageView") as! FullScreenImageViewController
        destination.setImage(image: image)
        self.navigationController?.pushViewController(destination, animated: false)
    }
    
    @IBAction func sendButtonClicked(_ sender: Any) {
        let message = UPchieveChatMessage(fromUser: "", time: "", content: chatMessageTextBox.text!, outgoing: true, isImage: false, image: nil)
        chatMessageTextBox.text = ""
        SessionService.sendMessage(message: message, byUser: currentUser!.user!, toSession: currentSession!)
    }
    
    @IBAction func whiteboardButtonClicked(_ sender: Any) {
        if chatMessageTextBox.isFirstResponder {
            chatMessageTextBox.resignFirstResponder()
        }
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
    
    func didSentWhiteboardImage(image: UIImage) {
        chatMessages.append(UPchieveChatMessage(fromUser: "", time: "", content: chatMessageTextBox.text!, outgoing: true, isImage: true, image: image))
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
