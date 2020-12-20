import Foundation
import UIKit

/**
An attributed string builder that requires a string to be initialized.
The initial string cannot be changed afterwards.

Provides a builder structure that allows to configure the style of a simple text.

**Example:**
~~~
let builder = StaticAttributedBuilder(text: "Hello world")
builder.color(text: .red).letterSpacing(2)
let attributedText = builder.build()

// Direct access from String

let attributedText = "Hello world"
 .attributedBuilder
 .color(text: .red)
 .build()

// (Preferable)
// Direct access from String with closure

let attributedText = "Hello world".style { builder in
    builder
      .color(text: .red)
      .font(style: typestack.label.one)
 }

~~~
*/
final class StaticAttributedBuilder: BaseAttributedBuilder {
    // MARK: Properties

    private let text: String

    // MARK: Lifecycle

    init(text: String) {
        self.text = text
        super.init()
    }

    private init(with prototype: StaticAttributedBuilder) {
        self.text = prototype.text
        super.init(prototype)
    }

    // MARK: Methods

    func build() -> NSAttributedString {
        build(text)
    }

    func copy() -> Self {
        .init(with: self)
    }
}

/**
An attributed string builder that can build many strings.

 The string is provider through `build(with:)` method

Provides a builder structure that allows to configure the style of a simple text.

**Example:**
~~~
let builder = AttributedBuilder()
builder.color(text: .red)
let attributedText1 = builder.build(text: "Hello world")
builder.letterSpacing(2)
let attributedText2 = builder.build(text: "Hello world")

// Direct access from String

let builder = AttributedBuilder()
builder.color(text: .red)
let attributedText1 = "Hello".withAttributes(builder: builder)
builder.letterSpacing(2)
let attributedText2 = "world".withAttributes(builder: builder)
~~~
*/
final class AttributedBuilder: BaseAttributedBuilder {
    // MARK: Lifecycle

    override init() {
        super.init()
    }

    private init(with prototype: BaseAttributedBuilder) {
        super.init(prototype)
    }

    // MARK: Methods

    func build(with text: String) -> NSAttributedString {
        build(text)
    }

    func copy() -> Self {
        .init(with: self)
    }
}

/**
This is a base class for the two Builders publicly provided. This should not be directly called.

For that reason, this class have a fileprive init method to prevent in code initialization.
This behaves as a commom storage for the Builders, and a provider of all building methods.


**NOTE:**

 This struct does not prevent from calling twice (or more) the same building method.
 If a building method is called more than once, only the last call will take effect when building the attributed text.

*/
class BaseAttributedBuilder {
    private var isParagraphStyleModified: Bool = false

    private var isUppercased: Bool = false
    private var textColor: UIColor?
    private var shadowColor: UIColor?
    private var shadowOffset: CGSize?
    private var shadowBlurRadius: CGFloat?
    private var shadow: NSShadow? {
        guard
            let shadowOffset = shadowOffset,
            let shadowBlurRadius = shadowBlurRadius else {
            return nil
        }

        let shadow = NSShadow()
        shadow.shadowOffset = shadowOffset
        shadow.shadowBlurRadius = shadowBlurRadius
        shadow.shadowColor = shadowColor
        return shadow
    }

    private var backgroundColor: UIColor?
    private var strikethroughColor: UIColor?
    private var underlineColor: UIColor?
    private var letterSpacing: CGFloat?
    private var strikethroughStyle: NSUnderlineStyle?
    private var underlineStyle: NSUnderlineStyle?
    private var font: UIFont?
    private var baselineOffset: CGFloat?

    private var textAlignment: NSTextAlignment? {
        didSet { isParagraphStyleModified = true }
    }
    private var lineBreakMode: NSLineBreakMode? {
        didSet { isParagraphStyleModified = true }
    }
    private var minimumLineHeight: CGFloat? {
        didSet { isParagraphStyleModified = true }
    }
    private var maximumLineHeight: CGFloat? {
        didSet { isParagraphStyleModified = true }
    }
    private var lineSpacing: CGFloat? {
        didSet { isParagraphStyleModified = true }
    }

    fileprivate init() {}

    fileprivate init(_ prototype: BaseAttributedBuilder) {
        isParagraphStyleModified = prototype.isParagraphStyleModified
        isUppercased = prototype.isUppercased
        textColor = prototype.textColor
        shadowColor = prototype.shadowColor
        shadowOffset = prototype.shadowOffset
        shadowBlurRadius = prototype.shadowBlurRadius
        backgroundColor = prototype.backgroundColor
        strikethroughColor = prototype.strikethroughColor
        underlineColor = prototype.underlineColor
        letterSpacing = prototype.letterSpacing
        strikethroughStyle = prototype.strikethroughStyle
        underlineStyle = prototype.underlineStyle
        font = prototype.font
        baselineOffset = prototype.baselineOffset
    }
}

// MARK: Public building methods

extension BaseAttributedBuilder {
    @discardableResult
    func color(text textColor: UIColor) -> Self {
        self.textColor = textColor
        return self
    }

    @discardableResult
    func color(background backgroundColor: UIColor) -> Self {
        self.backgroundColor = backgroundColor
        return self
    }

    @discardableResult
    func color(strikethrough strikethroughColor: UIColor) -> Self {
        self.strikethroughColor = strikethroughColor
        return self
    }

    @discardableResult
    func color(underline underlineColor: UIColor) -> Self {
        self.underlineColor = underlineColor
        return self
    }

    @discardableResult
    func letterSpacing(_ letterSpacing: CGFloat) -> Self {
        self.letterSpacing = letterSpacing
        return self
    }

    @discardableResult
    func style(strikethrough strikethroughStyle: NSUnderlineStyle) -> Self {
        self.strikethroughStyle = strikethroughStyle
        return self
    }

    @discardableResult
    func style(strikethrough strikethroughSize: Int) -> Self {
        style(strikethrough: NSUnderlineStyle(rawValue: strikethroughSize))
    }

    @discardableResult
    func style(underline underlineStyle: NSUnderlineStyle) -> Self {
        self.underlineStyle = underlineStyle
        return self
    }

    @discardableResult
    func style(underline underlineSize: Int) -> Self {
        style(underline: NSUnderlineStyle(rawValue: underlineSize))
    }

    @discardableResult
    func style(uppercased isUppercased: Bool) -> Self {
        self.isUppercased = isUppercased
        return self
    }

    @discardableResult
    func font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }

    @discardableResult
    func textAlignment(_ textAlignment: NSTextAlignment) -> Self {
        self.textAlignment = textAlignment
        return self
    }

    @discardableResult
    func shadow(offset: CGSize, blurRadius: CGFloat) -> Self {
        self.shadowOffset = offset
        self.shadowBlurRadius = blurRadius
        return self
    }

    @discardableResult
    func color(shadow shadowColor: UIColor) -> Self {
        self.shadowColor = shadowColor
        return self
    }

    @discardableResult
    func line(breakMode lineBreakMode: NSLineBreakMode) -> Self {
        self.lineBreakMode = lineBreakMode
        return self
    }

    @discardableResult
    func line(minimumHeight minimumLineHeight: CGFloat) -> Self {
        self.minimumLineHeight = minimumLineHeight
        return self
    }

    /// Be careful when using maximumHeight property with Dynamic Fonts as they can grow in size.
    @discardableResult
    func line(maximumHeight maximumLineHeight: CGFloat) -> Self {
        self.maximumLineHeight = maximumLineHeight
        return self
    }

    /// "Leading": distance between the bottom of one line fragment and top of next (applied between lines in the same container). This value is included in the line fragment heights in layout manager.
    @discardableResult
    func line(space lineSpacing: CGFloat) -> Self {
        self.lineSpacing = lineSpacing
        return self
    }

    /// Floating point value, in points; Offset from baseline.
    @discardableResult
    func line(baseOffset baselineOffset: CGFloat) -> Self {
        self.baselineOffset = baselineOffset
        return self
    }
}

// MARK: Fileprivate construtor methods

fileprivate extension BaseAttributedBuilder {
    func build(_ text: String) -> NSAttributedString {
        let text = isUppercased ? text.uppercased() : text
        let mutableSelf = NSMutableAttributedString(string: text)
        let range = NSRange(location: 0, length: text.count)

        if let letterSpacing = letterSpacing {
            mutableSelf.addAttribute(.kern, value: letterSpacing, range: range)
        }

        if let textColor = textColor {
            mutableSelf.addAttribute(.foregroundColor, value: textColor, range: range)
        }

        if let backgroundColor = backgroundColor {
            mutableSelf.addAttribute(.backgroundColor, value: backgroundColor, range: range)
        }

        if let shadow = shadow {
            mutableSelf.addAttribute(.shadow, value: shadow, range: range)
        }

        if let strikethroughStyle = strikethroughStyle {
            mutableSelf.addAttribute(.strikethroughStyle, value: strikethroughStyle.rawValue, range: range)
        }

        if let strikethroughColor = strikethroughColor {
            mutableSelf.addAttribute(.strikethroughColor, value: strikethroughColor, range: range)
        }

        if let underlineStyle = underlineStyle {
            mutableSelf.addAttribute(.underlineStyle, value: underlineStyle.rawValue, range: range)
        }

        if let underlineColor = underlineColor {
            mutableSelf.addAttribute(.underlineColor, value: underlineColor, range: range)
        }

        if let font = font {
            mutableSelf.addAttribute(.font, value: font, range: range)
        }

        if let baselineOffset = baselineOffset {
            mutableSelf.addAttribute(.baselineOffset, value: baselineOffset, range: range)
        }

        if isParagraphStyleModified {
            let paragraphStyle = makeParagraphStyle()
            mutableSelf.addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
        }

        return mutableSelf
    }

    func makeParagraphStyle() -> NSMutableParagraphStyle {
        let paragraphStyle = NSMutableParagraphStyle()

        if let textAlignment = textAlignment {
            paragraphStyle.alignment = textAlignment
        }

        if let lineBreakMode = lineBreakMode {
            paragraphStyle.lineBreakMode = lineBreakMode
        }

        if let minimumLineHeight = minimumLineHeight {
            paragraphStyle.minimumLineHeight = minimumLineHeight
        }

        if let maximumLineHeight = maximumLineHeight {
            paragraphStyle.maximumLineHeight = maximumLineHeight
        }

        if let lineSpacing = lineSpacing {
            paragraphStyle.lineSpacing = lineSpacing
        }

        return paragraphStyle
    }
}

// MARK: Equatable protocol conformance

extension StaticAttributedBuilder {
    static func == (lhs: StaticAttributedBuilder, rhs: StaticAttributedBuilder) -> Bool {
        lhs.text == rhs.text && lhs as BaseAttributedBuilder == rhs as BaseAttributedBuilder
    }
}

extension BaseAttributedBuilder: Equatable {
    static func == (lhs: BaseAttributedBuilder, rhs: BaseAttributedBuilder) -> Bool {
        lhs.isParagraphStyleModified == rhs.isParagraphStyleModified &&
            lhs.isUppercased == rhs.isUppercased &&
            lhs.textColor == rhs.textColor &&
            lhs.shadowColor == rhs.shadowColor &&
            lhs.shadowOffset == rhs.shadowOffset &&
            lhs.shadowBlurRadius == rhs.shadowBlurRadius &&
            lhs.backgroundColor == rhs.backgroundColor &&
            lhs.strikethroughColor == rhs.strikethroughColor &&
            lhs.underlineColor == rhs.underlineColor &&
            lhs.letterSpacing == rhs.letterSpacing &&
            lhs.strikethroughStyle == rhs.strikethroughStyle &&
            lhs.underlineStyle == rhs.underlineStyle &&
            lhs.font == rhs.font &&
            lhs.baselineOffset == rhs.baselineOffset
    }
}
