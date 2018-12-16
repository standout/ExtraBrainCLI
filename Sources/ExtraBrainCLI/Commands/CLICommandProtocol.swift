import ExtraBrain

protocol CLICommandProtocol {
    associatedtype Request: InteractionRequest
    associatedtype Result: InteractionResult
    associatedtype Interaction: InteractionProtocol

    var context: InteractionContext { get }

    func buildRequest() -> Request
    func execute() -> Result
    func render() -> String
    func print()
}

extension CLICommandProtocol {
    var context: InteractionContext {
        return MockInteractionContext()
    }

    func buildRequest() -> Request {
        return Request()
    }

    func print() {
        Swift.print(render(), terminator: "")
    }
}
