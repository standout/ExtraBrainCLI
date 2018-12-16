import Foundation

public struct ListTasksRequest: InteractionRequest {
    public init() {
    }
}

public struct ListTasksResult: InteractionResult {
    public let tasks: [Task]
}

public class ListTasks: InteractionProtocol {
    public typealias Request = ListTasksRequest
    public typealias Result = ListTasksResult

    public var context: InteractionContext

    public required init(in context: InteractionContext) {
        self.context = context
    }

    public func execute(request: ListTasksRequest, resultHandler: @escaping (ListTasksResult) -> ()) {
        context.dataStore.getTasks { tasks in
            let result = ListTasksResult(tasks: tasks)
            resultHandler(result)
        }
    }
}
