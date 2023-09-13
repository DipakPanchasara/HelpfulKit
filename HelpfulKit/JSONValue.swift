//
//  JSONValue.swift
//  HelpfulKit
//
//  Created by Dipak Panchasara on 29/12/22.
//

import Foundation

public enum JSONValue: Codable, Equatable {
    case string(String)
    case int(Int)
    case double(Double)
    case bool(Bool)
    case object([String: JSONValue])
    case array([JSONValue])
    case null
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let string): try container.encode(string)
        case .int(let int): try container.encode(int)
        case .double(let double): try container.encode(double)
        case .bool(let bool): try container.encode(bool)
        case .object(let object): try container.encode(object)
        case .array(let array): try container.encode(array)
        case .null: try container.encode(Optional<String>.none)
        }
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self = try ((try? container.decode(String.self)).map(JSONValue.string))
            .or((try? container.decode(Int.self)).map(JSONValue.int))
            .or((try? container.decode(Double.self)).map(JSONValue.double))
            .or((try? container.decode(Bool.self)).map(JSONValue.bool))
            .or((try? container.decode([String: JSONValue].self)).map(JSONValue.object))
            .or((try? container.decode([JSONValue].self)).map(JSONValue.array))
            .or((container.decodeNil() ? .some(JSONValue.null) : .none))
            .resolve(
                with: DecodingError.typeMismatch(
                    JSONValue.self,
                    DecodingError.Context(
                        codingPath: container.codingPath,
                        debugDescription: "Not a JSON value"
                )
            )
        )
    }
}

extension JSONValue: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self = .string(value)
    }
}
extension JSONValue: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = .int(value)
    }
}
extension JSONValue: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = .double(value)
    }
}
extension JSONValue: ExpressibleByBooleanLiteral {
    public init(booleanLiteral value: Bool) {
        self = .bool(value)
    }
}
extension JSONValue: ExpressibleByDictionaryLiteral {
    public init(dictionaryLiteral elements: (String, JSONValue)...) {
        self = .object([String: JSONValue](uniqueKeysWithValues: elements))
    }
}
extension JSONValue: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: JSONValue...) {
        self = .array(elements)
    }
}

extension JSONValue {
    
    var string: String? {
        switch self {
        case .string(let value):
            return value
        default :
            return nil
        }
    }
    
    var int: Int? {
        switch self {
        case .int(let value):
            return value
         default :
            return nil
        }
    }
    
    var double: Double? {
        switch self {
        case .double(let value):
            return value
        default :
            return nil
        }
    }
    
    var bool: Bool? {
        switch self {
        case .bool(let value):
            return value
        default :
            return nil
        }
    }
    
    var dictionaryObject: [String: JSONValue]? {
        switch self {
        case .object(let value):
            return value
        default :
            return nil
        }
    }
    
    var array: [JSONValue]? {
        switch self {
        case .array(let value) :
            return value
        default :
            return nil
        }
    }
    
    var null: Any? {
        switch self {
        case .null:
            return nil
        default :
            return nil
        }
    }
}

fileprivate extension Optional {
    func or(_ other: Optional) -> Optional {
        switch self {
        case .none: return other
        case .some: return self
        }
    }
    func resolve(with error: @autoclosure () -> Error) throws -> Wrapped {
        switch self {
        case .none: throw error()
        case .some(let wrapped): return wrapped
        }
    }
}
