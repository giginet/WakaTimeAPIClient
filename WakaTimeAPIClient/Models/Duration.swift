import Foundation
import ObjectMapper

public struct Duration: Mappable {
    var project: String!
    var time: NSDate!
    var duration: Float!
    
    public init?(_ map: Map) {
    }
    
    public mutating func mapping(map: Map) {
        self.project <- map["project"]
        self.time <- (map["time"], DateTransform())
        self.duration <- map["duration"]
    }
    
}