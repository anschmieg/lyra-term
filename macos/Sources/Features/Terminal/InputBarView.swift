import SwiftUI

struct InputBarView: View {
    @State private var text: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
            HStack {
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .font(.system(size: 12, weight: .bold))
                
                TextField("Type a command...", text: $text)
                    .textFieldStyle(.plain)
                    .font(.system(.body, design: .monospaced))
                    .onSubmit {
                        print("Command submitted: \(text)")
                        text = ""
                    }
            }
            .padding(10)
            .background(Color(NSColor.windowBackgroundColor))
        }
    }
}
