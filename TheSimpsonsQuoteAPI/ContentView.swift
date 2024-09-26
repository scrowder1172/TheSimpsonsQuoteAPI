//
// File: ContentView.swift
// Project: TheSimpsonsQuoteAPI
// 
// Created by SCOTT CROWDER on 9/25/24.
// 
// Copyright © Playful Logic Studios, LLC 2024. All rights reserved.
// 


import SwiftUI

struct ContentView: View {
    
    @State private var quote: Quote?
    
    var body: some View {
        VStack {
            
            Button {
                getQuote()
            } label: {
                Text("Get Quote")
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
            
            if let quote {
                
                AsyncImage(url: URL(string: quote.image)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                    Text(quote.character)
                        .font(.title)
                    Text(quote.quote)
                        .font(.headline)
                        .padding()
                } placeholder: {
                    ProgressView()
                }
                
                
            }
            
            
        }
        .padding()
    }
    
    func getQuote() {
        Task {
            guard let url = URL(string: "https://thesimpsonsquoteapi.glitch.me/quotes") else { return }
            
            let request = URLRequest(url: url)
            
            do {
                let (data, response) = try await URLSession.shared.data(for: request)
                
                guard let response = response as? HTTPURLResponse else { return }
                
                guard response.statusCode == 200 else {
                    print("Invalid status code: \(response.statusCode)")
                    return
                }
                
                
                let quotes = try JSONDecoder().decode([Quote].self, from: data)
                quote = quotes[0]
                
                if let quote {
                    print("\(quote.character) says: \(quote.quote)")
                }
                
            } catch {
                print("Error getting quote: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    ContentView()
}
