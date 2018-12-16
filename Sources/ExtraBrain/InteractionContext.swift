import Foundation

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

public protocol DataStore {
    func getProjects(resultHandler: @escaping ([Project]) -> ())
    func getTasks(resultHandler: ([Task]) -> ())
    func getCurrentTask(resultHandler: (Task) -> ())
    func getTodayTimeEntries(resultHandler: ([TimeEntry]) -> ())
    func createTimeEntry(duration: TimeInterval, description: String, autostart: Bool, resultHandler: (TimeEntry) -> ())
}

public protocol InteractionContext {
    var dataStore: DataStore { get }
}

public protocol Entity {
}

class MockDataStore: DataStore {
    func getCurrentTask(resultHandler: (Task) -> ()) {
        resultHandler(Task(id: 1, title: "Example task 1"))
    }

    func getProjects(resultHandler: ([Project]) -> ()) {
        let projects = [
            Project(id: 1, name: "Example project 1"),
            Project(id: 2, name: "Example project 2"),
            Project(id: 3, name: "Example project 3"),
            Project(id: 4, name: "Example project 4"),
            Project(id: 5, name: "Example project 5"),
            ]

        resultHandler(projects)
    }

    func getTasks(resultHandler: ([Task]) -> ()) {
        let tasks = [
            Task(id: 1, title: "Example task 1"),
            Task(id: 2, title: "Example task 2"),
            Task(id: 3, title: "Example task 3"),
            Task(id: 4, title: "Example task 4"),
            Task(id: 5, title: "Example task 5")
        ]

        resultHandler(tasks)
    }

    func getTodayTimeEntries(resultHandler: ([TimeEntry]) -> ()) {
        let task = Task(id: 12312, title: "Project management")
        let project = Project(id: 1233, name: "Example project 1")
        let timeEntries = [
            TimeEntry(id: 1, description: "The meeting", project: project, task: task, duration: 92*60),
            TimeEntry(id: 2, description: "The meeting", project: project, task: task, duration: 93*60),
            TimeEntry(id: 3, description: "The meeting", project: project, task: task, duration: 94*60),
            TimeEntry(id: 4, description: "The meeting", project: project, task: task, duration: 95*60),
            TimeEntry(id: 5, description: "The meeting", project: project, task: task, duration: 96*60),
        ]

        resultHandler(timeEntries)
    }

    func createTimeEntry(duration: TimeInterval, description: String, autostart: Bool, resultHandler: (TimeEntry) -> ()) {
        let timeEntry = TimeEntry(id: 1, description: description, duration: duration)
        resultHandler(timeEntry)
    }
}

public class MockInteractionContext: InteractionContext {
    public var dataStore: DataStore

    public init() {
        self.dataStore = MockDataStore()
    }
}
