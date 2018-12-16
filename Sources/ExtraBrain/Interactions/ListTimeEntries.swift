import Foundation

public struct ListTimeEntriesRequest: InteractionRequest {
    public init() {
    }
}

public struct ListTimeEntriesResult: InteractionResult {
    public let timeEntries: [TimeEntry]
}

public class ListTimeEntries: InteractionProtocol {
    public typealias Request = ListTimeEntriesRequest
    public typealias Result = ListTimeEntriesResult

    public var context: InteractionContext

    public required init(in context: InteractionContext) {
        self.context = context
    }

    public func execute(request: Request, resultHandler: @escaping (Result) -> ()) {
        context.dataStore.getTodayTimeEntries { timeEntries in
            let result = Result(timeEntries: timeEntries)
            resultHandler(result)
        }
    }
}
