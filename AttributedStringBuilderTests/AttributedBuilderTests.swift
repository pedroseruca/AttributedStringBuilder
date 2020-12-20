import XCTest
@testable import AttributedStringBuilder

final class AttributedBuilderTests: XCTestCase {
    private let baseString = "Hello World"
    private let baseString2 = "Hello Universe"
    private lazy var baseAttributedString = NSAttributedString(string: baseString)
    private lazy var baseAttributedString2 = NSAttributedString(string: baseString2)

    func test_build() {
        let builder = AttributedBuilder()
        let attributedString = builder.build(with: baseString)

        XCTAssert(baseAttributedString == attributedString)
    }

    func test_multiple_build() {
        let builder = AttributedBuilder()

        let attributedString = builder.build(with: baseString)
        XCTAssert(baseAttributedString == attributedString)

        let attributedString2 = builder.build(with: baseString2)
        XCTAssert(baseAttributedString2 == attributedString2)

        XCTAssertFalse(attributedString == attributedString2)
    }

    func test_copy() {
        let builder = AttributedBuilder()

        let builderCopy = builder.copy()


        XCTAssertFalse(builder === builderCopy)
        XCTAssert(builder == builderCopy)
    }

    func test_copy_with_attributes() {
        let builder = AttributedBuilder()
        builder
            .color(background: .red)
            .line(space: 10)

        let builderCopy = builder.copy()
        builderCopy
            .color(background: .red)
            .line(space: 10)

        XCTAssertFalse(builder === builderCopy)
        XCTAssert(builder == builderCopy)

        let attributedString1 = builder.build(with: baseString)
        let attributedString2 = builderCopy.build(with: baseString)
        XCTAssertFalse(attributedString1 === attributedString2)
        XCTAssert(attributedString1 == attributedString2)
    }

    func test_copy_with_differentAttributes() {
        let builder = AttributedBuilder()
            .color(background: .red)
            .line(space: 10)

        let builderCopy = builder.copy()
            .color(background: .black)
            .line(space: 5)

        XCTAssertFalse(builder === builderCopy)
        XCTAssertFalse(builder == builderCopy)

        let attributedString1 = builder.build(with: baseString)
        let attributedString2 = builderCopy.build(with: baseString)
        XCTAssertFalse(attributedString1 === attributedString2)
        XCTAssertFalse(attributedString1 == attributedString2)
    }

}

