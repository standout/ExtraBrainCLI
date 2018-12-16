import Foundation
import Commander
import ExtraBrain
import KeychainSwift

func readSecretLine() -> String? {
    return String(cString: getpass(""))
}

let group = Group {
//    $0.group("projects", "Manage projects") {
//        $0.command("ls", description: "List all your projects") { ListProjectsCommand().print() }
//    }

    $0.group("tasks", "Manage tasks") {
        $0.command("ls", description: "List all your tasks") { ListTasksCommand().print() }
        // $0.command("current", description: "Show the task you have a running time log on") { GetCurrentTaskCommand().print() }
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

    $0.command("login", description: "Login using your ExtraBrain account") {
        print("Login email:")
        guard let email = readLine(strippingNewline: true) else {
            print("No email?")
            return
        }

        print("Password:")

        guard let password = readSecretLine() else {
            print("No password?!")
            return
        }

        let keychain = KeychainSwift(keyPrefix: "se.standout.ExtraBrainCLI.")
        keychain.set(email, forKey: "email")
        keychain.set(password, forKey: "password")

        print("Your credentials is now stored using Apples Keychain")
    }

    $0.command("logout", description: "Discard stored session or credentials") {
        let keychain = KeychainSwift(keyPrefix: "se.standout.ExtraBrainCLI.")
        keychain.delete("email")
        keychain.delete("password")

        print("Goodbye.")
    }
}

group.run()
