import Foundation
import APIKit
import ObjectMapper

public enum WakaTimeAPIClientError: ErrorType {
    case APIKeyNotDefined
    case AuthenticationFailure
}

public protocol WakaTimeRequestType: RequestType {
    var apiKey: String? { get set }
}

extension WakaTimeRequestType where Response: Mappable {    
    public var method: HTTPMethod {
        return .GET
    }
    
    public var baseURL: NSURL {
        return NSURL(string: "https://wakatime.com/api/v1/")!
    }
    
    public func configureURLRequest(URLRequest: NSMutableURLRequest) throws -> NSMutableURLRequest {
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
    
    public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) -> Response? {
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
