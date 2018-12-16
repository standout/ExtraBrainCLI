import Foundation

extension TimeInterval {
    var humanTimeString: String {
        let interval = Int(self)
        let minutes = (interval / 60) % 60
        let hours = interval / 3600
        if hours > 0 {
            return String(format: "%02dh %02dm", Int(hours), Int(minutes))
        } else {
            return String(format: "%02dm", minutes)
        }
    }
}
