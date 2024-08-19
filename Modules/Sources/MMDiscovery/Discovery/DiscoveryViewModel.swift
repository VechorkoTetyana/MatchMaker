import Foundation
import Swinject

public class DiscoveryViewModel {
    
    var potentialMatches: [User] = []
    
    init(container: Container) {}
    
    func fetchPotentialMatches() async throws {
//      potentialMatches = try await repository.fetchMaches
        potentialMatches = mockUsers
    }
}
