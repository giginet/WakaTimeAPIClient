import Foundation

public struct DurationRequest: WakaTimeRequestType {
    public typealias Response = [Duration]
    public var apiKey: String?
    let date: NSDate
    
    public init(date: NSDate) {
        self.date = date
    }
    
    public var path: String {
        return "/users/current/durations"
    }
    
    public var parameters: [String: AnyObject] {
        let dateString = self.date.wk_formattedDateString()
        return ["date": dateString]
    }
}