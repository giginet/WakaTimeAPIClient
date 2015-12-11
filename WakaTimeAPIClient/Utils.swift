import Foundation

extension NSDate {
    public func wk_formattedDateString() -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.stringFromDate(self)
    }
}