import Foundation
import Observation

/// The downloads one window shows as cards in its corner: each one the person
/// started in that window, from its start until a moment after it ends. The
/// window takes each start once, so a card never comes back after it goes.
@Observable
@MainActor
final class BrowserMacDownloadTrayState {
    // MARK: - Static Variables

    /// How many cards show at once; an older one gives way to a newer.
    static let maximumVisible = 3

    /// How long a card stays once its download has ended.
    static let settledLifetime: Duration = .seconds(3)

    // MARK: - Variables

    /// The downloads shown, oldest first.
    private(set) var downloadIDs: [UUID] = []
    @ObservationIgnored private var adoptedIDs: Set<UUID> = []

    // MARK: - Actions - Showing

    /// Takes the starts among `events` that happened in `window`, and says
    /// whether there were any.
    @discardableResult
    func adopt(_ events: [BrowserDownloadFeedbackEvent], in window: ObjectIdentifier?) -> Bool {
        guard let window else { return false }
        let started = events.filter {
            $0.source.windowIdentifier == window && !adoptedIDs.contains($0.id)
        }
        guard !started.isEmpty else { return false }
        adoptedIDs.formUnion(started.map(\.id))
        downloadIDs = Array((downloadIDs + started.map(\.id)).suffix(Self.maximumVisible))
        return true
    }

    func dismiss(_ downloadID: UUID) {
        downloadIDs.removeAll { $0 == downloadID }
    }
}
