import SwiftUI

struct InputBarView: View {
    var surface: Ghostty.SurfaceView?
    @State private var text: String = ""
    @State private var isFocused: Bool = false
    @State private var inputHeight: CGFloat = 20
    @State private var isAiMode: Bool = false
    @FocusState private var isInputFocused: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
                .background(Color.gray.opacity(0.2))
            
            HStack(alignment: .bottom, spacing: 12) {
                // AI Mode Toggle
                Button(action: {
                    isAiMode.toggle()
                    // Sync with shell
                    let cmd = isAiMode ? "lyra-on" : "lyra-off"
                    surface?.sendText(cmd)
                    surface?.sendAction("\r")
                }) {
                    Image(systemName: "sparkles")
                        .font(.system(size: 16))
                        .foregroundColor(isAiMode ? .purple : .secondary)
                }
                .buttonStyle(.plain)
                .keyboardShortcut("i", modifiers: .command) // Cmd+I to toggle
                .padding(.bottom, 14) // Align with text baseline roughly

                // Native Input Field
                ZStack(alignment: .leading) {
                    if text.isEmpty {
                        Text(isAiMode ? "Ask Lyra..." : "Type a command...")
                            .font(.system(size: 14, weight: .medium, design: .monospaced))
                            .foregroundColor(Color(NSColor.placeholderTextColor))
                            .padding(.leading, 4)
                            .allowsHitTesting(false)
                    }
                    
                    CodeEditor(text: $text, dynamicHeight: $inputHeight, onSubmit: {
                        print("Command submitted: \(text)")
                        surface?.sendText(text)
                        surface?.sendAction("\r")
                        text = ""
                    })
                    .focused($isInputFocused)
                    .frame(height: min(max(inputHeight, 20), 200))
                }
                .padding(.vertical, 12)
            }
            .padding(.horizontal, 16)
            .background(Color(NSColor.windowBackgroundColor))
            .onAppear {
                // Auto-focus input when view appears
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    isInputFocused = true
                }
            }
        }
    }
}
