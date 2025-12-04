import SwiftUI

struct InputBarView: View {
    var surface: Ghostty.SurfaceView?
    @State private var text: String = ""
    @State private var isFocused: Bool = false
    @State private var inputHeight: CGFloat = 20
    @State private var isAiMode: Bool = false
    @FocusState private var isInputFocused: Bool
    
    @State private var isInteractive: Bool = false
    
    func toggleAiMode() {
        // Toggle state first
        isAiMode.toggle()
        // Send specific command based on new state
        let cmd = isAiMode ? "lyra-on" : "lyra-off"
        print("Lyra: Toggle triggered. Sending '\(cmd)'")
        surface?.sendText(cmd)
        surface?.sendAction("\r")
    }

    var body: some View {
        VStack(spacing: 0) {
            Divider()
                .background(Color.gray.opacity(0.2))
            
            HStack(alignment: .bottom, spacing: 12) {
                // AI Mode Toggle
                Button(action: {
                    toggleAiMode()
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
                        print("Lyra: Command submitted: '\(text)'")
                        
                        // Sync UI state if user types the command manually
                        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
                        if trimmed == "lyra-on" {
                            print("Lyra: Switching to AI Mode (Manual)")
                            isAiMode = true
                        } else if trimmed == "lyra-off" {
                            print("Lyra: Switching to Shell Mode (Manual)")
                            isAiMode = false
                        }
                        
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
            // Hide the entire input bar when interactive
            .opacity(isInteractive ? 0 : 1)
            .frame(height: isInteractive ? 0 : nil)
            .clipped() // Ensure no overflow when hidden
            .onAppear {
                // Auto-focus input when view appears
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    isInputFocused = true
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("LyraToggleAIMode"))) { _ in
                toggleAiMode()
            }
            .onReceive(Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()) { _ in
                // Poll for interactive state
                if let surface = surface, let model = surface.surfaceModel {
                    let captured = model.mouseCaptured
                    let title = surface.title.lowercased()
                    let newInteractive = captured || 
                                       title.contains("less") || 
                                       title.contains("man") ||
                                       title.contains("vim") ||
                                       title.contains("nvim")
                    
                    if isInteractive != newInteractive {
                        isInteractive = newInteractive
                        // If we became interactive, lose focus so terminal can take it
                        if isInteractive {
                            isInputFocused = false
                            surface.window?.makeFirstResponder(surface)
                        } else {
                            isInputFocused = true
                        }
                    }
                }
            }
        }
    }
}
