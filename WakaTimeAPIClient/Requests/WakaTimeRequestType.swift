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

public extension WakaTimeRequestType {
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
}

public extension WakaTimeRequestType where Self.Response: Mappable {
    public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) -> Response? {
        guard let dictionary = object as? [String: AnyObject] else {
            return nil
        }
        
        guard let data = dictionary["data"] as? [String: AnyObject] else {
            return nil
        }
        
        let mapper = Mapper<Response>()
        guard let object = mapper.map(data) else {
            return nil
        }
        return object
    }
}

public extension WakaTimeRequestType
where Self.Response: CollectionType,
Self.Response.Generator.Element: Mappable {
    public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) -> Response? {
        guard let dictionary = object as? [String: AnyObject] else {
            return nil
        }
        
        guard let data = dictionary["data"] as? [AnyObject] else {
            return nil
        }
        
        var objects: [Self.Response.Generator.Element] = []
        for objectDictionary in data {
            let mapper = Mapper<Response.Generator.Element>()
            guard let object = mapper.map(objectDictionary) else {
                continue
            }
            objects.append(object)
        }
        return objects as? Self.Response
    }
}