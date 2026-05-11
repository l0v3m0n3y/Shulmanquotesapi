// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "shulmanquotesapi",
    platforms: [
        .macOS(.v12), .iOS(.v15)
    ],
    products: [
        .library(name: "shulmanquotesapi", targets: ["shulmanquotesapi"]),
    ],
    targets: [
        .target(
            name: "shulmanquotesapi",
            path: "src"
        ),
    ]
)
