import SwiftUI

/// A scheme in a starting-point gallery: its sidebar as the tile, choosing
/// it gives the Space that sidebar.
struct BrowserSpaceSchemeChoice: View {
    let scheme: SpaceScheme
    @Binding var branding: SpaceBranding
    var tint: Color = CrestBrandTheme.accent

    var body: some View {
        BrowserCrestStudioChoice(title: scheme.title, selected: scheme.isWorn(by: branding), tint: tint) {
            branding = scheme.applying(to: branding)
        } artwork: {
            BrowserSpaceBannerBackground(branding: scheme.look)
                .frame(width: 56, height: 48)
                .clipShape(.rect(cornerRadius: 8))
        }
    }
}
