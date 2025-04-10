
import SwiftUI

struct OnboardingView: View {
    @State private var currentStep: OnboardingStep = .first
    var body: some View {
        ZStack {
            HStack(spacing: 4) {
                ForEach(0..<(OnboardingStep.allCases.count + 1), id: \.self) { index in
                    if index == currentStep.rawValue {
                        Rectangle()
                            .frame(width: 28, height: 5)
                            .clipShape(RoundedRectangle(cornerRadius: 24))
                            .foregroundColor(.white)
                    } else {
                        Circle()
                            .frame(width: 5, height: 5)
                            .foregroundColor(Color(red: 138, green: 139, blue: 147).opacity(1))
                    }
                }
            }
        }
    }
}

#Preview {
    OnboardingView()
}
