import Foundation
import ObjectMapper

public struct LanguageRequest: WakaTimeRequestType {
    public typealias Response = [Language]
    public var apiKey: String?
    let startDate: NSDate
    let endDate: NSDate
    
    public init(startDate: NSDate, endDate: NSDate) {
        self.startDate = startDate
        self.endDate = endDate
    }
    
    public var path: String {
        return "/users/current/summaries"
    }
    
    public var parameters: [String: AnyObject] {
        return ["start": self.startDate.wk_formattedDateString(),
            "end": self.endDate.wk_formattedDateString()]
    }
}