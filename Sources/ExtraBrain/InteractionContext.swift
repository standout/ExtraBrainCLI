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
