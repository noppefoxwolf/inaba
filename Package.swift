// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Inaba",
  dependencies: [
    .package(url: "https://github.com/johnsundell/files.git", from: "2.2.1")
  ],
  targets: [
    .target(name: "Inaba", dependencies: ["Core"]),
    .target(name: "Core", dependencies: ["Files"]),
    .testTarget(name: "CoreTests", dependencies: ["Core"], path: "Tests/CoreTests")
  ]
)
