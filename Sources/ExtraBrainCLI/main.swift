import Foundation
import Commander
import ExtraBrain

let group = Group {
    $0.group("projects", "Manage projects") {
        $0.command("ls", description: "List all your projects") { ListProjectsCommand().print() }
    }

    $0.group("tasks", "Manage tasks") {
        $0.command("ls", description: "List all your tasks") { ListTasksCommand().print() }
        $0.command("current", description: "Show the task you have a running time log on") { GetCurrentTaskCommand().print() }
    }

    $0.group("time", "List, add and start time logs") {
        $0.command("ls", description: "List time logs for today") { ListTimeEntriesCommand().print() }

        $0.command("add",
                   Option("task", default: 0, description:  "The task id log againts. Example: --task 123"),
                   Option("project", default: 0, description:  "The project id log againts. Example: --task 123"),
                   Argument<String>("duration", description: "The duration to log. Example: 1h32m"),
                   Argument<String>("description", description: "The description of what you are doing. Example: \"Code review\""),
                   description: "Add time log"
        ) { taskId, projectId, duration, description in
            AddTimeEntryCommand(taskId: taskId, projectId: projectId, durationString: duration, description: description).print()
        }

        $0.command("start",
                   Option("task", default: 0, description:  "The task id log againts. Example: --task 123"),
                   Option("project", default: 0, description:  "The project id log againts. Example: --task 123"),
                   Argument<String>("description", description: "The description of what you are doing. Example: \"Code review\""),
                   description: "Start and run time log"
        ) { taskId, projectId, description in
            StartTimeEntryCommand(taskId: taskId, projectId: projectId, description: description).print()
        }
    }

    // TODO: This is an important feature becouse we must be able to login to do whatever is needed
    $0.command("login", description: "Login using your ExtraBrain account") { (name:String) in
        print("Hello \(name)")
    }

    $0.command("logout", description: "Discard stored session or credentials") {
        print("Goodbye.")
    }
}

group.run()