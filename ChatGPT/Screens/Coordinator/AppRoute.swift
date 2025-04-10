
import SwiftUI

enum AppRoute: Hashable {
    case main
    case paywall
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .paywall:
            PaywallView()
        case .main:
            RootView()
        }
    }
}

enum AppState {
    case launch
    case onboarding
    case paywall
    case main
}
