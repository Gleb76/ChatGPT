
import SwiftUI

protocol NavigationHandler: AnyObject {
    var navigationPath: NavigationPath { get }
    var currentRoute: AppRoute? { get }
    var showFullScreen: Bool { get }
    
    func navigate(to route: AppRoute)
    func navigateFullScreen(to route: AppRoute)
    func pop()
    func popToRoot()
}
