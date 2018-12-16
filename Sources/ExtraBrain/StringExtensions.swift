import Foundation

public extension String {
    var timeInterval: TimeInterval {
        if #available(OSX 10.13, *) {
            var sum: Int = 0

            let hoursPattern = "(?<hours>\\d+)h"
            let hoursRegex = try? NSRegularExpression(pattern: hoursPattern, options: .caseInsensitive)

            if let match = hoursRegex?.firstMatch(in: self, range: NSRange(location: 0, length: self.utf16.count)) {
                if let hoursRange = Range(match.range(withName: "hours"), in: self) {
                    sum += (Int(self[hoursRange]) ?? 0) * 3600
                }
            }

            let minutesPattern = "(?<minutes>\\d+)m"
            let minutesRegex = try? NSRegularExpression(pattern: minutesPattern, options: .caseInsensitive)

            if let match = minutesRegex?.firstMatch(in: self, range: NSRange(location: 0, length: self.utf16.count)) {
                if let minutesRange = Range(match.range(withName: "minutes"), in: self) {
                    sum += (Int(self[minutesRange]) ?? 0) * 60
                }
            }

            return TimeInterval(sum)
        } else {
            return 0
        }
    }



}
