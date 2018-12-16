struct ListView {
    let header: [String]
    let rows: [[String]]

    func render() -> String {
        var body = ""
        var lengths = [Int: Int]()
        for (index, col) in header.enumerated() {
            lengths[index] = [lengths[index] ?? 0, col.count].max()!
        }
        for row in rows {
            for (index, col) in row.enumerated() {
                lengths[index] = [lengths[index] ?? 0, col.count].max()!
            }
        }

        // Header
        for (index, col) in header.enumerated() {
            let content = col.leftJustified(width: lengths[index] ?? 0)
            body += "| \(content) "
        }
        body += "|\n"

        // Separator
        for (index, _) in header.enumerated() {
            let content =  "".leftJustified(width: lengths[index] ?? 0, using: "-")
            body += "|:\(content)-"
        }
        body += "|\n"

        // Rows
        for row in rows {
            for (index, col) in row.enumerated() {
                let content = col.leftJustified(width: lengths[index] ?? 0)
                body += "| \(content) "
            }
            body += "|\n"
        }


        return body
    }
}
