import Foundation

struct OnboardingModel {
    var title: LocalizedStringResource
    var subtitle: LocalizedStringResource
    var subtitle2: LocalizedStringResource
    var image: String
}

enum OnboardingStep: Int, CaseIterable {
    case first
    case second
    case third
    case fourth

    var model: OnboardingModel {
        switch self {
        case .first:
            return OnboardingModel(
                title: "ONE APP.",
                subtitle: "SEVERAL AI MODELS",
                subtitle2: "Сhoose the appropriate AI and create any queries",
                image: "Onboarding1"
            )
        case .second:
            return OnboardingModel(
                title: "ASK THE AI",
                subtitle: "ABOUT ANYTHING",
                subtitle2: "Ask questions and get answers in any language",
                image: "Onboarding2"
            )
        case .third:
            return OnboardingModel(
                title: "AI IMAGE",
                subtitle: "GENERATOR",
                subtitle2: "Transport text into AI-Powered paintings in second 15+ styles",
                image: "Onboarding3"
            )
        case .fourth:
            return OnboardingModel(
                title: "SUMMARIZE",
                subtitle: "YOUTUBE VIDEO",
                subtitle2: "Concise insights from YouTube video content",
                image: "Onboarding4"
            )
        }
    }
}
