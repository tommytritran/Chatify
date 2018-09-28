//
//  ChatCell.swift
//  Chatify
//
//  Created by Tommy Tran on 27/09/2018.
//  Copyright © 2018 Tommy Tran. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var chatMessageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
