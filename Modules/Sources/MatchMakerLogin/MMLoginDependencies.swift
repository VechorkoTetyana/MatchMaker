import Foundation
import MatchMakerAuthentication

public protocol MMLoginDependencies {
    var authService: AuthService { get }
}

