//
//  SegueHandlerType.swift
//  KKLLExtensions
//
//  Created by Kelvin Lau on 2016-11-14.
//  Copyright © 2016 Kelvin Lau. All rights reserved.
//

import UIKit


/// From the 2015 WWDC video. https://developer.apple.com/videos/play/wwdc2015/411/?time=1604
protocol SegueHandlerType {
  associatedtype SegueIdentifier: RawRepresentable
}

extension SegueHandlerType where Self: UIViewController, SegueIdentifier.RawValue == String {
  func performSegue(withIdentifier identifier: SegueIdentifier, sender: Any?) {
    performSegue(withIdentifier: identifier.rawValue, sender: sender)
  }
  
  func segueIdentifierFor(segue: UIStoryboardSegue) -> SegueIdentifier {
    guard let identifier = segue.identifier, let segueIdentifier = SegueIdentifier(rawValue: identifier) else { fatalError("Invalid identifier supplied") }
    return segueIdentifier
  }
}
