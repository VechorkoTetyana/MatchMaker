import Foundation
import FirebaseDatabase
import MatchMakerAuthentication
import MatchMakerCore

public protocol DiscoveryRepository {
    func fetchPotentialMatches() async throws -> [User]
    func swipe(with direction: SwipeDirection, on user: User) async throws
}

public class DiscoveryRepositoryLive: DiscoveryRepository {
    
    private let authService: AuthService
    private let database: DatabaseReference
    
    public init(
        authService: AuthService,
        database: DatabaseReference = Database.database().reference()
        
    ) {
        self.authService = authService
        self.database = database
    }
    
    public func fetchPotentialMatches() async throws -> [User] {
        guard let currentUser = authService.user else {
            throw AuthError.notAuthenticated
        }
        print("fetchPotentialMatches test 1")
        let allUsers = try await fetchUsers()
        
        print("fetchPotentialMatches test 2")

        let swipes = await fetchSwipes(for: currentUser.uid)
        
        print("fetchPotentialMatches test 3")

        
        let res: [User] =  allUsers.compactMap { uid, user in
            if uid == currentUser.uid {
                return nil
            }
            
            // already swiped
            if swipes[uid] != nil {
                return nil
            }
            guard let url = user.profilePictureUrl else { return nil }
            
            return User(uid: uid, name: user.fullName, imageURL: url)
        }
        print("fetchPotentialMatches test")
        return res
    }
    
    private func fetchUsers() async throws -> [String: UserProfile] {
        print("Test 1 before Func")
        
        let snapshot = try await database.child("users").getData()
        
        print("Test 2 after Func")

        guard snapshot.exists() else { return [:] }
        
        return try snapshot.data(as: [String: UserProfile].self)
        
    }
    
    private func fetchSwipes(for uid: String) async -> [String: Bool] {
        let swipesSnapshot = try? await database.child("swipes").child(uid).getData()
        
        // Booll is the marker for left or right swiping
        guard let swipes = try?  swipesSnapshot?.data(as: [String: Bool].self) else { return [:] }
        
        return swipes
    }
    
    public func swipe(with direction: SwipeDirection, on user: User) async throws {
        guard let currentUser = authService.user else {
            throw AuthError.notAuthenticated
        }
        
        try await database.child("swipes").child(currentUser.uid).child(user.uid!).setValue(direction == .right)
        
        guard direction == .right else { return }
        let otherUserSwipeRight = try await swipe(for: user.uid!, on: currentUser.uid)

        guard otherUserSwipeRight else { return }

        // it´s a Match!
        
        try await database.child("matches").child(currentUser.uid).child(user.uid!).setValue(true)
        try await database.child("matches").child(user.uid!).child(currentUser.uid).setValue(true)

        
/*        try await database.child("matches").child(currentUser.uid).child(user.uid  init(uid: String?, name: String?, imageURL: URL?) {
            self.uid = uid
            self.name = name
            self.imageURL = imageURL
        }).setValue(true)
        try await database.child("matches").child(user.uid!).child(currentUser.uid).setValue(true) */

    }
    
    public func swipe(for user: String, on anotherUser: String) async throws -> Bool {
        let snapshot = try await database.child("swipes").child(user).child(anotherUser).getData()
        
        return snapshot.value as? Bool ?? false
    }
}
