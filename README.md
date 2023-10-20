
# HelpfulKit

Helpful Extension, Structures and Classes



## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org/) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
  $ gem install cocoapods
```

CocoaPods 1.1.0+ is required to build `HelpfulKit 1.0.4`.

To integrate HelpfulKit into your Xcode project using CocoaPods, specify it in your `Podfile`.:

```bash
source 'https://github.com/DipakPanchasara/HelpfulKit.git'
platform :ios, '11.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'HelpfulKit'
end
```

Then, run the following command:

```bash
  $ pod install
```

### Swift Package Manager

[Swift Package Manager](https://www.swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

`Xcode 11+` is required to build HelpfulKit using Swift Package Manager.

To integrate HelpfulKit into your Xcode project using Swift Package Manager, add it to the dependencies value of your `Package.swift`:

```bash
  dependencies: [
    .package(url: "https://github.com/DipakPanchasara/HelpfulKit.git")
]
```
## License

HelpfulKit is released under the MIT license. See LICENSE for details.

