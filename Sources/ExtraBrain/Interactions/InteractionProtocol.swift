public protocol InteractionProtocol {
    associatedtype Request: InteractionRequest
    associatedtype Result: InteractionResultProtocol

    var context: InteractionContext { get }

    init(in context: InteractionContext)
    func execute(request: Request, resultHandler:  @escaping (Result) -> ())
}
