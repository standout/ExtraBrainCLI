extension String {
    func rightJustified(width: Int, using repeating: String = " ", truncate: Bool = false) -> String {
        guard width > count else {
            return truncate ? String(suffix(width)) : self
        }
        return String(repeating: repeating, count: width - count) + self
    }

    func leftJustified(width: Int, using repeating: String = " ", truncate: Bool = false) -> String {
        guard width > count else {
            return truncate ? String(prefix(width)) : self
        }
        return self + String(repeating: repeating, count: width - count)
    }
}
