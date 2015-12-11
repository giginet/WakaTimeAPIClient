import Foundation
import ObjectMapper

public struct User: Mappable {
    var createdAt: NSDate?
    var email: String?
    var username: String?
    
    public init?(_ map: Map) {
    }
    
    public mutating func mapping(map: Map) {
        self.createdAt <- (map["data.0.created_at"], ISO8601DateTransform())
        self.email <- map["data.0.email"]
        self.username <- map["data.0.username"]
    }    
}