//
// File: Quote.swift
// Project: TheSimpsonsQuoteAPI
// 
// Created by SCOTT CROWDER on 9/25/24.
// 
// Copyright © Playful Logic Studios, LLC 2024. All rights reserved.
// 


import Foundation

struct Quote: Codable, Identifiable {
    let quote: String
    let character: String
    let image: String
    let characterDirection: String
    
    var id: String { quote }
}
