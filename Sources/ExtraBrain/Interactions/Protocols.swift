public protocol InteractionRequest {
    init()
}

public protocol InteractionResult {
}

public protocol InteractionProtocol {
    associatedtype Request: InteractionRequest
    associatedtype Result: InteractionResult

    var context: InteractionContext { get }

    init(in context: InteractionContext)
    func execute(request: Request, resultHandler:  @escaping (Result) -> ())
}
