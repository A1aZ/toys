// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "PDFToLongImage",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .executable(
            name: "PDFToLongImage",
            targets: ["PDFToLongImage"]
        )
    ],
    targets: [
        .executableTarget(
            name: "PDFToLongImage",
            dependencies: [],
            path: ".",
            sources: [
                "PDFToLongImageApp.swift",
                "ContentView.swift",
                "PDFProcessor.swift"
            ]
        )
    ]
)
