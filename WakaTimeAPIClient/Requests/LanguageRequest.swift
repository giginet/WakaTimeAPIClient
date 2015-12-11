import Foundation
import ObjectMapper

public struct LanguageRequest: WakaTimeRequestType {
    public typealias Response = Language
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
    
    public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) -> Response? {
        guard let dictionary = object as? [String: AnyObject] else {
            return nil
        }
        
        let mapper = Mapper<Response>()
        
        guard let data = dictionary["data"] else {
            return nil
        }
        
        guard let duration = mapper.map(data[0]["languages"]) else {
            return nil
        }
        return duration
    }
}