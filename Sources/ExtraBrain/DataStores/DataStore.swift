import Foundation

public protocol DataStore {
    func getProjects(resultHandler: @escaping ([Project]) -> ())
    func getTasks(resultHandler: ([Task]) -> ())
    func getCurrentTask(resultHandler: (Task) -> ())
    func getTodayTimeEntries(resultHandler: ([TimeEntry]) -> ())
    func createTimeEntry(duration: TimeInterval, description: String, autostart: Bool, resultHandler: (TimeEntry) -> ())
}
