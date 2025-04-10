import SwiftUI
import Combine


final class AppCoordinator: ObservableObject {
    static let shared = AppCoordinator()
    
    // MARK: - Published Properties
    @Published var navigationPath = NavigationPath()
    @Published private(set) var appState: AppState = .launch {
        didSet { handleAppStateChange() }
    }
    
    @Published private(set) var currentRoute: AppRoute?
    @Published private(set) var showFullScreen = false
    
    @Published var isConnectedToInternet: Bool = true
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    // MARK: - User Defaults
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @AppStorage("hasSeenLaunch") private var hasSeenLaunch = false
    
    // MARK: - Private Properties
    private var cancellables = Set<AnyCancellable>()
    private var hasShownPaywall = false
    private var hasShownOnboardingPaywall = false
    
    private init() {
        setupInitialState()
        setupObservers()
    }
    
    private func setupInitialState() {
        appState = hasSeenLaunch
            ? (hasCompletedOnboarding ? .main : .onboarding)
            : .launch
    }
    
    private func setupObservers() {
        NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)
            .sink { [weak self] _ in
                self?.handleAppDidEnterBackground()
            }
            .store(in: &cancellables)
    }
    
    private func handleAppStateChange() {
        navigationPath.removeLast(navigationPath.count)
        if appState == .main {
            hasShownPaywall = false
        }
    }
    
    func handleAppDidEnterBackground() {
        if hasCompletedOnboarding && !hasShownPaywall {
            appState = .paywall
            hasShownPaywall = true
        }
    }
}

// MARK: - State Handlers
extension AppCoordinator {
    func completeLaunch() {
        hasSeenLaunch = true
        appState = hasCompletedOnboarding ? .main : .onboarding
    }
    
    func completeOnboarding() {
        hasCompletedOnboarding = true
        appState = .main
        hasShownOnboardingPaywall = false
    }
}

// MARK: - NavigationHandler Implementation
extension AppCoordinator: NavigationHandler {
    func navigate(to route: AppRoute) {
        guard shouldNavigate(to: route) else { return }
        
        if route == .paywall {
            updatePaywallFlags()
        }
        
        currentRoute = route
        navigationPath.append(route)
    }
    
    func navigateFullScreen(to route: AppRoute) {
        DispatchQueue.main.async {
            self.currentRoute = route
            self.showFullScreen = true
        }
    }
    
    func pop() {
        navigationPath.removeLast()
    }
    
    func popToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
    
    func shouldNavigate(to route: AppRoute) -> Bool {
        if route == .paywall {
            return !hasShownPaywall && !(appState == .onboarding && hasShownOnboardingPaywall)
        }
        return true
    }
    
    private func updatePaywallFlags() {
        hasShownPaywall = true
        if appState == .onboarding {
            hasShownOnboardingPaywall = true
        }
    }
}
