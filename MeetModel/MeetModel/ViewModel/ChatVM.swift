//
//  ChatVM.swift
//  MeetModel
//
//  Created by Kitlabs Apps on 21/04/26.
//

import Foundation
class ChatVM {
    
    var messages: [Message] = []
    
    func callAPI(message: String, completion: @escaping (Bool) -> Void) {
        
        guard let url = URL(string: "http://127.0.0.1:8000/chat") else { return }
        
        var request             = URLRequest(url: url)
        request.httpMethod      = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let body: [String: Any] = ["message": message]
        request.httpBody        = try? JSONSerialization.data(withJSONObject: body)
       
        URLSession.shared.dataTask(with: request) { data, _, error in
            
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            
            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let reply = json["reply"] as? String {
                
                self.messages.append(Message(text: reply, isUser: false))
                completion(true)
            }
            else {
                completion(false)
            }
            
        }.resume()
    }
}
