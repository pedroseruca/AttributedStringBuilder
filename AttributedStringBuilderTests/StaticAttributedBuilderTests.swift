import XCTest
@testable import AttributedStringBuilder

final class StaticAttributedBuilderTests: XCTestCase {
    private let baseString = "Hello World"
    private lazy var baseAttributedString = NSAttributedString(string: baseString)

    func test_build() {
        let builder = StaticAttributedBuilder(text: baseString)
        let attributedString = builder.build()

        XCTAssert(baseAttributedString == attributedString)
    }

    func test_copy() {
        let builder = StaticAttributedBuilder(text: baseString)

        let builderCopy = builder.copy()


        XCTAssertFalse(builder === builderCopy)
        XCTAssert(builder == builderCopy)
    }

    func test_copy_with_attributes() {
        let builder = StaticAttributedBuilder(text: baseString)
        builder
            .color(background: .red)
            .line(space: 10)

        let builderCopy = builder.copy()
        builderCopy
            .color(background: .red)
            .line(space: 10)

        XCTAssertFalse(builder === builderCopy)
        XCTAssert(builder == builderCopy)

        let attributedString1 = builder.build()
        let attributedString2 = builderCopy.build()
        XCTAssertFalse(attributedString1 === attributedString2)
        XCTAssert(attributedString1 == attributedString2)
    }

    func test_copy_with_differentAttributes() {
        let builder = StaticAttributedBuilder(text: baseString)
            .color(background: .red)
            .line(space: 10)

        let builderCopy = builder.copy()
            .color(background: .black)
            .line(space: 5)

        XCTAssertFalse(builder === builderCopy)
        XCTAssertFalse(builder == builderCopy)

        let attributedString1 = builder.build()
        let attributedString2 = builderCopy.build()
        XCTAssertFalse(attributedString1 === attributedString2)
        XCTAssertFalse(attributedString1 == attributedString2)
    }

}

