//
//  ChatViewController.swift
//  FirebaseChatApp
//
//  Created by Mohd Wasif Raza on 02/10/23.
//

import UIKit
import MessageKit

struct Message: MessageType {
    var sender: MessageKit.SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKit.MessageKind
}

struct Sender: SenderType {
    var photoUrl: String
    var senderId: String
    var displayName: String
}

class ChatViewController: MessagesViewController {
    private var messages = [Message]()
    private let selfSender = Sender(photoUrl: "",
                                    senderId: "1",
                                    displayName: "MR")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messagesLayoutDelegate = self
        
        messages.append(Message(sender: selfSender,
                                messageId: "1",
                                sentDate: Date(), kind: .text("Hello world")))
        messages.append(Message(sender: selfSender,
                                messageId: "1",
                                sentDate: Date(), kind: .text("This is my first time using message kit")))

        // Do any additional setup after loading the view.
    }
}

extension ChatViewController: MessagesDataSource, MessagesDisplayDelegate, MessagesLayoutDelegate {
    func currentSender() -> MessageKit.SenderType {
        return selfSender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageKit.MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        return messages.count
    }
    
    
}
