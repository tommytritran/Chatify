//
//  Message.swift
//  Chatify
//
//  Created by Tommy Tran on 28/09/2018.
//  Copyright © 2018 Tommy Tran. All rights reserved.
//

import Foundation
import Parse
class Message: PFObject, PFSubclassing{
    @NSManaged var message: String
    
    static func parseClassName() -> String {
        return "Message"
    }
    
    
}
