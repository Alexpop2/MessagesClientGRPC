# Models

## ```MCUser```

### Description

User model

### Fields

| field | type | get/set | description |
| ------ | ------ | ------ | ------ |
| ```id``` | **```String```** |  get |  User ID |
| ```name``` | **```String```** | get |  User name |
| ```phone``` | **```String?```** | get |  User phone |

---
## ```MCSender```

### Description

Sender struct

### Fields

| field | type | get/set | description |
| ------ | ------ | ------ | ------ |
| ```id``` | **```String```** |  get/set |  Sender ID |
| ```nickName``` | **```String```** | get/set |  Sender name |

---
## ```MCReceiver```

### Description

Receiver struct

### Fields

| field | type | get/set | description |
| ------ | ------ | ------ | ------ |
| ```id``` | **```String```** |  get/set |  Receiver ID |

### Init

```swift
init(id: String)
```

---
## ```MCMessageState```

### Description

Message state enum

### Enumeration

| case  | description |
| ------ | ------ |
| ```queued``` |  Message added to queue, because receiver is offline |
| ```sending``` |  Message is currently sending |
| ```delivered``` |  Message delivered |
| ```failed``` |  Message sending failed |
| ```unrecognized``` |  Unrecognized state (GRPC) |

---
## ```NetworkingClientError```

### Description

Code error enum

### Enumeration

| case  | raw | description |
| ------ | ------ | ------ |
| ```OK``` | 200 |  Message added to queue, because receiver is offline |
| ```FailedConnect``` | 201 |  Message is currently sending |
| ```MessageReceivedOK``` | 1000 |  Message delivered |
| ```UserNotFound``` | 404 |  Message sending failed |
| ```InvalidToken``` | 403 |  Unrecognized state (GRPC) |
| ```Unrecognized``` | 0 |  Unrecognized state (GRPC) |

---

## ```MCMessage```

### Description

Message model

### Fields

| field | type | get/set | description |
| ------ | ------ | ------ | ------ |
| ```id``` | **```String```** |  get |  Message ID |
| ```text``` | **```String```** |  get |  Message text |
| ```receiver``` | **```MCReceiver```** |  get |  Message receiver |
| ```token``` | **```String```** |  get |  Firebase token |
| ```date``` | **```Int```** |  get |  Date in unix format |
| ```state``` | **```MCMessageState```** |  get |  Message state ID |
| ```sender``` | **```MCSender```** |  get |  Message sender |
| ```code``` | **```NetworkingClientError```** |  get |  Error code |

### Init

```swift
init(text: String, receiver: MCReceiver) 
```
---

## ```MCPerformMessageData```

### Description

Perform message struct

### Fields

| field | type | get/set | description |
| ------ | ------ | ------ | ------ |
| ```phone``` | **```String```** |  get |  Message ID |
| ```messageClientToken``` | **```MCFirebaseToken```** |  get |  Firebase token |
| ```userID``` | **```String```** |  get |  User ID |
| ```userNickName``` | **```String```** |  get |  User Nickname |

### Init

```swift
init(phone: String, messageClientToken: MCFirebaseToken, userID: String, userNickName: String)
```

---

## ```MCFirebaseToken```

### Description

Firebase token struct

### Fields

| field | type | get/set | description |
| ------ | ------ | ------ | ------ |
| ```data``` | **```String```** |  get |  Firebase token |

### Init

```swift
init(data: String)
```

---

## ```MCFirebaseCustomToken```

### Description

Firebase custom token struct (Not used from version ```0.0.5```)

### Fields

| field | type | get/set | description |
| ------ | ------ | ------ | ------ |
| ```data``` | **```String```** |  get |  Firebase custom token |

### Init

```swift
init(data: String)
```

---

## ```MCAuthorizationResult```

### Description

Authorization result struct

### Fields

| field | type | get/set | description |
| ------ | ------ | ------ | ------ |
| ```data``` | **```String```** |  get |  Result string (```Successful``` or GRPC error) |
| ```token``` | **```MCFirebaseCustomToken```** |  get |  Firebase custom token (not used from version ```0.0.5```) |
| ```userID``` | **```String```** |  get |  User ID |

### Init

```swift
init(data: String, token: MCFirebaseCustomToken, userID: String)
```

---