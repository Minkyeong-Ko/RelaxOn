//
//  RectPreference.swift
//  RelaxOn
//
//  Created by 김연호 on 2022/07/23.
//

import SwiftUI

/// PreferenceKey for a subview to notify superview of its size
struct SizePreferenceKey: PreferenceKey {
    public typealias Value = CGSize
    public static var defaultValue: Value = .zero

    public static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

struct BackgroundGeometryReader: View {
    public var body: some View {
        GeometryReader { geometry in
            return Color
                    .clear
                    .preference(key: SizePreferenceKey.self, value: geometry.size)
        }
    }
}

/// A helper ViewModifier to attach to the subview that encapsulates the PreferenceKey
public struct SizeAwareViewModifier: ViewModifier {

    @Binding private var viewSize: CGSize

    public init(viewSize: Binding<CGSize>) {
        self._viewSize = viewSize
    }

    public func body(content: Content) -> some View {
        content
            .background(BackgroundGeometryReader())
            .onPreferenceChange(SizePreferenceKey.self) {
                self.viewSize = $0
            }
    }
}
