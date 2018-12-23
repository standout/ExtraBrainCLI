import Foundation
import ExtraBrain

class GetCurrentTaskCommand: CLICommandProtocol {
    typealias Request = GetCurrentTaskRequest
    typealias Result = GetCurrentTaskResult
    typealias Interaction = GetCurrentTask

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
        case .success(let task):
            let presenter = TaskPresenter(task: task)
            let rows = [[presenter.id, presenter.title]]
            let view = ListView(header: ["ID", "Title"], rows: rows)

            return view.render()
        }
    }
}
