//
//  Message.swift
//  MeetModel
//

import Foundation
import UIKit

struct Message {
   
    let text: String
    let isUser: Bool
}
struct ChatRequest: Codable {
    let message: String
}

struct ChatResponse: Codable {
    let reply: String
}
