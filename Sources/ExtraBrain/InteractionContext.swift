import Foundation

public protocol InteractionContext {
    var dataStore: DataStore { get }
}

public class MockInteractionContext: InteractionContext {
    public var dataStore: DataStore

    public init() {
        self.dataStore = MockDataStore()
    }
}

public class WebInteractionContext: InteractionContext {
    public var dataStore: DataStore

    public init(email: String, password: String) {
        self.dataStore = WebDataStore(email: email, password: password)
    }
}


public struct InteractionError {
    let message: String
}
