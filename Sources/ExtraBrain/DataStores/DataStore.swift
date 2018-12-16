import Foundation

public protocol DataStore {
    func getProjects(resultHandler: @escaping ([Project]) -> ())
    func getTasks(resultHandler: @escaping ([Task]) -> ())
    func getCurrentTask(resultHandler: @escaping (Task) -> ())
    func getTodayTimeEntries(resultHandler: @escaping ([TimeEntry]) -> ())
    func createTimeEntry(duration: TimeInterval, description: String, autostart: Bool, projectId: Int?, taskId: Int?, resultHandler: @escaping  (TimeEntry?) -> ())
}
