import Foundation
import ExtraBrain

class ListTimeEntriesCommand: CLICommandProtocol {
    typealias Request = ListTimeEntriesRequest
    typealias Result = ListTimeEntriesResult
    typealias Interaction = ListTimeEntries

    var result: Result?

    func execute() -> Result {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()

        Interaction(in: context).execute(request: buildRequest()) { result in
            self.result = result
            dispatchGroup.leave()
        }

        dispatchGroup.wait()

        return result!
    }

    func render() -> String {
        let result = self.result ?? execute()

        let presenters = result.timeEntries.map(TimeEntryPresenter.init)
        var rows = presenters.map { [$0.id, $0.description, $0.project, $0.task, $0.duration] }
        let totalRow = [
            "",
            "Total",
            "",
            "",
            result.timeEntries.map({$0.duration}).reduce(0, +).humanTimeString
        ]
        rows.append(totalRow)
        let view = ListView(header: ["ID", "Description", "Project", "Task", "Duration"], rows: rows)

        return view.render()
    }
}


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


extension TimeInterval {
    var humanTimeString: String {
        let interval = Int(self)
        let minutes = (interval / 60) % 60
        let hours = interval / 3600
        if hours > 0 {
            return String(format: "%02dh %02dm", Int(hours), Int(minutes))
        } else {
            return String(format: "%02dm", minutes)
        }
    }
}
