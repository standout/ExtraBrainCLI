import ExtraBrain

struct TaskPresenter {
    let id: String
    let title: String

    init(task: Task) {
        if let id = task.id {
            self.id = String(id)
        } else {
            self.id = ""
        }
        self.title = task.title
    }
}
