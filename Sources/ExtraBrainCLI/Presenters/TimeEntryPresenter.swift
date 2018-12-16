import Foundation
import ExtraBrain

struct TimeEntryPresenter {
    let id: String
    let description: String
    let project: String
    let task: String
    let duration: String


    init(timeEntry: TimeEntry) {
        if let id = timeEntry.id {
            self.id = String(id)
        } else {
            self.id = ""
        }
        self.description = timeEntry.description
        self.duration = timeEntry.duration.humanTimeString

        if let teProject = timeEntry.project {
            let presenter = ProjectPresenter(project: teProject)
            project = "(\(presenter.id)) \(presenter.name)"
        } else {
            project = ""
        }
        if let teTask = timeEntry.task {
            let presenter = TaskPresenter(task: teTask)
            task = "(\(presenter.id)) \(presenter.title)"
        } else {
            task = ""
        }
    }
}
