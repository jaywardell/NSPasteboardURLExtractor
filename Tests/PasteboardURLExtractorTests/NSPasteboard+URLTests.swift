import Testing
import AppKit

@testable import PasteboardURLExtractor

@Suite("NSPasteboard+URL.url")
struct NSPasteBoard_URL {
    
    
    // MARK: - Administrative
    
    @Test("Ensure that SUT works as expected") func isNilIfPasteboardIsEmpty() async throws {
        let sut = makeSUT()
        sut.clearContents()
        let expected = "hello"
        
        sut.setString(expected, forType: .string)
        
        #expect(expected == sut.string(forType: .string))
        
        sut.clearContents()
        
        #expect(nil == sut.string(forType: .string))
    }
    
    // MARK: - Helpers

    private func makeSUT() -> NSPasteboard {
        NSPasteboard(name: .init(#function))
    }
}
