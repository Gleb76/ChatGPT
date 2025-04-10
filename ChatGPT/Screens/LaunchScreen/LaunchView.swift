
import SwiftUI

struct LaunchView: View {
    @EnvironmentObject private var coordinator: AppCoordinator
    var body: some View {
        VStack {
            Image(.launch)
                .resizable()
                .frame(width: 300, height: 300)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                coordinator.completeLaunch()
            }
        }
    }
}
