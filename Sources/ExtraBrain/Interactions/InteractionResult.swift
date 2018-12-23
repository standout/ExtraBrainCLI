public protocol InteractionResultProtocol {
}

public enum InteractionResult<Value>: InteractionResultProtocol {
    case success(Value)
    case failure(InteractionError)
}
