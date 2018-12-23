import Foundation

public struct GetCurrentTaskRequest: InteractionRequest {
    public init() {
    }
}

public typealias GetCurrentTaskResult = InteractionResult<Task>

public class GetCurrentTask: InteractionProtocol {
    public typealias Request = GetCurrentTaskRequest
    public typealias Result = GetCurrentTaskResult

    public var context: InteractionContext

    public required init(in context: InteractionContext) {
        self.context = context
    }

    public func execute(request: GetCurrentTaskRequest, resultHandler: @escaping (GetCurrentTaskResult) -> ()) {
        context.dataStore.getCurrentTask { task in
            resultHandler(.success(task))
        }
    }
}
