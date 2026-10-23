import SwiftUI

/// A Space's look as a window draws it: its own colors, or plain neutral
/// chrome when the device turns Space colors off; as chosen in light, and in
/// dark over a charcoal base tinted with those colors, with text that reads
/// over it.
extension SpaceBranding {
    // MARK: - Variables

    /// This look as the windows' appearance shows it now.
    @MainActor
    var shown: SpaceBranding {
        let appearance = BrowserDeviceAppearanceStore.shared
        return (appearance.usesSpaceColors ? self : withoutColors).appearing(in: appearance.shownColorScheme)
    }

    /// The accent selected tabs, pins and the address field draw with now:
    /// the Space's own, kept vivid in dark, or a neutral gray when the window
    /// ignores Space colors.
    @MainActor
    var shownAccent: BrandColor {
        (BrowserDeviceAppearanceStore.shared.usesSpaceColors ? self : withoutColors).primaryColor
    }

    /// This look without its colors: one plain neutral gray, without pattern,
    /// gradient, texture or fade, and text in whichever tone reads over it.
    var withoutColors: SpaceBranding {
        var look = self
        look.colors = ColorPalette(colors: [.neutralChrome, .neutralChrome, .neutralChrome])
        look.bannerPattern = .solid
        look.themeMode = .banner
        look.bannerStrength = 1
        look.readabilityFade = 0
        look.showsTexture = false
        look.textColorMode = .automatic
        return look
    }

    // MARK: - Actions - Appearance

    /// This look drawn in `colorScheme`. Dark keeps each color's hue and
    /// darkens it to a charcoal already dark enough to read over, so it draws
    /// without the readability fade, and works its text tone out from the
    /// darkened colors, so a text color chosen for the light look never draws
    /// dark on dark.
    func appearing(in colorScheme: ColorScheme) -> SpaceBranding {
        guard colorScheme == .dark else { return self }
        var look = self
        look.colors = ColorPalette(colors: colors.map(\.darkAppearance))
        look.readabilityFade = 0
        look.textColorMode = .automatic
        return look
    }
}
