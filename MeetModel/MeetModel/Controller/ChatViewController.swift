//
//  ChatViewController.swift
//  MeetModel
//

import Foundation
import UIKit

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tvChat    : UITableView!
    @IBOutlet weak var tfMessage : UITextField!
    @IBOutlet weak var progressView : UIActivityIndicatorView!
    
    private let viewModel = ChatVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.progressView.hidesWhenStopped = true
    }
    
    @IBAction func btnsend(_ sender: UIButton) {
    
        guard let text = tfMessage.text, !text.isEmpty else { return }
        self.progressView.startAnimating()
        self.viewModel.messages.append(Message(text: text, isUser: true))
        DispatchQueue.main.async {
    
            self.tvChat.reloadData()
            self.scrollToBottom()
        }
        tfMessage.text = ""
        
        self.viewModel.callAPI(message: text){ [weak self] reply in
           
            
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                
                self.progressView.stopAnimating()
                self.tvChat.reloadData()
                self.scrollToBottom()
            }
        }
    }
    
    private func scrollToBottom() {
       
        guard self.viewModel.messages.count > 0 else { return }
        
        let indexPath = IndexPath(row: self.viewModel.messages.count - 1, section: 0)
        tvChat.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
}
extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let message = self.viewModel.messages[indexPath.row]
        cell.textLabel?.text = message.text
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textAlignment = message.isUser ? .right : .left
        return cell
    }
}
