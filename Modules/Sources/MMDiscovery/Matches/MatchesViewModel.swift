import Foundation
import Swinject

class MatchesViewModel {
    var matches: [User] = []
    
    init(container: Container) {}
    
    public func fetchMatches() async throws {
        matches = mockUsers
    }
}
