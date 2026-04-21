//
//  SupabaseManager.swift
//  LaymanApplication
//
//  Created by V Raghavendra Chary on 21/04/26.
//

import Foundation
import Supabase

final class SupabaseManager {
    
    static let shared = SupabaseManager()
    
    let client: SupabaseClient
    
    private init() {
        client = SupabaseClient(
            supabaseURL: URL(string: Config.supabaseURL)!,
            supabaseKey: Config.supabaseKey
        )
    }
}

