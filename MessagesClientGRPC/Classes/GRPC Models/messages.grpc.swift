//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: messages.proto
//

//
// Copyright 2018, gRPC Authors All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
import Foundation
import Dispatch
import SwiftGRPC
import SwiftProtobuf

internal protocol Messageservice_MessageServiceSendCall: ClientCallUnary {}

fileprivate final class Messageservice_MessageServiceSendCallBase: ClientCallUnaryBase<Messageservice_Message, Messageservice_Empty>, Messageservice_MessageServiceSendCall {
  override class var method: String { return "/messageservice.MessageService/Send" }
}

internal protocol Messageservice_MessageServicePerformMessageStreamCall: ClientCallBidirectionalStreaming {
  /// Do not call this directly, call `receive()` in the protocol extension below instead.
  func _receive(timeout: DispatchTime) throws -> Messageservice_Message?
  /// Call this to wait for a result. Nonblocking.
  func receive(completion: @escaping (ResultOrRPCError<Messageservice_Message?>) -> Void) throws

  /// Send a message to the stream. Nonblocking.
  func send(_ message: Messageservice_MessageStreamRequest, completion: @escaping (Error?) -> Void) throws
  /// Do not call this directly, call `send()` in the protocol extension below instead.
  func _send(_ message: Messageservice_MessageStreamRequest, timeout: DispatchTime) throws

  /// Call this to close the sending connection. Blocking.
  func closeSend() throws
  /// Call this to close the sending connection. Nonblocking.
  func closeSend(completion: (() -> Void)?) throws
}

internal extension Messageservice_MessageServicePerformMessageStreamCall {
  /// Call this to wait for a result. Blocking.
  func receive(timeout: DispatchTime = .distantFuture) throws -> Messageservice_Message? { return try self._receive(timeout: timeout) }
}

internal extension Messageservice_MessageServicePerformMessageStreamCall {
  /// Send a message to the stream and wait for the send operation to finish. Blocking.
  func send(_ message: Messageservice_MessageStreamRequest, timeout: DispatchTime = .distantFuture) throws { try self._send(message, timeout: timeout) }
}

fileprivate final class Messageservice_MessageServicePerformMessageStreamCallBase: ClientCallBidirectionalStreamingBase<Messageservice_MessageStreamRequest, Messageservice_Message>, Messageservice_MessageServicePerformMessageStreamCall {
  override class var method: String { return "/messageservice.MessageService/PerformMessageStream" }
}

internal protocol Messageservice_MessageServiceVerifyGetCall: ClientCallUnary {}

fileprivate final class Messageservice_MessageServiceVerifyGetCallBase: ClientCallUnaryBase<Messageservice_Message, Messageservice_Empty>, Messageservice_MessageServiceVerifyGetCall {
  override class var method: String { return "/messageservice.MessageService/VerifyGet" }
}


/// Instantiate Messageservice_MessageServiceServiceClient, then call methods of this protocol to make API calls.
internal protocol Messageservice_MessageServiceService: ServiceClient {
  /// Synchronous. Unary.
  func send(_ request: Messageservice_Message, metadata customMetadata: Metadata) throws -> Messageservice_Empty
  /// Asynchronous. Unary.
  func send(_ request: Messageservice_Message, metadata customMetadata: Metadata, completion: @escaping (Messageservice_Empty?, CallResult) -> Void) throws -> Messageservice_MessageServiceSendCall

  /// Asynchronous. Bidirectional-streaming.
  /// Use methods on the returned object to stream messages,
  /// to wait for replies, and to close the connection.
  func performMessageStream(metadata customMetadata: Metadata, completion: ((CallResult) -> Void)?) throws -> Messageservice_MessageServicePerformMessageStreamCall

  /// Synchronous. Unary.
  func verifyGet(_ request: Messageservice_Message, metadata customMetadata: Metadata) throws -> Messageservice_Empty
  /// Asynchronous. Unary.
  func verifyGet(_ request: Messageservice_Message, metadata customMetadata: Metadata, completion: @escaping (Messageservice_Empty?, CallResult) -> Void) throws -> Messageservice_MessageServiceVerifyGetCall

}

internal extension Messageservice_MessageServiceService {
  /// Synchronous. Unary.
  func send(_ request: Messageservice_Message) throws -> Messageservice_Empty {
    return try self.send(request, metadata: self.metadata)
  }
  /// Asynchronous. Unary.
  func send(_ request: Messageservice_Message, completion: @escaping (Messageservice_Empty?, CallResult) -> Void) throws -> Messageservice_MessageServiceSendCall {
    return try self.send(request, metadata: self.metadata, completion: completion)
  }

  /// Asynchronous. Bidirectional-streaming.
  func performMessageStream(completion: ((CallResult) -> Void)?) throws -> Messageservice_MessageServicePerformMessageStreamCall {
    return try self.performMessageStream(metadata: self.metadata, completion: completion)
  }

  /// Synchronous. Unary.
  func verifyGet(_ request: Messageservice_Message) throws -> Messageservice_Empty {
    return try self.verifyGet(request, metadata: self.metadata)
  }
  /// Asynchronous. Unary.
  func verifyGet(_ request: Messageservice_Message, completion: @escaping (Messageservice_Empty?, CallResult) -> Void) throws -> Messageservice_MessageServiceVerifyGetCall {
    return try self.verifyGet(request, metadata: self.metadata, completion: completion)
  }

}

internal final class Messageservice_MessageServiceServiceClient: ServiceClientBase, Messageservice_MessageServiceService {
  /// Synchronous. Unary.
  internal func send(_ request: Messageservice_Message, metadata customMetadata: Metadata) throws -> Messageservice_Empty {
    return try Messageservice_MessageServiceSendCallBase(channel)
      .run(request: request, metadata: customMetadata)
  }
  /// Asynchronous. Unary.
  internal func send(_ request: Messageservice_Message, metadata customMetadata: Metadata, completion: @escaping (Messageservice_Empty?, CallResult) -> Void) throws -> Messageservice_MessageServiceSendCall {
    return try Messageservice_MessageServiceSendCallBase(channel)
      .start(request: request, metadata: customMetadata, completion: completion)
  }

  /// Asynchronous. Bidirectional-streaming.
  /// Use methods on the returned object to stream messages,
  /// to wait for replies, and to close the connection.
  internal func performMessageStream(metadata customMetadata: Metadata, completion: ((CallResult) -> Void)?) throws -> Messageservice_MessageServicePerformMessageStreamCall {
    return try Messageservice_MessageServicePerformMessageStreamCallBase(channel)
      .start(metadata: customMetadata, completion: completion)
  }

  /// Synchronous. Unary.
  internal func verifyGet(_ request: Messageservice_Message, metadata customMetadata: Metadata) throws -> Messageservice_Empty {
    return try Messageservice_MessageServiceVerifyGetCallBase(channel)
      .run(request: request, metadata: customMetadata)
  }
  /// Asynchronous. Unary.
  internal func verifyGet(_ request: Messageservice_Message, metadata customMetadata: Metadata, completion: @escaping (Messageservice_Empty?, CallResult) -> Void) throws -> Messageservice_MessageServiceVerifyGetCall {
    return try Messageservice_MessageServiceVerifyGetCallBase(channel)
      .start(request: request, metadata: customMetadata, completion: completion)
  }

}
