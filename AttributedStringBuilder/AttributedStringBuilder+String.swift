import Foundation

// MARK: Accessibility to Attributed Builder

extension String {
    var attributedBuilder: StaticAttributedBuilder {
        .init(text: self)
    }

    func withAttributes(builder: AttributedBuilder) -> NSAttributedString {
        builder.build(with: self)
    }

    func style(_ styleClosure: (StaticAttributedBuilder) -> Void) -> NSAttributedString {
        let builder = attributedBuilder
        styleClosure(builder)
        return builder.build()
    }
}
