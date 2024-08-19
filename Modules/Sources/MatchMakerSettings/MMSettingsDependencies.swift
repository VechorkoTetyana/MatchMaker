import Foundation
import MatchMakerAuthentication

public protocol MMSettingsDependencies {
    var authService: AuthService { get }
    var userRepository: UserProfileRepository { get }
    var profilePictureRepository: ProfilePictureRepository { get }
    
}
