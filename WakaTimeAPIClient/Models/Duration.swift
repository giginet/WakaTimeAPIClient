import Foundation
import ObjectMapper

public struct Duration: Mappable {
    var start: NSDate?
    var end: NSDate?
    var branches: [String]?
    
    public init?(_ map: Map) {
    }
    
    public mutating func mapping(map: Map) {
        branches <- map["branches"]
        start <- (map["start"], DateTransform())
        end <- (map["end"], DateTransform())
    }
    
}