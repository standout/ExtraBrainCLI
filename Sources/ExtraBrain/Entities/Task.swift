public struct Task: Entity {
    public var id: Int?
    public var title: String
    public var project: Project?

    public init(id: Int? = nil, title: String, project: Project? = nil) {
        self.id = id
        self.title = title
        self.project = project
    }
}
