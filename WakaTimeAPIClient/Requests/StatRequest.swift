import Foundation
import ObjectMapper

public struct StatRequest: WakaTimeRequestType {
    
    public enum Range: String {
        case Last7Days = "last_7_days"
        case Last30Days = "last_30_days"
        case Last6mMonths = "last_6_months"
        case LastYear = "last_year"
        case AllTime = "all_time"
    }
        
    public typealias Response = Stat
    public var apiKey: String?
    let range: Range
    
    public init(range: Range=Range.Last7Days) {
        self.range = range
    }
    
    public var path: String {
        return "/users/current/stats/\(self.range.rawValue)"
    }
}