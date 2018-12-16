import Foundation

public struct AddTimeEntryRequest: InteractionRequest {
    public init() {
    }

    public var taskId: Int?
    public var projectId: Int?
    public var description: String = ""
    public var duration: TimeInterval = 0

    public init(duration: TimeInterval = 0, description: String) {
        self.duration = duration
        self.description = description
    }
}

public struct AddTimeEntryResult: InteractionResult {
    public let timeEntry: TimeEntry
}

public class AddTimeEntry: InteractionProtocol {
    public typealias Request = AddTimeEntryRequest
    public typealias Result = AddTimeEntryResult

    public var context: InteractionContext

    public required init(in context: InteractionContext) {
        self.context = context
    }

    public func execute(request: Request, resultHandler: @escaping (Result) -> ()) {
        context.dataStore.createTimeEntry(duration: request.duration, description: request.description, autostart: false) { timeEntry in
            let result = Result(timeEntry: timeEntry)
            resultHandler(result)
        }
    }
}
