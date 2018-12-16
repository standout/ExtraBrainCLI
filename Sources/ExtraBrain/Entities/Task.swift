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


extension Task: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case projectId
        case projectTitle
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)

        if let projectId = try? values.decode(Int.self, forKey: .projectId),
            let projectTitle = try? values.decode(String.self, forKey: .projectTitle) {
            project = Project(id: projectId, name: projectTitle)
        }
    }
}
