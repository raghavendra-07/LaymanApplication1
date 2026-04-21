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
        
        // ✅ CORRECT URL (matches your curl)
        let url = URL(string:
            "https://generativelanguage.googleapis.com/v1beta/models/gemini-flash-latest:generateContent"
        )!
        
        // ✅ Prompt
        let prompt = """
        You are Layman AI.
        Explain things simply in 1-2 sentences.
        
        Article:
        \(context)
        
        Question:
        \(question)
        """
        
        // ✅ Request Body
        let body: [String: Any] = [
            "contents": [
                [
                    "parts": [
                        ["text": prompt]
                    ]
                ]
            ]
        ]
        
        // ✅ Request Setup
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // 🔥 IMPORTANT FIX (use header instead of ?key=)
        request.addValue(Config.geminiAPIKey, forHTTPHeaderField: "X-goog-api-key")
        
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        // ✅ API Call
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // 🔍 DEBUG (VERY IMPORTANT)
        print("RAW RESPONSE:", String(data: data, encoding: .utf8) ?? "")
        
        // ❌ Handle errors properly
        if let httpResponse = response as? HTTPURLResponse,
           httpResponse.statusCode != 200 {
            throw NSError(domain: "", code: httpResponse.statusCode)
        }
        
        // ✅ Decode response
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

