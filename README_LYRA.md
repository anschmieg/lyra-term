# LyraTerm 🌌

**LyraTerm** is a native macOS terminal emulator designed for the "Warp-like" experience:
- **Native Input Field**: Type commands in a detached, native text box.
- **High Performance**: Built on the **Ghostty** engine (Zig + Metal).
- **AI Integration**: (Coming Soon) Deep integration with Lyra AI.

## Building from Source

LyraTerm is a fork of [Ghostty](https://github.com/ghostty-org/ghostty).

### Requirements
- macOS 13.0+
- Xcode (Full installation required)
- Zig 0.15.2 (managed via `zigup` or Homebrew)

### Build Instructions

1.  **Clone the repo:**
    ```bash
    git clone https://github.com/yourusername/lyra-term.git
    cd lyra-term
    ```

2.  **Open in Xcode:**
    ```bash
    open macos/Ghostty.xcodeproj
    ```

3.  **Run:**
    Select your Development Team in Signing settings and hit **Run (Cmd+R)**.

## Credits

Based on the incredible work by the [Ghostty Team](https://github.com/ghostty-org/ghostty).
Forked by [Adrian](https://github.com/adrian).
