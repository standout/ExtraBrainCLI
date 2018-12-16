import ExtraBrain

struct ProjectPresenter {
    let id: String
    let name: String

    init(project: Project) {
        if let id = project.id {
            self.id = String(id)
        } else {
            self.id = ""
        }
        self.name = project.name
    }
}
