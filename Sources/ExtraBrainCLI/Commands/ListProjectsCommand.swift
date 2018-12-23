import Foundation
import ExtraBrain

class ListProjectsCommand: CLICommandProtocol {
    typealias Request = ListProjectsRequest
    typealias Result = ListProjectsResult
    typealias Interaction = ListProjects

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
        case .success(let projects):
            let presenters = projects.map(ProjectPresenter.init)
            let rows = presenters.map { [$0.id, $0.name] }
            let view = ListView(header: ["ID", "Name"], rows: rows)

            return view.render()
        }
    }
}
