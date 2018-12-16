import Foundation

public struct TimeEntry: Entity {
    public var id: Int?
    public var description: String
    public var project: Project?
    public var task: Task?
    public var duration: TimeInterval

    init(id: Int? = nil, description: String = "", project: Project? = nil, task: Task? = nil, duration: TimeInterval = 0) {
        self.id = id
        self.description = description
        self.project = project
        self.task = task
        self.duration = duration
    }
}

extension TimeEntry: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case description
        case duration

        case projectId
        case projectTitle

        case taskId
        case title
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        description = try values.decode(String.self, forKey: .description)
        duration = try values.decode(TimeInterval.self, forKey: .duration)

        if let projectId = try? values.decode(Int.self, forKey: .projectId),
            let projectTitle = try? values.decode(String.self, forKey: .projectTitle) {
            project = Project(id: projectId, name: projectTitle)
        }

        if let taskId = try? values.decode(Int.self, forKey: .taskId),
            let taskTitle = try? values.decode(String.self, forKey: .title) {
            task = Task(id: taskId, title: taskTitle)
            if let project = project {
                task?.project = project
            }
        }
    }

}
