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

### Init

```swift
init(text: String, receiver: MCReceiver) 
```

---