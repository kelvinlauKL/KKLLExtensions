//
//  TestViewController.swift
//  KKLLExtensions
//
//  Created by Kelvin Lau on 2016-11-14.
//  Copyright © 2016 Kelvin Lau. All rights reserved.
//

import UIKit
import MessageUI

final class TestViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    do {
      try getPhoto()
    } catch {
      print("gah")
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(true)
    
    do {
      try getPhoto()
    } catch {
      print("gah")
    }
  }
}

// MARK: - MessageComposable
extension TestViewController: MessageComposable, ImagePickable {
  
}

extension TestViewController: MFMessageComposeViewControllerDelegate {
  func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
    print("didFinish")
    controller.dismiss(animated: true, completion: nil)
  }
}

extension TestViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    picker.dismiss(animated: true, completion: nil)
  }
}
