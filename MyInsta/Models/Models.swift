//
//  Models.swift
//  MyInsta
//
//  Created by Nam on 12/17/20.
//

import Foundation

enum Gender {
    case male, female, other
}
struct authUser: Codable {
    var username: String
    var email: String
}

struct JSON {
    static let encoder = JSONEncoder()
}

extension Encodable {
    // chuyển dữ liệu từ object -> dic
    var dictionary: [String:Any] {
        return (try? JSONSerialization.jsonObject(with: JSON.encoder.encode(self))) as? [String:Any] ?? [:]
    }
    subscript(key: String) -> Any? {
        return dictionary[key]
    }
}


struct User {
    let username: String
    let bio: String
    let name: (first: String, last: String)
    let birthDate: Date
    let counts: UserCount
    let gender: Gender
}

struct UserCount {
    let like: Int
    let following: Int
    let follows: Int
}
public enum UserPostType {
    case photo, video
}
/// Represent a user post
public struct UserPost {
    let identifier: String
    let postType: UserPostType
    let thumbnailImage: URL
    let postURL: URL // either video url or full resolution photo
    let caption: String?
    let likeCount: [PostLike]
    let comments: [PostComment]
    let createDate: Date
    let taggedUser: [String]
}

struct PostLike {
    let username: String
    let postIdentifier: String
}

struct CommentLike {
    let username: String
    let commentIdentifier: String
}
struct PostComment {
    let identifier: String
    let username: String
    let text: String
    let createDate: Date
    let likes: [CommentLike]
}
