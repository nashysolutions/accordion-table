// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "accordion-table",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "AccordionTable",
            targets: ["AccordionTable"]),
    ],
    targets: [
        .target(
            name: "AccordionTable"
        )
    ]
)
