import Testing
import AppKit

@testable import PasteboardURLExtractor

@Suite("NSPasteboard+URL.url")
struct NSPasteBoard_URL {
    
    @Test("nil if no value in pasteboard")
    func nil_if_empty() {
        let sut = makeSUT()
        
        #expect(nil == sut.url)
    }
    
    @Test("If there's an URL in the pasteboard as type .string, then return that")
    func url_in_pasteboard_for_type_STRING_as_string() async throws {
        let sut = makeSUT()
        
        let expected = URL(string:"http://hi")!
        sut.setString(expected.absoluteString, forType: .string)
        
        #expect(expected == sut.url)
    }
    
    // MARK: - Administrative
    
    @Test("Ensure that SUT works as expected") func isNilIfPasteboardIsEmpty() async throws {
        let sut = makeSUT()
        let expected = "hello"
        
        sut.setString(expected, forType: .string)
        
        #expect(expected == sut.string(forType: .string))
        
        sut.clearContents()
        
        #expect(nil == sut.string(forType: .string))
    }
    
    // MARK: - Helpers

    private func makeSUT() -> NSPasteboard {
        let out = NSPasteboard(name: .init(UUID().uuidString))
        out.clearContents()
        
        return out
    }
}
