//
//  MessageComposable.swift
//  KKLLExtensions
//
//  Created by Kelvin Lau on 2016-11-14.
//  Copyright © 2016 Kelvin Lau. All rights reserved.
//

import MessageUI

enum MessageError: Error {
  case textingUnavailable
  case mailUnavailable
}

protocol MessageComposable {}

extension MessageComposable where Self: UIViewController, Self: MFMessageComposeViewControllerDelegate {
  func showMessageComposer(to: [String], body: String, subject: String? = nil) throws {
    guard MFMessageComposeViewController.canSendText() else { throw MessageError.textingUnavailable }
    
    let messageComposer = MFMessageComposeViewController()
    messageComposer.body = body
    messageComposer.messageComposeDelegate = self
    if let subject = subject, MFMessageComposeViewController.canSendSubject() {
      messageComposer.subject = subject
    }
    
    present(messageComposer, animated: true, completion: nil)
  }
}

extension MessageComposable where Self: UIViewController, Self: MFMailComposeViewControllerDelegate {
  func showMailComposer(to: [String], body: String, subject: String) throws {
    guard MFMailComposeViewController.canSendMail() else { throw MessageError.mailUnavailable }
    
    let mailComposer = MFMailComposeViewController()
    mailComposer.setSubject(subject)
    mailComposer.setMessageBody(body, isHTML: false)
    mailComposer.setToRecipients(to)
    mailComposer.mailComposeDelegate = self
    
    present(mailComposer, animated: true, completion: nil)
  }
}
