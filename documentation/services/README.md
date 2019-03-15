# Services

Services protocols that working with server

**Note:**
Possible call result for all callbacks with ```CallResult```:

| GRPC Code | description |
| ------ | ------ |
| ```OK``` |  Completed with no errors |

## ```IMCNetworkService```

### Functions

```swift
func addConnectivityObserver(callback: @escaping (Channel.ConnectivityState) -> Void)
```
**Description:**
Connection state observer

**Arguments:**

| argument | description |
| ------ | ------ |
| ```callback``` | Result callback closure |

---

```swift
func getCurrentConnectionState(callback: @escaping(Channel.ConnectivityState) -> Void)
```
**Description:**
Get current connection state

**Arguments:**

| argument | description |
| ------ | ------ |
| ```callback``` | Result callback closure |

---

## ```IMCUserService```

**Parent protocol:**
```IMCNetworkService```

### Functions

```swift
func setUserName(token: String, name: String, completion: @escaping (CallResult?) -> Void)
```

**Description:**
Setting user name method

**Arguments:**

| argument | description |
| ------ | ------ |
| ```token``` |  Firebase token |
| ```name``` | Name to set |
| ```completion``` | Result callback |

**CallResult Errors:**

| GRPC Code | description |
| ------ | ------ |
| ```UNAUTHENTICATED``` |  Token check failed |
| ```ALREADY_EXISTS``` | This name is already used |
| ```CANCELLED``` | You cannot use this name |

---
```swift
func getUserBy(phone: String, completion: @escaping (MCUser?, CallResult?) -> Void)
```
**Description:**
Get user by phone

**Arguments:**

| argument | description |
| ------ | ------ |
| ```phone``` | User's phone to find |
| ```completion``` | User and result callback |

**CallResult Errors:**

| GRPC Code | description |
| ------ | ------ |
| ```UNAUTHENTICATED``` |  Token check failed |
| ```NOT_FOUND``` | User with this phone not registered |

**Notes:**
- Must perform message stream first
---
```swift
func getUserBy(id: String, completion: @escaping (MCUser?, CallResult?) -> Void)
```
**Description:**
Get user by ID

**Arguments:**

| argument | description |
| ------ | ------ |
| ```id``` | User's id to find |
| ```completion``` | User and result callback |

**CallResult Errors:**

| GRPC Code | description |
| ------ | ------ |
| ```UNAUTHENTICATED``` |  Token check failed |
| ```NOT_FOUND``` | User with this name not registered |

**Notes:**
- This method return user with ```nil``` phone
- Must perform message stream first
---
```swift
func getUserBy(name: String, completion: @escaping (MCUser?, CallResult?) -> Void)
```
**Description:**
Get user by name

**Arguments:**

| argument | description |
| ------ | ------ |
| ```name``` | User's name to find |
| ```completion``` | User and result callback |

**CallResult Errors:**

| GRPC Code | description |
| ------ | ------ |
| ```UNAUTHENTICATED``` |  Token check failed |
| ```NOT_FOUND``` | User with this id not registered |

**Notes:**
- This method return user with ```nil``` phone
- Must perform message stream first

---
```swift
func getKnownRegisteredUsersBy(phones: [String], completion: @escaping ([MCUser], CallResult?) -> Void)
```
**Description:**
Get registered users with phones string array.

**Arguments:**

| argument | description |
| ------ | ------ |
| ```phones``` | Users phones in array |
| ```completion``` | Registered users list and result callback |

**CallResult Errors:**

| GRPC Code | description |
| ------ | ------ |
| ```UNAUTHENTICATED``` |  Token check failed |

**Notes:**
- Must perform message stream first
---

## ```IMCAuthService```

**Parent protocol:**
```IMCNetworkService```


### Functions

```swift
func authorize(with token: MCFirebaseToken, completion: @escaping (MCAuthorizationResult?, CallResult?) -> Void)
```

**Description:**
Authorization on server method

**Arguments:**

| argument | description |
| ------ | ------ |
| ```token``` |  Firebase token |
| ```completion``` | Result callback |

---

## ```IMCMessageService```

**Parent protocol:**
```IMCNetworkService```

### Functions

```swift
func send(message: MCMessage, completion: @escaping (CallResult?) -> Void)
```

**Description:**
Method for send message.

**Arguments:**

| argument | description |
| ------ | ------ |
| ```token``` |  Firebase token |
| ```completion``` | Result callback |

**CallResult Errors:**

| GRPC Code | description |
| ------ | ------ |
| ```UNAUTHENTICATED``` |  Token check failed |
| ```NOT_FOUND``` | Receiver user not registered |

**Notes:**
- Must perform message stream first
---
```swift
func performMessageStream(data: MCPerformMessageData, completion: @escaping (MCMessage) -> Void)
```
**Description:**
Perform message stream

**Arguments:**

| argument | description |
| ------ | ------ |
| ```data``` |  Perform message data |
| ```completion``` | Receiving messages from server |

---