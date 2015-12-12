import Foundation
import ObjectMapper

public struct Language: Mappable {
    public var name: String!
    public var totalSeconds: Int!
    public var percent: Float!
    
    
    public init?(_ map: Map) {
    }
    
    public mutating func mapping(map: Map) {
        self.name <- map["name"]
        self.totalSeconds <- map["total_seconds"]
        self.percent <- map["persent"]
    }
}