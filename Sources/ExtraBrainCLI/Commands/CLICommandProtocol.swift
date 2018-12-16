import ExtraBrain
import KeychainSwift

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
        #if DEBUG
        return MockInteractionContext()
        #else
        let keychain = KeychainSwift(keyPrefix: "se.standout.ExtraBrainCLI.")
        guard let email = keychain.get("email"),
            let password = keychain.get("password") else {
            fatalError("Use `eb login` to set email and password for ExtraBrain")
        }

        return WebInteractionContext(email: email, password: password)
        #endif
    }

    func buildRequest() -> Request {
        return Request()
    }

    func print() {
        Swift.print(render(), terminator: "")
    }
}
