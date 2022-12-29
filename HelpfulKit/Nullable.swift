//
//  Nullable.swift
//  HelpfulKit
//
//  Created by Dipak Panchasara on 29/12/22.
//

import Foundation

// swiftlint:disable syntactic_sugar
public enum Nullable<T: Codable>: Codable {
    case null
    case value(T)
    public init(_ optional: Optional<T>) {
        switch optional {
        case .some(let value):
            self = .value(value)
        case .none:
            self = .null
        }
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .null:
            try container.encodeNil()
        case .value(let value):
            try container.encode(value)
        }
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            let value = try container.decode(T.self)
            self = .value(value)
        } catch {
            self = .null
        }
    }
    public var value: T? {
        guard case let .value(value) = self else { return nil }
        return value
    }
}
