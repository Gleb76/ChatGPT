
import UIKit

extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let currentRoute = AppCoordinator.shared.currentRoute,
           currentRoute == .paywall {
            return false
        }
        
        return viewControllers.count > 1
    }
}
