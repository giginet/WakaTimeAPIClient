import Foundation
import ObjectMapper

public struct Stat: Mappable {
    public var languages: [Language] = []
    
    public init?(_ map: Map) {
    }
    
    public mutating func mapping(map: Map) {
        self.languages <- map["languages"]
    }
}