#if os(macOS)
import AppKit
import SwiftUI

/// A view that renders text with proper link cursor behavior on macOS.
/// Uses NSTextView under the hood to get native link hover cursor support.
struct LinkAwareText: NSViewRepresentable {
  let attributedString: AttributedString

  func makeNSView(context: Context) -> NSTextView {
    let textView = NSTextView()
    textView.isEditable = false
    textView.isSelectable = true
    textView.drawsBackground = false
    textView.backgroundColor = .clear
    textView.textContainerInset = .zero
    textView.textContainer?.lineFragmentPadding = 0
    textView.isAutomaticLinkDetectionEnabled = false

    // Allow the text view to shrink and grow with content
    textView.setContentHuggingPriority(.defaultHigh, for: .vertical)
    textView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

    return textView
  }

  func updateNSView(_ textView: NSTextView, context: Context) {
    let nsAttributedString = NSAttributedString(attributedString)
    textView.textStorage?.setAttributedString(nsAttributedString)

    // Ensure proper sizing
    textView.invalidateIntrinsicContentSize()
  }
}
#endif
