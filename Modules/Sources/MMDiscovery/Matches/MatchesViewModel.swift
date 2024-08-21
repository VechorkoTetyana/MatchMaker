import Foundation
import Swinject

class MatchesViewModel {
    
    private let repository: MatchesRepository
    var matches: [User] = []
    
    init(container: Container) {
        repository = container.resolve(MatchesRepository.self)!
    }
    
    public func fetchMatches() async throws {
//      matches = mockUsers
        matches = try await repository.fetchMatches()

    }
}
