//
//  MessageModel.swift
//  Chat-test
//
//  Created by Zhekon Kovalevskiy on 27.04.2023.
//

import Foundation

enum MessageType {
    case idle
    case my
    case incoming
}

struct MessageModel: Hashable {
    var id = Int()
    var type = MessageType.idle
    var name = String()
    var message = String()
}

struct FakeApiData: Hashable {
    var allData = [
        MessageModel(id: 1, type: .incoming, name: "Ann", message: " I'd like to reserve a hotel room."),
        MessageModel(id: 2, type: .my, name: "Zhekon", message: "That should be no problem. May I have your full name, please?"),
        MessageModel(id: 3, type: .incoming, name: "Ann", message: "My name is John Sandals."),
        MessageModel(id: 4, type: .my, name: "Zhekon", message: "Hello, Mr. Sandals. My name is Michelle. What days do you need that reservation, sir?"),
        MessageModel(id: 5, type: .incoming, name: "Ann", message: "I'm planning to visit New York from Friday, April 14 until Monday, April 17."),
        MessageModel(id: 6, type: .my, name: "Zhekon", message: "Our room rates recently went up. Is that okay with you, Mr. Sandals?"),
        MessageModel(id: 7, type: .incoming, name: "Ann", message: "How much per night are we talking about?"),
        MessageModel(id: 8, type: .my, name: "Zhekon", message: "Each night will be $308"),
        MessageModel(id: 9, type: .incoming, name: "Ann", message: "That price is perfectly acceptable."),
        MessageModel(id: 10, type: .my, name: "Zhekon", message: "Wonderful! Do you prefer a smoking or nonsmoking room?"),
        MessageModel(id: 11, type: .incoming, name: "Ann", message: "Nonsmoking, please."),
        MessageModel(id: 12, type: .my, name: "Zhekon", message: "Next question: Is a queen-size bed okay?"),
        MessageModel(id: 13, type: .incoming, name: "Ann", message: "That sounds fine."),
        MessageModel(id: 14, type: .my, name: "Zhekon", message: "Okay, Mr. Sandals. Your reservation is in our computer. All we need now is a phone number."),
        MessageModel(id: 15, type: .incoming, name: "Ann", message: "Certainly. My phone number is 626-555-1739."),
        MessageModel(id: 16, type: .my, name: "Zhekon", message: "Thank you, Mr. Sandals. We look forward to seeing you in New York!")
    ]
    
    var newData = [
        MessageModel(id: 17, type: .my, name: "Zhekon", message: "Its a new message from backend (first)"),
        MessageModel(id: 18, type: .my, name: "Zhekon", message: "Its a new message from backend (second)"),
        MessageModel(id: 19, type: .my, name: "Zhekon", message: "Its a new message from backend (third)"),
        MessageModel(id: 20, type: .my, name: "Zhekon", message: "Its a new message from backend (fourth)")
        ]
    
}
