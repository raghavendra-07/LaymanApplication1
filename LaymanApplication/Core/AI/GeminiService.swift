//
//  GeminiService.swift
//  LaymanApplication
//
//  Created by V Raghavendra Chary on 21/04/26.
//

import Foundation

class GeminiService {
    
    static let shared = GeminiService()
    
    func askAI(question: String, context: String) async throws -> String {
        
        let url = URL(string: "https://wtfcmcrfhwpdxpijtuoi.functions.supabase.co/ask-gemini")!
        
        let body: [String: Any] = [
            "question": question,
            "context": context
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // ✅ ONLY this header
        request.addValue(Config.supabaseKey, forHTTPHeaderField: "apikey")
        
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        print("RAW RESPONSE:", String(data: data, encoding: .utf8) ?? "")
        
        if let httpResponse = response as? HTTPURLResponse,
           httpResponse.statusCode != 200 {
            throw NSError(domain: "", code: httpResponse.statusCode)
        }
        
        let result = try JSONDecoder().decode(GeminiResponse.self, from: data)
        
        return result.candidates.first?.content.parts.first?.text ?? "No response"
    }

}




struct GeminiResponse: Codable {
    let candidates: [Candidate]
}

struct Candidate: Codable {
    let content: Content
}

struct Content: Codable {
    let parts: [Part]
}

struct Part: Codable {
    let text: String
}

