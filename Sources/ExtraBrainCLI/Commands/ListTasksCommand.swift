import Foundation
import ExtraBrain

class ListTasksCommand: CLICommandProtocol {
    typealias Request = ListTasksRequest
    typealias Result = ListTasksResult
    typealias Interaction = ListTasks

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

        switch result {
        case .failure(let error):
            return "🚫 \(error.localizedDescription)"
        case .success(let tasks):
            let presenters = tasks.map(TaskPresenter.init)
            let rows = presenters.map { [$0.id, $0.title] }
            let view = ListView(header: ["ID", "Title"], rows: rows)

            return view.render()
        }
    }
}
