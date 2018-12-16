import Foundation

public struct Project: Entity {
    public var id: Int?
    public var name: String

    public init(id: Int? = nil, name: String) {
        self.id = id
        self.name = name
    }
}

public struct ListProjectsRequest: InteractionRequest {
    public init() {
    }
}

public struct ListProjectsResult: InteractionResult {
    public let projects: [Project]
}

public class ListProjects: InteractionProtocol {
    public typealias Request = ListProjectsRequest
    public typealias Result = ListProjectsResult

    public var context: InteractionContext

    public required init(in context: InteractionContext) {
        self.context = context
    }

    public func execute(request: ListProjectsRequest, resultHandler: @escaping (ListProjectsResult) -> ()) {
        context.dataStore.getProjects { projects in
            let result = ListProjectsResult(projects: projects)
            resultHandler(result)
        }
    }
}
