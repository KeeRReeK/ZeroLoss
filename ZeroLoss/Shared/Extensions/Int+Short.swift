extension Int {
    var shortFormatted: String {
        let units: [(value: Int, suffix: String)] = [
            (1_000_000_000, "B"),
            (1_000_000, "M"),
            (1_000, "k")
        ]
        for unit in units where abs(self) >= unit.value {
            let scaled = Double(self) / Double(unit.value)
            let truncated = (scaled * 10).rounded(.towardZero) / 10
            let text = truncated.truncatingRemainder(dividingBy: 1) == 0
                ? String(Int(truncated))
                : String(truncated)
            return text + unit.suffix
        }
        return String(self)
    }
}
