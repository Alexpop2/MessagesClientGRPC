# NetworkingClient

Client for working with server



### Fields

| Field | Type | Description |
| ------ | ------ | ------ |
| **userService** | ```IMCUserService```  | User service |
| **authService** | ```IMCAuthService```  | Authorization service |
| **messageService** | ```IMCMessageService```  | Message service |
| **shared** | ```NetworkingClient```  | Shared instance of configured NetworkingClient |
| **networkReachability** | ```Bool? { get }``` | Get current rechability of network(After switching WIFI->Cellular and vice versa) |

[Services README][Services]

### Functions

Configuring connection to server

```swift
static func configure(address: String,
                      caCertificate: String,
                      clientCertificate: String,
                      clientKey: String,
                      sslDomain: String)
```

Setting callback for connection state changed (WIFI->Cellular and vice versa).

```swift
func configureStateCallback(completion: @escaping (ClientNetworkMonitor.State) -> Void)
```

   [Services]: <https://github.com/Alexpop2/MessagesClientGRPC/tree/master/documentation/services/README.md>