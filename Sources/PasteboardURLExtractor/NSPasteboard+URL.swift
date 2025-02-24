// The Swift Programming Language
// https://docs.swift.org/swift-book

import AppKit

/*
 
 guard let stringInPasteboard  = NSPasteboard.general.string(forType: .URL) else { return }
 Task { @MainActor in
     NotificationCenter.default.post(name: .userChosePasteSkeetButton, object: stringInPasteboard)
 }

 var hasValidBlueskyPost: Bool {
     let pasteboard = NSPasteboard.general
     
     guard nil != pasteboard.availableType(from: [.URL]),
           let string = pasteboard.string(forType: .URL),
           let url = URL(string: string),
           url.isBlueSkyURL,
           url.isBlueSkyPost
     else { return false }

     return true
 }

 */

extension NSPasteboard {
   public  var url: URL? {
        let out: URL? =
        if let url = string(forType: .string) {
            URL(string: url)
        }
        else if let url = string(forType: .URL) {
            URL(string: url)
        }
        else {
            nil
        }

        guard nil != out?.scheme else { return nil }
        
        return out
    }
}
