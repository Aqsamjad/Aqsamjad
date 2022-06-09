//
//  BecomeAMuftiModel.swift
//  myMufti
//
//  Created by Qazi on 14/02/2022.
//

import Foundation
import Foundation

// MARK: - Welcome
struct BecomeAMuftiModel: Codable {
    let status: Bool
    let message: String
    let data: BecomeAMufti
}

// MARK: - DataClass
struct BecomeAMufti: Codable {
    let id, name, email, password: String
    let phoneNumber, image, status, createdAt: String
    let modified, code, fCode, gToken: String
    let fbToken, aCode, nationality, userType: String
    let degree, degreeStartDate, degreeEndDate, instituteName: String
    let experianceFrom, experianceTo, shopRegistered, emailCode: String
    let muftiExpertise: [MuftiExpertise]

    enum CodingKeys: String, CodingKey {
        case id, name, email, password
        case phoneNumber = "phone_number"
        case image, status
        case createdAt = "created_at"
        case modified, code
        case fCode = "f_code"
        case gToken = "g_token"
        case fbToken = "fb_token"
        case aCode = "a_code"
        case nationality
        case userType = "user_type"
        case degree
        case degreeStartDate = "degree_start_date"
        case degreeEndDate = "degree_end_date"
        case instituteName = "institute_name"
        case experianceFrom = "experiance_from"
        case experianceTo = "experiance_to"
        case shopRegistered = "shop_registered"
        case emailCode = "email_code"
        case muftiExpertise = "mufti_expertise"
    }
}

// MARK: - MuftiExpertise
struct MuftiExpertise: Codable {
    let id, userID, expertise: String

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case expertise
    }
}
