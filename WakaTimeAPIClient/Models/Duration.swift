import Foundation
import ObjectMapper

struct Duration: Mappable {
    var start: NSDate?
    var end: NSDate?
    var branches: [String]?
    
    init?(_ map: Map) {
    }
    
    mutating func mapping(map: Map) {
        branches <- map["branches"]
        start <- (map["start"], DateTransform())
        end <- (map["end"], DateTransform())
    }
    
}