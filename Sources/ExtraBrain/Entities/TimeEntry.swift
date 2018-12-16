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
