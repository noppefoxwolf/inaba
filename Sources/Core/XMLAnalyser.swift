//
//  XMLAnalyser.swift
//  Core
//
//  Created by Tomoya Hirano on 2018/04/19.
//

import Foundation

final class XMLAnalyser: NSObject, XMLParserDelegate {
  private let parser: XMLParser
  private let predicates: [Predicating]
  private var results: [String] = []
  private var isFinished: Bool = false
  
  init(contentsOf url: URL, predicates: [Predicating]) {
    self.parser = XMLParser(contentsOf: url)!
    self.predicates = predicates
    super.init()
    parser.delegate = self
  }
  
  func run() -> [String] {
    parser.parse()
    while !isFinished {
      RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.5))
    }
    return results
  }
  
  func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
    let results = predicates.compactMap({ $0.check(elementName, attributeDict: attributeDict) })
    self.results.append(contentsOf: results)
  }
  
  func parserDidEndDocument(_ parser: XMLParser) {
    isFinished = true
  }
  
  func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
    isFinished = true
  }
}
