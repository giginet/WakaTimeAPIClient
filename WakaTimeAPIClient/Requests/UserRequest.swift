import Foundation

public struct UserRequest: WakaTimeRequestType {
    public typealias Response = [User]
    public var apiKey: String?
    
    public init() {
    }
    
    public var path: String {
        return "/users/current"
    }
}