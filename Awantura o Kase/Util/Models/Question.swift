import Foundation

final class Question: Identifiable, Codable {
    var id = UUID()
    public var body: String
    public var category: String
    public var correctAnser: String
    public var hintA: String
    public var hintB: String
    public var hintC: String
    public var attachmentPath: String
    
    public var attachment: URL?
    public var asked: Bool = false
    
    public func getHits() -> [String] {
        return [correctAnser, hintA, hintB, hintC].shuffled()
    }
    
    public func attachmentType() -> String {
        if(attachmentPath.hasSuffix(".jpg")) {
            return "image"
        }
        else if(attachmentPath.hasSuffix(".mp3")) {
            return "audio"
        }
        else if(attachmentPath.hasSuffix(".mp4")) {
            return "video"
        }
        
        return "none"
    }
    
    public var wasAsked: String {
        return asked ? "Used" : ""
    }
    
    enum CodingKeys: String, CodingKey {
        case body, category, correctAnser, hintA, hintB, hintC, attachmentPath, attachment, asked
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        body = try container.decode(String.self, forKey: .body)
        category = try container.decode(String.self, forKey: .category)
        correctAnser = try container.decode(String.self, forKey: .correctAnser)
        hintA = try container.decode(String.self, forKey: .hintA)
        hintB = try container.decode(String.self, forKey: .hintB)
        hintC = try container.decode(String.self, forKey: .hintC)
        attachmentPath = try container.decode(String.self, forKey: .attachmentPath)
        asked = try container.decodeIfPresent(Bool.self, forKey: .asked) ?? false
    }
}
