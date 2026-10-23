import Foundation

/// A scheme as the starting point of a Space's look.
extension SpaceScheme {
    // MARK: - Actions - Looks

    /// `branding` wearing the scheme's sidebar: its colors, gradient, strength,
    /// fade and texture, under the Space's icon in the scheme's icon color,
    /// keeping the Space's folder choices and its crest for when it goes back
    /// to one.
    func applying(to branding: SpaceBranding) -> SpaceBranding {
        var updated = branding
        updated.colors = look.colors
        updated.themeMode = look.themeMode
        updated.bannerPattern = look.bannerPattern
        updated.gradientAngle = look.gradientAngle
        updated.bannerStrength = look.bannerStrength
        updated.readabilityFade = look.readabilityFade
        updated.showsTexture = look.showsTexture
        updated.textColorMode = look.textColorMode
        updated.iconStyle = look.iconStyle
        updated.symbolColor = look.symbolColor
        updated.crest.startingPresetID = nil
        updated.hasCustomAppearance = false
        return updated.normalized()
    }

    /// Whether `branding` still wears the scheme's sidebar unchanged.
    func isWorn(by branding: SpaceBranding) -> Bool {
        branding.hasCustomAppearance != true && branding.colors == look.colors
            && branding.themeMode == look.themeMode && branding.gradientAngle == look.gradientAngle
            && branding.showsTexture == look.showsTexture && branding.iconStyle == look.iconStyle
            && branding.symbolColor == look.symbolColor
    }
}
