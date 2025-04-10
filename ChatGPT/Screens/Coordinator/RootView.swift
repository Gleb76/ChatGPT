
import SwiftUI

struct RootView: View {
    @EnvironmentObject private var coordinator: AppCoordinator
    @Environment(\.scenePhase) private var scenePhase

    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            ZStack {
                switch coordinator.appState {
                case .launch:
                    LaunchView()
                case .onboarding:
                    OnboardingView()
                case .main:
                    TabBarView()
                case .paywall:
                    PaywallView()
                }
            }
            .navigationDestination(for: AppRoute.self) { route in
                route.destination
                    .environmentObject(coordinator)
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .background {
                coordinator.handleAppDidEnterBackground()
            }
        }
        .animation(.default, value: coordinator.appState)
        .transition(.opacity)
    }
}
