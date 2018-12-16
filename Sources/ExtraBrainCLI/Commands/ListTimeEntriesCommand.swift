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
