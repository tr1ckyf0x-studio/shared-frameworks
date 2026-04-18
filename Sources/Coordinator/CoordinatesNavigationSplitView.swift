//
//  CoordinatesNavigationSplitView.swift
//  Coordinator
//
//  Created by Vladislav Lisianskii on 18. 4. 2026.
//  Copyright © 2026 Fox Studio. All rights reserved.
//

/// Protocol for coordinators that drive a `NavigationSplitView` sidebar
/// selection on macOS (or an equivalent single-selection list on iPad).
///
/// Single-selection model. Multi-selection (`Set<SidebarItem>`) is intentionally
/// out of scope — if a consumer ever needs it, add a separate protocol rather
/// than broadening this one.
///
/// Detail-pane state (e.g. selected row in the content list) is intentionally
/// **not** part of this protocol: that state differs per feature and belongs to
/// feature-specific view models. The coordinator owns only top-level sidebar
/// selection.
///
/// Conformers can compose with `CoordinatesSheet` and `CoordinatesNavigationStack`
/// via multiple conformances.
@MainActor
public protocol CoordinatesNavigationSplitView: AnyObject {
    /// Value type representing a sidebar entry. Any `Hashable` type works;
    /// typical conformers use an enum with a case per sidebar item.
    associatedtype SidebarItem: Hashable

    /// Currently selected sidebar item, or `nil` when nothing is selected
    /// (valid macOS state — `List(selection:)` tolerates `nil`).
    var selectedSidebarItem: SidebarItem? { get set }

    /// Programmatically updates the sidebar selection.
    ///
    /// Default implementation simply assigns `item` to `selectedSidebarItem`;
    /// override only if the coordinator needs side-effects on selection change.
    func selectSidebarItem(_ item: SidebarItem?)
}

public extension CoordinatesNavigationSplitView {
    func selectSidebarItem(_ item: SidebarItem?) {
        self.selectedSidebarItem = item
    }
}
