import SwiftUI
import AppKit

struct CodeEditor: NSViewRepresentable {
    @Binding var text: String
    @Binding var dynamicHeight: CGFloat
    var onSubmit: () -> Void
    
    func makeNSView(context: Context) -> NSScrollView {
        let scrollView = NSScrollView()
        scrollView.drawsBackground = false
        scrollView.borderType = .noBorder
        scrollView.hasVerticalScroller = false
        scrollView.hasHorizontalScroller = false
        
        let textView = EditorTextView()
        textView.delegate = context.coordinator
        textView.onSubmit = onSubmit
        textView.isRichText = false
        textView.font = .monospacedSystemFont(ofSize: 14, weight: .medium)
        textView.backgroundColor = .clear
        textView.drawsBackground = false
        textView.isVerticallyResizable = true
        textView.isHorizontallyResizable = false
        textView.textContainer?.widthTracksTextView = true
        textView.textContainerInset = NSSize(width: 0, height: 0)
        
        // Remove default padding
        textView.textContainer?.lineFragmentPadding = 0
        
        scrollView.documentView = textView
        return scrollView
    }
    
    func updateNSView(_ nsView: NSScrollView, context: Context) {
        guard let textView = nsView.documentView as? EditorTextView else { return }
        
        // Update the submit handler to capture the latest state
        textView.onSubmit = onSubmit
        
        if textView.string != text {
            textView.string = text
            // Force layout update to calculate height
            context.coordinator.updateHeight(textView)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, NSTextViewDelegate {
        var parent: CodeEditor
        
        init(_ parent: CodeEditor) {
            self.parent = parent
        }
        
        func textDidChange(_ notification: Notification) {
            guard let textView = notification.object as? EditorTextView else { return }
            parent.text = textView.string
            updateHeight(textView)
        }
        
        func updateHeight(_ textView: NSTextView) {
            guard let layoutManager = textView.layoutManager,
                  let textContainer = textView.textContainer else { return }
            
            layoutManager.ensureLayout(for: textContainer)
            let usedRect = layoutManager.usedRect(for: textContainer)
            
            // Add a little buffer for cursor and line height
            let newHeight = max(20, usedRect.height)
            
            DispatchQueue.main.async {
                if self.parent.dynamicHeight != newHeight {
                    self.parent.dynamicHeight = newHeight
                }
            }
        }
    }
}

class EditorTextView: NSTextView {
    var onSubmit: (() -> Void)?
    
    // Disable standard focus ring
    override var focusRingType: NSFocusRingType {
        get { .none }
        set { }
    }
    
    override func keyDown(with event: NSEvent) {
        if event.keyCode == 36 { // Enter
            if event.modifierFlags.contains(.shift) {
                // Shift+Enter: Insert newline
                super.insertNewline(nil)
            } else {
                // Enter: Submit
                onSubmit?()
            }
        } else {
            super.keyDown(with: event)
        }
    }
}
