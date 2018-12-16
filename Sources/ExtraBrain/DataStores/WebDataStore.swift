import Foundation

class WebDataStore: DataStore {
    var email: String
    var password: String

    init(email: String, password: String) {
        self.email = email
        self.password = password
    }

    /* Configure session, choose between:
     * defaultSessionConfiguration
     * ephemeralSessionConfiguration
     * backgroundSessionConfigurationWithIdentifier:
     And set session-wide properties, such as: HTTPAdditionalHeaders,
     HTTPCookieAcceptPolicy, requestCachePolicy or timeoutIntervalForRequest.
     */
    let sessionConfig = URLSessionConfiguration.default


    func getCurrentTask(resultHandler: (Task) -> ()) {
        resultHandler(Task(id: 1, title: "Example task 1"))
    }

    func getProjects(resultHandler: ([Project]) -> ()) {
        let projects = [
            Project(id: 1, name: "Example project 1"),
            Project(id: 2, name: "Example project 2"),
            Project(id: 3, name: "Example project 3"),
            Project(id: 4, name: "Example project 4"),
            Project(id: 5, name: "Example project 5"),
            ]

        resultHandler(projects)
    }



    func getTasks(resultHandler: @escaping ([Task]) -> ()) {
        get(url: URL(string: "https://extrabrain.se/tasks.json")!) { (data, response, error) in
            guard self.check(error: error) else {
                resultHandler([])
                return
            }

            guard let data = data else {
                print("Recieved no data or errors from ExtraBrain web?!")
                resultHandler([])
                return
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let tasks = try! decoder.decode([Task].self, from: data)

            resultHandler(tasks)
        }
    }

    func getTodayTimeEntries(resultHandler: @escaping ([TimeEntry]) -> ()) {
        get(url: URL(string: "https://extrabrain.se/time_entries")!) { (data, response, error) in
            guard self.check(error: error) else {
                resultHandler([])
                return
            }

            guard let data = data else {
                print("Recieved no data or errors from ExtraBrain web?!")
                resultHandler([])
                return
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let timeEntries = try! decoder.decode([TimeEntry].self, from: data)

            resultHandler(timeEntries)
        }
    }

    func createTimeEntry(duration: TimeInterval, description: String, autostart: Bool, projectId: Int? = nil, taskId: Int? = nil, resultHandler: @escaping  (TimeEntry?) -> ()) {

        var object: [String : Any] = [
            "description": description,
            "autostart": autostart,
            "duration": duration
        ]

        if let taskId = taskId {
            object["task_id"] = taskId
        }

        if let projectId = projectId {
            object["project_id"] = projectId
        }


        let bodyObject = ["time_entry": object]
        let jsonBody = try! JSONSerialization.data(withJSONObject: bodyObject, options: [])

        post(url: URL(string: "https://extrabrain.se/time_entries")!, jsonBody: jsonBody) { (data, response, error) in
            guard self.check(error: error) else {
                resultHandler(nil)
                return
            }

            guard let data = data else {
                print("Recieved no data or errors from ExtraBrain web?!")
                resultHandler(nil)
                return
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let tasks = try! decoder.decode(TimeEntry.self, from: data)

            resultHandler(tasks)
        }
    }

    fileprivate func get(url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> ()) {
        httpRequest("GET", url: url, completionHandler: completionHandler)
    }

    fileprivate func post(url: URL, jsonBody: Data? = nil, completionHandler: @escaping (Data?, URLResponse?, Error?) -> ()) {
        httpRequest("POST", url: url, jsonBody: jsonBody, completionHandler: completionHandler)
    }

    fileprivate func httpRequest(_ method: String, url: URL, jsonBody: Data? = nil, completionHandler: @escaping (Data?, URLResponse?, Error?) -> ()) {
        /* Create session, and optionally set a URLSessionDelegate. */
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)

        /* Create the Request:
         Create task Duplicate (GET https://extrabrain.se/tasks)
         */

        var request = URLRequest(url: url)
        request.httpMethod = method

        // Headers

        let auth = "\(email):\(password)".data(using: .utf8)!.base64EncodedString()

        request.addValue("application/json;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        //        request.addValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
        request.addValue("Basic \(auth)", forHTTPHeaderField: "Authorization")

        if let data = jsonBody {
            request.httpBody = data
        }

        /* Start a new Task */
        let task = session.dataTask(with: request, completionHandler: completionHandler)
        task.resume()
        session.finishTasksAndInvalidate()
    }

    fileprivate func check(error: Error?) -> Bool {
        guard error == nil else {
            print("URL Session Task Failed: %@", error!.localizedDescription)
            return false
        }
        return true
    }
}
