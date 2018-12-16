import Foundation

public struct StartTimeEntryRequest: InteractionRequest {
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

public struct StartTimeEntryResult: InteractionResult {
    public let timeEntry: TimeEntry?
    public var errors = [InteractionError]()
}

public class StartTimeEntry: InteractionProtocol {
    public typealias Request = StartTimeEntryRequest
    public typealias Result = StartTimeEntryResult

    public var context: InteractionContext

    public required init(in context: InteractionContext) {
        self.context = context
    }

    public func execute(request: Request, resultHandler: @escaping (Result) -> ()) {
        context.dataStore.createTimeEntry(duration: request.duration,
                                          description: request.description,
                                          autostart: true,
                                          projectId: request.projectId,
                                          taskId: request.taskId) { timeEntry in
            var errors = [InteractionError]()
            if timeEntry == nil {
                errors.append(.init(message: "No time entry was created"))
            }

            let result = Result(timeEntry: timeEntry, errors: errors)
            resultHandler(result)
        }
    }
}
