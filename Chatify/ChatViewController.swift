//
//  ChatViewController.swift
//  Chatify
//
//  Created by Tommy Tran on 27/09/2018.
//  Copyright © 2018 Tommy Tran. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource {
    
    var messages: [PFObject] = []
    
    @IBOutlet weak var chatMessageField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.

    }
    

    
    @IBAction func onSendMsg(_ sender: Any) {
        
        let text = chatMessageField.text
        if(text == ""){
            print("Please type a message..")
        }else{
            let chatMessage = PFObject(className: "Message")
            chatMessage["text"] = text
            chatMessage["user"] = PFUser.current()
            chatMessage.saveInBackground { (success, error) in
                if success {
                    print("The message was saved!")
                    self.chatMessageField.text = ""
                } else if let error = error {
                    print("Problem saving message: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for:indexPath) as! ChatCell
        cell.chatMessageLabel.text = messages[indexPath.row]["text"] as? String
        
        if let user = messages[indexPath.row]["user"] as? PFUser{
            // User found! update username label with username
            cell.usernameLabel.text = user.username
        } else {
            // No user found, set default username
            cell.usernameLabel.text = "🤖"
        }
        return cell
    }
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOutInBackground(block: { (error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Successful loggout")
                // Load and show the login view controller
                self.performSegue(withIdentifier: "logoutSegue", sender: nil)
                
            }
        })
    }
    
    @objc func onTimer(){
        let query = Message.query()
        query?.includeKey("user")
        query?.addDescendingOrder("createdAt")
        query?.limit = 20
        
        // fetch data asynchronously
        query?.findObjectsInBackground{ (messages: [PFObject]?,error: Error?) -> Void in
            if let messages = messages{
                self.messages = messages
                self.tableView.reloadData()
            }
            else{
            }
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
