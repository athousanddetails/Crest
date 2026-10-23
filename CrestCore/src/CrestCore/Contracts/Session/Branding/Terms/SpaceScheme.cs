namespace CrestCore.Contracts;

/// A modern look a Space can start from: another browser's sidebar, light
/// or dark with the device, under the Space's own icon, with no arms.
/// Choosing one copies its look into the Space, so a Space keeps the look it
/// was given when a scheme changes.
public sealed class SpaceScheme {
    #region Static Variables

    /// Arc's neutral sidebar: a gray laid thinly over the window's own
    /// background, which settles it near Arc's #333 by night and #E5E5E5 by
    /// day, under Arc's grain, with its icon in Arc's mid gray.
    public static readonly SpaceScheme Arc = new("arc", "Arc", SchemeLook(
        [Tincture.ArcSmoke], Tincture.ArcGray, strength: 0.15, showsTexture: true));

    public static IReadOnlyList<SpaceScheme> All { get; } = [Arc];

    #endregion

    #region Variables

    public string Name { get; }

    /// The scheme's name in the template gallery.
    [Localized]
    public string Title { get; }

    /// The look a Space starting from the scheme wears.
    public SpaceBranding Look { get; }

    #endregion

    #region Constructors

    private SpaceScheme(string name, string title, SpaceBranding look) {
        Name = name;
        Title = title;
        Look = look;
    }

    #endregion

    #region Actions - Lookup

    public static SpaceScheme? Named(string? name) => All.FirstOrDefault(scheme => scheme.Name == name);

    #endregion

    #region Actions - Looks

    /// A scheme's look: its colors as a gradient at `strength` over the
    /// window's own background, with no readability fade, its text and
    /// controls following the device's appearance, and the Space's icon in
    /// place of a crest, drawn in `symbol`.
    private static SpaceBranding SchemeLook(Tincture[] colors, Tincture symbol, double strength, bool showsTexture) =>
        new(new([.. colors.Select(tincture => tincture.Color)]), SpaceBannerPattern.Diagonal, strength, ReadabilityFade: 0,
            KeepsControlsReadable: false, SpaceThemeMode.Gradient, GradientAngle: 0, showsTexture, SpaceIconStyle.SimpleSymbol,
            symbol.Color, SpaceBranding.Neutral.Crest, SpaceBranding.BaselineRenderingVersion, FolderColorIntensity: 0,
            SpaceTextColorMode.System, HasCustomAppearance: false);

    #endregion
}
