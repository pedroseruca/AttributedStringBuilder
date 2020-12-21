# AttributedStringBuilder
[![Documentation](https://img.shields.io/badge/Read_the-Docs-67ad5c.svg)]()
[![Language: Swift 5](https://img.shields.io/badge/language-swift%205-f48041.svg?style=flat)](https://developer.apple.com/swift)
![Platform: iOS 8+](https://img.shields.io/badge/platform-iOS%20|%20tvOS-blue.svg?style=flat)
[![CocoaPods compatible](https://img.shields.io/badge/Cocoapods-compatible-4BC51D.svg?style=flat)](https://cocoapods.org/pods/AttributedStringBuilder)
[![License: MIT](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](https://github.com/pedroseruca/AttributedStringBuilder/blob/main/LICENSE)
[![GitHub contributors](https://img.shields.io/github/contributors/pedroseruca/AttributedStringBuilder)](https://github.com/pedroseruca/AttributedStringBuilder/graphs/contributors)
[![GitHub tag](https://img.shields.io/github/release/pedroseruca/AttributedStringBuilder)](https://github.com/pedroseruca/AttributedStringBuilder/releases)

> A strong type implementation for Swift AttributedStrings

- [Why?](#why-this-project)
    - [Other motives to create this](#other-motives-to-create-this)
        - [Improve](#improve)
        - [Explore](#Explore)
        - [Implement](#Implement)
        
- [Solution](#solution)

- [Installation](#installation)

- [Documentation](#documentation)

- [Inspired](#inspired)

# Why this project?
If you work on a project that stands on precision designs and astetics, like me, you work on a daily basis with 
heavy costumizable text styles. This is only possible to accomplish using the Foundation class NSAttributedString (or NSMutableAttributedString) which provides many attributes that we can set, to get the results our Designer's demand.


```swift
let font = UIFont.systemFont(ofSize: 72)
let paragraphStyle = NSMutableParagraphStyle()
paragraphStyle.alignment = .center
paragraphStyle.firstLineHeadIndent = 5.0

let attributes: [NSAttributedString.Key: Any] = [
    .font: font,
    .foregroundColor: UIColor.blue,
    .paragraphStyle: paragraphStyle
]

let attributedQuote = NSAttributedString(string: quote, attributes: attributes)
```
exemple from [hackingwithswift](https://www.hackingwithswift.com/articles/113/nsattributedstring-by-example)

This free of charge class comes with some drawbacks when called to heavy duty. 
- A lot of boilerplate - making views much more complex than needed and harder to read
- It uses a [NSAttributedString.Key: Any] dictionary which is not fail proof since compiler allows any object as a value

## Other motives to create this
I will also use this project as a elaborated playground, which allows me to explore and improve more than just code skills. In my opinion this skills became as relevant as coding (if not more) while we (dev's) start to climb the team ladder. Also, it is most probably that there will not be a "step by step" tutorial or a "pair programing" phase to teach us how to do it.

### Improve
##### Documentation:
> This is my first "from the ground up" documentation. You might find typo's, weird ideas, and many many "Update README.md" commits.

### Explore
// modularisation

// new upcoming swift tools

// cocoaPods

### Implement
// design patterns

# Solution
The AttributedStringBuilder is a wrapper around this class that ensures the correct use of each attribute to be applied
with reduced and chainable code. It also allows direct String access, with many flavours. 

See more on [Documentation](#documentation)

# Instalation
// To do

# Documentation
// To do

# Inspired
You might find some of this approach on commom Swift blogs, or articles sharing plataforms that I frequently read, but no specific source was follow:

- [swiftbysundell](https://www.swiftbysundell.com)
- [raywenderlich](https://www.raywenderlich.com)
- [medium](https://medium.com)

