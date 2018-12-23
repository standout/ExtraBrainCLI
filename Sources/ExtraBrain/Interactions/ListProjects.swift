import Foundation

public struct ListProjectsRequest: InteractionRequest {
    public init() {
    }
}

public typealias ListProjectsResult = InteractionResult<[Project]>

public class ListProjects: InteractionProtocol {
    public typealias Request = ListProjectsRequest
    public typealias Result = ListProjectsResult

    public var context: InteractionContext

    public required init(in context: InteractionContext) {
        self.context = context
    }

    public func execute(request: ListProjectsRequest, resultHandler: @escaping (ListProjectsResult) -> ()) {
        context.dataStore.getProjects { projects in
            resultHandler(.success(projects))
        }
    }
}
