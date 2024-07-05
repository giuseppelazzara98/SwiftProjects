import Foundation

struct Mission: Identifiable, Codable, Hashable {
    let id: Int
    let description: String
    let launchDate: Date?
    let crew: [CrewRole]
    
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
    
    var badgeLaunchDate: String {
        launchDate?.formatted(date: .complete, time: .omitted) ?? "No Launch Date Available"
    }
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    struct CrewRole: Codable, Hashable {
        let name: String
        let role: String
    }
}
