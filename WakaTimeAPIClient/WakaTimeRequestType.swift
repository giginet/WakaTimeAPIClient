import Foundation
import APIKit
import ObjectMapper

enum WakaTimeAPIClientError: ErrorType {
    case APIKeyNotDefined
    case AuthenticationFailure
}

protocol WakaTimeRequestType: RequestType {
    var apiKey: String? { get set }
}

extension WakaTimeRequestType where Response: Mappable {
    var method: HTTPMethod {
        return .GET
    }
    
    var baseURL: NSURL {
        return NSURL(string: "https://wakatime.com/api/v1/")!
    }
    
    func configureURLRequest(URLRequest: NSMutableURLRequest) throws -> NSMutableURLRequest {
        guard let apiKey = self.apiKey else {
            throw WakaTimeAPIClientError.APIKeyNotDefined
        }
        guard let data = apiKey.dataUsingEncoding(NSUTF8StringEncoding) else {
            throw WakaTimeAPIClientError.AuthenticationFailure
        }
        let encryptedKey = data.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        URLRequest.setValue("Basic \(encryptedKey)", forHTTPHeaderField: "Authorization")
        return URLRequest
    }
    
    func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) -> Response? {
        guard let dictionary = object as? [String: AnyObject] else {
            return nil
        }
        
        let mapper = Mapper<Response>()
        guard let duration = mapper.map(dictionary) else {
            return nil
        }
        return duration
    }
}

struct DurationRequest: WakaTimeRequestType {
    typealias Response = Duration
    let date: NSDate
    var apiKey: String?
    
    init(date: NSDate) {
        self.date = date
    }
    
    var path: String {
        return "/users/current/durations"
    }
    
    var parameters: [String: AnyObject] {
        let dateString = self.dateStringFromDate(self.date)
        return ["date": dateString]
    }
    
    private func dateStringFromDate(date: NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.stringFromDate(date)
    }
}