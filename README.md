# MessagesClientGRPC (Pod)

Pod for working with beetlab message server

### Installation

Need podspec for install
```ruby
source 'https://github.com/Alexpop2/PodSpecs.git'
```

Adding pod to Podfile

```ruby
pod 'MessagesClientGRPC'
```

In code you need to configure it with SSL Keys

```swift
NetworkingClient.configure(address: "domain.example.com:port",
                           caCertificate: "caCertificate data HERE",
                           clientCertificate: "clientCertificate data HERE",
                           clientKey: "clientKey data HERE",
                           sslDomain: "domain.example.com")
```

### Documentation



|  | README |
| ------ | ------ |
| NetworkingClient | [documentation/networkingclient/README.md][PlNC] |
| Services | [documentation/services/README.md][PlSS] |
| Models | [documentation/models/README.md][PlMS] |


   [PlNC]: <https://github.com/Alexpop2/MessagesClientGRPC/tree/master/MessagesClientGRPC/documentation/networkingclient/README.md>
   [PlSS]: <https://github.com/Alexpop2/MessagesClientGRPC/tree/master/MessagesClientGRPC/documentation/services/README.md>
   [PlMS]: <https://github.com/Alexpop2/MessagesClientGRPC/tree/master/MessagesClientGRPC/documentation/models/README.md>