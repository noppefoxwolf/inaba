import Foundation
import Files

public final class Inaba {
  private let arguments: [String]
  public init(arguments: [String] = CommandLine.arguments) {
    self.arguments = arguments
  }
  public func run() throws {
    guard arguments.count > 1 else {
      throw Error.missingFileName
    }
    let directoryPath = arguments[1]
    
    do {
      let message = try Inaba.analyticsAllFiles(path: directoryPath)
      print(message)
    } catch {
      throw Error.failedToCreateFile
    }
  }
  
  internal static func analyticsAllFiles(path: String) throws -> String {
    let files = try search(path: path, extensions: "xib", "storyboard")
    let results = files.map({ ($0, analytics(contentOf: $0.path)) }).filter({ $0.1.count > 0 })
    let message = results.map { (file, result) -> String in
      return """
      > \(file.name)
      \(result.joined(separator: "\n"))
      \n
      """
    }
    return message.reduce("", +)
  }
  
  internal static func search(path: String, extensions: String...) throws -> [File] {
    return try Folder(path: path).makeFileSequence(recursive: true).filter({ (file) -> Bool in
      guard let ext = file.extension else { return false }
      return extensions.contains(ext)
    })
  }

  internal static func analytics(contentOf path: String) -> [String] {
    let analyser = XMLAnalyser(contentsOf: URL(fileURLWithPath: path),
                               predicates: [ImageExistsPredicate()])
    return analyser.run()
  }
}

public extension Inaba {
  enum Error: Swift.Error {
    case missingFileName
    case failedToCreateFile
  }
}
