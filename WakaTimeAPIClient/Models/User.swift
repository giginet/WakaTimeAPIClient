import Foundation
import ObjectMapper

public struct User: Mappable {
    var createdAt: NSDate?
    var email: String?
    var username: String?
    
    public init?(_ map: Map) {
    }
    
    public mutating func mapping(map: Map) {
        self.createdAt <- (map["created_at"], ISO8601DateTransform())
        self.email <- map["email"]
        self.username <- map["username"]
    }    
}