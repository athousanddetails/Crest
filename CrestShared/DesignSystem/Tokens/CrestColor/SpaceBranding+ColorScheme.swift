import SwiftUI

/// The color scheme a Space's sidebar draws its text and controls in.
extension SpaceBranding {
    // MARK: - Actions - Text

    /// The tone the Space's text reads in over a window in `appearance`.
    func foregroundTone(over appearance: ColorScheme) -> BrowserSpaceForegroundTone {
        foregroundTone(system: BrowserSpaceForegroundTone(readingIn: appearance))
    }

    /// The scheme the Space's sidebar draws in over a window in `appearance`.
    func colorScheme(over appearance: ColorScheme) -> ColorScheme {
        foregroundTone(over: appearance).colorScheme
    }
}
