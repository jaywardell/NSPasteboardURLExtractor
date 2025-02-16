#  PasteboardURLExtractor

This is a simple extension on NSPasteboard that adds a property that returns a valid URL if it was added to the pasteboard in a number of different ways.

Sometimes macOS will add a URL to the pasteboard as a URL, and other times it will add it as a simple string. `NSPasteboard.url` will return a URL in either case, but only if the URL is valid (ie is has a valid scheme).

