import Foundation
import MatchMakerAuthentication
import MMDiscovery
import MatchMakerLogin
import MatchMakerSettings
import Swinject

final class Assembly {
    
   private let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    func assemble() {
        let authService = AuthServiceLive()
        let userProfileRepository = UserProfileRepositoryLive(authService: authService)
            
        let profilePictureRepository = ProfilePictureRepositoryLive(
            authService: authService,
            userProfileRepository: userProfileRepository
        )
        
        container.register(AuthService.self) { container in
            authService
        }
        
        container.register(UserProfileRepository.self) { container in
            userProfileRepository
        }
        
        container.register(ProfilePictureRepository.self) { container in
            profilePictureRepository
        }
        
        container.register(DiscoveryRepository.self) { _ in
            DiscoveryRepositoryLive(authService: authService)
        }
        
        container.register(MatchesRepository.self) { _ in
            MatchesRepositoryLive(authService: authService)
        }
        
//        let authServiceFromContainer = container.resolve(authService.self)!
    }
}

/*
 let authService = AuthServiceLive()
 
 let profilePictureRepository = ProfilePictureRepositoryLive(authService: authService)
 
 settings.viewModel = SettingsViewModel(
     authService: authService,
     userProfileRepository: profilePictureRepository,
     
     profilePictureRepository: ProfilePictureRepositoryLive(
     authService: authService,
     userProfileRepository: profilePictureRepository
     )
 )
                 
 
 */
