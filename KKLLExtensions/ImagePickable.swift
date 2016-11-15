//
//  ImagePickable.swift
//  KKLLExtensions
//
//  Created by Kelvin Lau on 2016-11-14.
//  Copyright © 2016 Kelvin Lau. All rights reserved.
//

import UIKit

enum ImagePickerError: Error {
  case allSourcesUnavailable
  case sourceUnavailable
  case cameraUnavailable
  case libraryUnavailable
}

// Convenient way to show an image picker.
protocol ImagePickable {}

extension ImagePickable where Self: UIViewController, Self: UIImagePickerControllerDelegate, Self: UINavigationControllerDelegate {
  func getPhotoFrom(source: UIImagePickerControllerSourceType) throws {
    guard UIImagePickerController.isSourceTypeAvailable(source) else { throw ImagePickerError.sourceUnavailable }
    let imagePickerController = UIImagePickerController()
    imagePickerController.sourceType = source
    imagePickerController.delegate = self
    present(imagePickerController, animated: true, completion: nil)
  }
  
  func getPhoto() throws {
    // if both sources available, then present a alert sheet for user to pick
    if UIImagePickerController.isSourceTypeAvailable(.camera) && UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
      let alertController = UIAlertController(title: "Choose a source", message: nil, preferredStyle: .actionSheet)
      let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
        try! self.getPhotoFrom(source: .camera)
      }
      let libraryAction = UIAlertAction(title: "Library", style: .default) { _ in
        try! self.getPhotoFrom(source: .photoLibrary)
      }
      alertController.addAction(cameraAction)
      alertController.addAction(libraryAction)
      present(alertController, animated: true, completion: nil)
    } else if UIImagePickerController.isSourceTypeAvailable(.camera) { // if camera is available, show camera
      try! getPhotoFrom(source: .camera)
    } else if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) { // if photolib is available, show photo lib
      try! getPhotoFrom(source: .photoLibrary)
    } else { // no source available. Throw
      throw ImagePickerError.allSourcesUnavailable
    }
  }
}
