// swift-tools-version: 5.6

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "ProgramacaoOrientadaProtocolos",
    platforms: [
        .iOS("15.2")
    ],
    products: [
        .iOSApplication(
            name: "ProgramacaoOrientadaProtocolos",
            targets: ["AppModule"],
            bundleIdentifier: "br.com.jcls.ProgramacaoOrientadaProtocolos",
            teamIdentifier: "SN8P99F4BT",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .placeholder(icon: .bandage),
            accentColor: .presetColor(.orange),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ]
        )
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            path: "."
        )
    ]
)
