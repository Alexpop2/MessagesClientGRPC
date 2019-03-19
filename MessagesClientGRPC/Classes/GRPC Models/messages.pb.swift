// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: messages.proto
//
// For information on using the generated types, please see the documenation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that your are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

enum Messageservice_MessageState: SwiftProtobuf.Enum {
  typealias RawValue = Int
  case queued // = 0
  case sending // = 1
  case delivered // = 2
  case failed // = 3
  case UNRECOGNIZED(Int)

  init() {
    self = .queued
  }

  init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .queued
    case 1: self = .sending
    case 2: self = .delivered
    case 3: self = .failed
    default: self = .UNRECOGNIZED(rawValue)
    }
  }

  var rawValue: Int {
    switch self {
    case .queued: return 0
    case .sending: return 1
    case .delivered: return 2
    case .failed: return 3
    case .UNRECOGNIZED(let i): return i
    }
  }

}

#if swift(>=4.2)

extension Messageservice_MessageState: CaseIterable {
  // The compiler won't synthesize support with the UNRECOGNIZED case.
  static var allCases: [Messageservice_MessageState] = [
    .queued,
    .sending,
    .delivered,
    .failed,
  ]
}

#endif  // swift(>=4.2)

struct Messageservice_Empty {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Messageservice_Receiver {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var id: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Messageservice_Sender {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var id: String = String()

  var nickName: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Messageservice_Message {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var id: String {
    get {return _storage._id}
    set {_uniqueStorage()._id = newValue}
  }

  var text: String {
    get {return _storage._text}
    set {_uniqueStorage()._text = newValue}
  }

  var receiver: Messageservice_Receiver {
    get {return _storage._receiver ?? Messageservice_Receiver()}
    set {_uniqueStorage()._receiver = newValue}
  }
  /// Returns true if `receiver` has been explicitly set.
  var hasReceiver: Bool {return _storage._receiver != nil}
  /// Clears the value of `receiver`. Subsequent reads from it will return its default value.
  mutating func clearReceiver() {_uniqueStorage()._receiver = nil}

  var token: String {
    get {return _storage._token}
    set {_uniqueStorage()._token = newValue}
  }

  var date: Int32 {
    get {return _storage._date}
    set {_uniqueStorage()._date = newValue}
  }

  var state: Messageservice_MessageState {
    get {return _storage._state}
    set {_uniqueStorage()._state = newValue}
  }

  var sender: Messageservice_Sender {
    get {return _storage._sender ?? Messageservice_Sender()}
    set {_uniqueStorage()._sender = newValue}
  }
  /// Returns true if `sender` has been explicitly set.
  var hasSender: Bool {return _storage._sender != nil}
  /// Clears the value of `sender`. Subsequent reads from it will return its default value.
  mutating func clearSender() {_uniqueStorage()._sender = nil}

  var code: Int32 {
    get {return _storage._code}
    set {_uniqueStorage()._code = newValue}
  }

  var phone: String {
    get {return _storage._phone}
    set {_uniqueStorage()._phone = newValue}
  }

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

struct Messageservice_MessageStreamRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var login: String = String()

  var token: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "messageservice"

extension Messageservice_MessageState: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "queued"),
    1: .same(proto: "sending"),
    2: .same(proto: "delivered"),
    3: .same(proto: "failed"),
  ]
}

extension Messageservice_Empty: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Empty"
  static let _protobuf_nameMap = SwiftProtobuf._NameMap()

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let _ = try decoder.nextFieldNumber() {
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Messageservice_Empty, rhs: Messageservice_Empty) -> Bool {
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Messageservice_Receiver: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Receiver"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "id"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self.id)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.id.isEmpty {
      try visitor.visitSingularStringField(value: self.id, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Messageservice_Receiver, rhs: Messageservice_Receiver) -> Bool {
    if lhs.id != rhs.id {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Messageservice_Sender: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Sender"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "id"),
    2: .same(proto: "nickName"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self.id)
      case 2: try decoder.decodeSingularStringField(value: &self.nickName)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.id.isEmpty {
      try visitor.visitSingularStringField(value: self.id, fieldNumber: 1)
    }
    if !self.nickName.isEmpty {
      try visitor.visitSingularStringField(value: self.nickName, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Messageservice_Sender, rhs: Messageservice_Sender) -> Bool {
    if lhs.id != rhs.id {return false}
    if lhs.nickName != rhs.nickName {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Messageservice_Message: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Message"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "id"),
    2: .same(proto: "text"),
    3: .same(proto: "receiver"),
    4: .same(proto: "token"),
    5: .same(proto: "date"),
    6: .same(proto: "state"),
    7: .same(proto: "sender"),
    8: .same(proto: "code"),
    9: .same(proto: "phone"),
  ]

  fileprivate class _StorageClass {
    var _id: String = String()
    var _text: String = String()
    var _receiver: Messageservice_Receiver? = nil
    var _token: String = String()
    var _date: Int32 = 0
    var _state: Messageservice_MessageState = .queued
    var _sender: Messageservice_Sender? = nil
    var _code: Int32 = 0
    var _phone: String = String()

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _id = source._id
      _text = source._text
      _receiver = source._receiver
      _token = source._token
      _date = source._date
      _state = source._state
      _sender = source._sender
      _code = source._code
      _phone = source._phone
    }
  }

  fileprivate mutating func _uniqueStorage() -> _StorageClass {
    if !isKnownUniquelyReferenced(&_storage) {
      _storage = _StorageClass(copying: _storage)
    }
    return _storage
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    _ = _uniqueStorage()
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      while let fieldNumber = try decoder.nextFieldNumber() {
        switch fieldNumber {
        case 1: try decoder.decodeSingularStringField(value: &_storage._id)
        case 2: try decoder.decodeSingularStringField(value: &_storage._text)
        case 3: try decoder.decodeSingularMessageField(value: &_storage._receiver)
        case 4: try decoder.decodeSingularStringField(value: &_storage._token)
        case 5: try decoder.decodeSingularInt32Field(value: &_storage._date)
        case 6: try decoder.decodeSingularEnumField(value: &_storage._state)
        case 7: try decoder.decodeSingularMessageField(value: &_storage._sender)
        case 8: try decoder.decodeSingularInt32Field(value: &_storage._code)
        case 9: try decoder.decodeSingularStringField(value: &_storage._phone)
        default: break
        }
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if !_storage._id.isEmpty {
        try visitor.visitSingularStringField(value: _storage._id, fieldNumber: 1)
      }
      if !_storage._text.isEmpty {
        try visitor.visitSingularStringField(value: _storage._text, fieldNumber: 2)
      }
      if let v = _storage._receiver {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 3)
      }
      if !_storage._token.isEmpty {
        try visitor.visitSingularStringField(value: _storage._token, fieldNumber: 4)
      }
      if _storage._date != 0 {
        try visitor.visitSingularInt32Field(value: _storage._date, fieldNumber: 5)
      }
      if _storage._state != .queued {
        try visitor.visitSingularEnumField(value: _storage._state, fieldNumber: 6)
      }
      if let v = _storage._sender {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 7)
      }
      if _storage._code != 0 {
        try visitor.visitSingularInt32Field(value: _storage._code, fieldNumber: 8)
      }
      if !_storage._phone.isEmpty {
        try visitor.visitSingularStringField(value: _storage._phone, fieldNumber: 9)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Messageservice_Message, rhs: Messageservice_Message) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._id != rhs_storage._id {return false}
        if _storage._text != rhs_storage._text {return false}
        if _storage._receiver != rhs_storage._receiver {return false}
        if _storage._token != rhs_storage._token {return false}
        if _storage._date != rhs_storage._date {return false}
        if _storage._state != rhs_storage._state {return false}
        if _storage._sender != rhs_storage._sender {return false}
        if _storage._code != rhs_storage._code {return false}
        if _storage._phone != rhs_storage._phone {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Messageservice_MessageStreamRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".MessageStreamRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "login"),
    2: .same(proto: "token"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self.login)
      case 2: try decoder.decodeSingularStringField(value: &self.token)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.login.isEmpty {
      try visitor.visitSingularStringField(value: self.login, fieldNumber: 1)
    }
    if !self.token.isEmpty {
      try visitor.visitSingularStringField(value: self.token, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Messageservice_MessageStreamRequest, rhs: Messageservice_MessageStreamRequest) -> Bool {
    if lhs.login != rhs.login {return false}
    if lhs.token != rhs.token {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
