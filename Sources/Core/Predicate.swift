//
//  Predicate.swift
//  Core
//
//  Created by Tomoya Hirano on 2018/04/19.
//

import Foundation

protocol Predicating {
  func check(_ elementName: String, attributeDict: [String : String]) -> String?
}

struct ImageExistsPredicate: Predicating {
  func check(_ elementName: String, attributeDict: [String : String]) -> String? {
    guard elementName == "imageView" else { return nil }
    guard let image = attributeDict["image"] else { return nil }
    guard !image.isEmpty else { return nil }
    return "🌁 An image is specified outside the code. (\(image))"
  }
}
