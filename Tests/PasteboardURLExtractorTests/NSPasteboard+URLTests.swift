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

    @Test("If there's an URL in the pasteboard as type .URL, then return that")
    func url_in_pasteboard_for_type_URL_as_string() async throws {
        let sut = makeSUT()
        
        let expected = URL(string:"http://hi")!
        sut.setString(expected.absoluteString, forType: .URL)
        
        #expect(expected == sut.url)
    }

    @Test("If there's an URL in the pasteboard as type .string, then return that")
    func url_in_pasteboard_for_type_STRING_as_string() async throws {
        let sut = makeSUT()
        
        let expected = URL(string:"http://www.hello.com")!
        sut.setString(expected.absoluteString, forType: .string)
        
        #expect(expected == sut.url)
    }
    
    @Test("If there's an URL in the pasteboard as type .string, set as Data, then return that")
    func url_in_pasteboard_for_type_STRING_as_data() async throws {
        let sut = makeSUT()
        
        let expected = URL(string:"http://hi")!
        let data = expected.absoluteString.data(using: .utf8)
        sut.setData(data, forType: .string)
        
        #expect(expected == sut.url)
    }

    @Test("If there's an URL in the pasteboard as type .URL, set as Data, then return that")
    func url_in_pasteboard_for_type_URL_as_data() async throws {
        let sut = makeSUT()
        
        let expected = URL(string:"http://hi")!
        let data = expected.absoluteString.data(using: .utf8)
        sut.setData(data, forType: .URL)
        
        #expect(expected == sut.url)
    }

    @Test("If there's an URL in the pasteboard as type .URL, set as Data, then return that")
    func url_in_pasteboard_for_type_URL_as_data2() async throws {
        let sut = makeSUT()
        
        let expected = URL(string:"http://hi")!
        let data = expected.dataRepresentation
        sut.setData(data, forType: .URL)
        
        #expect(expected == sut.url)
    }

    @Test("if URL is not a valid URL, returns nil")
    func returns_nil_for_string_that_is_URL_without_scheme() {
        let sut = makeSUT()
        
        sut.setString("hello", forType: .string)
        
        #expect(nil == sut.url)
    }
        
    @Test("if URL is not a valid URL, returns nil")
    func returns_nil_for_string_that_is_URL_without_scheme_as_URL() {
        let sut = makeSUT()

        sut.setString("hello", forType: .URL)

        #expect(nil == sut.url)
    }

    @Test("ignores anything in pasteboard set as type .fileURL", arguments: [
        "/",
        "~",
        "/Users",
        "/bin",
        "/etc",
        "/Users/me/Documents/readme.txt",
        "hello",
        "file:///",
        "http://hello"
    ])
    func returns_nil_for_fileURL(_ string: String) {
        let sut = makeSUT()

        sut.setString(string, forType: .fileURL)

        #expect(nil == sut.url)
    }

    @Test("ignores any string in pasteboard that has a URL in its contents but is not completely a URL",
          arguments: [
            " http://hello",
            "My favorite website is http://hello.com",
            "My favorite website is http://hello.com because it's awesome",
            "http://www.hello.com is my favoriate website"          ])
    func returns_nil_for_URL_in_string(_ string: String) {
        let sut = makeSUT()

        sut.setString(string, forType: .string)

        #expect(nil == sut.url)
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
