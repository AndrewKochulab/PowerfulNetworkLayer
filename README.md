# PowerfulNetworkLayer

![](https://cdn-images-1.medium.com/max/1124/0*GYklXzMrfhKDjGnt.png)

I would like to present you an easy way to communicate with your API. It's light network layer, which in all cases guided by SOLID principles.

![License](https://poser.pugx.org/buonzz/laravel-4-freegeoip/license.svg)

Structure
============

### Network layer consists of six parts:
- Environment
- Request
- Response
- Operation
- Dispatcher
- Service

### Environment

Describes your API information: the host URL, the caching policy, also contains a headers property, which can be global for all your requests.

### Request

Describes your network request. You can create any request you want: GET, POST, DELETE, etc. Also, you can create a download request if needed.

### Response

An object, which contains information about data you received from the request by the operation, which described below. It can be a local file, mapped object, etc.

### Operation

An instance, which consists of the strongly typed requests and response objects. It executes by the dispatcher.

### Dispatcher

The Dispatcher responsible for the executes a request. By default, the library has two dispatchers, called `Network Dispatcher` and `Download Dispatcher`, but you could inherit `Base Dispatcher` and write your own class if needed.

### Service

And the last one is Service. A service is an object, which executes your operations by dispatchers you provided.


Requirements
============

* Swift >= 3.0
* iOS >= 8.0

Installation
============

PowerfulNetworkLayer is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'PowerfulNetworkLayer'
```

HOW TO USE
==========

After installation library via CocoaPods dependency manager, you could import this library by writing next command in files, which will be using it.

```swift
import PowerfulNetworkLayer
```

If you want to create custom request, for example, request to send (POST data) some information, you could write code like below:

```swift
import Foundation
import Alamofire
import PowerfulNetworkLayer

final class SignUpRequest: BaseRequest<DataRequest> {
    private let email: String
    private let firstName: String
    private let lastName: String
    private let password: String
    
    override var path: String {
        return "auth/signup"
    }
    
    override var method: HTTPMethod {
        return .post
    }
    
    override var encoding: ParameterEncoding {
        return JSONEncoding()
    }
    
    override var parameters: Parameters {
        return [
            "email" : email,
            "first_name" : firstName,
            "last_name" : lastName,
            "password" : password
        ]
    }
    
    init(email: String, firstName: String, lastName: String, password: String) {
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.password = password
    }
}
```

You also could create a response (if needed), the code looks like this:

```swift
import Foundation
import ObjectMapper
import PowerfulNetworkLayer

final class SignUpResponse: Response, Mappable {
    let user: User
    let token: AccessToken

    required init?(map: Map) { }
    
    func mapping(map: Map) {
        user <- map["user"]
        token <- map["access_token"]
    }
}
```

Each request should not exist without operation. The operation initialized with the request, which executes and returns a response by promise.
You could override execute method in inherited `Operation` class and saved some properties in service if needed like below.

```swift
import Foundation
import PromiseKit
import PowerfulNetworkLayer

final class SignUpOperation: DispatchOperation<SignUpRequest, SignUpResponse> {
    override func execute<ServiceType>(
        in dispatcher: Dispatcher,
        by service: ServiceType
    ) -> Promise<SignUpResponse>
        where ServiceType : AuthService {
            return super.execute(in: dispatcher, by: service).tap { result in
                switch result {
                    case .fulfilled(let response):
                        service.user = response.user
                    
                    case .rejected(_):
                        break
                }
            }
    }
}
```

Also, you have an example project, where you can see how to use this framework.


Credits
=======

* by Andrew Kochulab
* <a href="http://facebook.com/andrewkochulab">Facebook page</a>
* <a href="https://www.linkedin.com/in/andrew-kochulab/">Linkedin page</a>
