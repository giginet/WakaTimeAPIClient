import Foundation
import ObjectMapper

public struct Language: Mappable {
    var name: String!
    var totalSeconds: Int!
    var percent: Float!
    
    public init?(_ map: Map) {
    }
    
    public mutating func mapping(map: Map) {
        self.name <- map["name"]
        self.totalSeconds <- map["totalSeconds"]
        self.percent <- map["persent"]
    }
}