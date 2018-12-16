import Foundation
import ExtraBrain

class AddTimeEntryCommand: CLICommandProtocol {
    typealias Request = AddTimeEntryRequest
    typealias Result = AddTimeEntryResult
    typealias Interaction = AddTimeEntry

    var taskId: Int = 0
    var projectId: Int = 0
    var durationString: String = "0h0m"
    var description: String = ""

    init(taskId: Int = 0, projectId: Int = 0, durationString: String, description: String) {
        self.taskId = taskId
        self.projectId = projectId
        self.durationString = durationString
        self.description = description
    }

    func buildRequest() -> AddTimeEntryRequest {
        var request = AddTimeEntryRequest(duration: durationString.timeInterval, description: description)

        if taskId != 0 {
            request.taskId = taskId
        }

        if projectId != 0 {
            request.projectId = projectId
        }

        return request
    }

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

        let presenter = TimeEntryPresenter(timeEntry: result.timeEntry)
        let row = [presenter.id, presenter.description, presenter.project, presenter.task, presenter.duration]
        let view = ListView(header: ["ID", "Description", "Project", "Task", "Duration"], rows: [row])

        return view.render()
    }
}
