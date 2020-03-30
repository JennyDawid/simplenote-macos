import XCTest
@testable import Simplenote


// MARK: - NSMutableAttributedString Tests
//
class NSMutableAttributedStringTests: XCTestCase {

    /// Verifies that `replaceCharacters(in:string:undoManager:)` replaces the receiver's characters with the specified String, and
    /// registers the inverse OP in the specified UndoManager.
    ///
    func testReplaceCharactersWithStringEffectivelyRegistersTheInverseOperationInUndoManager() {
        let initialPrefix = "A lala lala "
        let initialTail = "le long long long"
        let initialText = initialPrefix + initialTail

        let replacementText = "long long "
        let replacementRange = NSRange(location: initialPrefix.utf16.count, length: .zero)

        let expectedText = "A lala lala long long le long long long"

        let undoManager = UndoManager()
        let sample = NSMutableAttributedString(string: initialText)

        XCTAssertFalse(undoManager.canUndo)
        sample.replaceCharacters(in: replacementRange, string: replacementText, undoManager: undoManager)

        XCTAssertEqual(sample.string, expectedText)
        XCTAssertTrue(undoManager.canUndo)

        undoManager.undo()
        XCTAssertEqual(sample.string, initialText)
    }

    /// Verifies that `replaceCharacters(in:attrString:undoManager:)` replaces the receiver's characters with the specified String, and
    /// registers the inverse OP in the specified UndoManager.
    ///
    func testReplaceCharactersWithAttributedStringEffectivelyRegistersTheInverseOperationInUndoManager() {
        let initialPrefix = "A lala lala "
        let initialTail = " le long long long"
        let initialText = initialPrefix + initialTail

        let replacementAttach = SPTextAttachment()
        let replacementText = NSAttributedString(attachment: replacementAttach)
        let replacementRange = NSRange(location: initialPrefix.utf16.count, length: .zero)

        let expectedText = "A lala lala " + String.attachmentString +  " le long long long"

        let undoManager = UndoManager()
        let sample = NSMutableAttributedString(string: initialText)

        XCTAssertFalse(undoManager.canUndo)
        sample.replaceCharacters(in: replacementRange, attrString: replacementText, undoManager: undoManager)

        XCTAssertEqual(sample.string, expectedText)
        XCTAssertTrue(undoManager.canUndo)

        undoManager.undo()
        XCTAssertEqual(sample.string, initialText)
    }
}
