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

public enum InteractionError: Error {
    case customError(message: String)
}

extension InteractionError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .customError(let message):
            return message
        }
    }

    public var failureReason: String? {
        switch self {
        case .customError:
            return NSLocalizedString("I don't know why.", comment: "")
        }
    }
    
    public var recoverySuggestion: String? {
        switch self {
        case .customError:
            return NSLocalizedString("Switch it off and on again.", comment: "")
        }
    }
}
