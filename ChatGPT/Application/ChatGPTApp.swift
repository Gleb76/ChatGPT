
import SwiftUI

@main
struct ChatGPTApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(AppCoordinator.shared)
        }
    }
}
