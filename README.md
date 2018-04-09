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


Credits
=======

* by Andrew Kochulab
* <a href="http://facebook.com/andrewkochulab">Facebook page</a>
* <a href="https://www.linkedin.com/in/andrew-kochulab/">Linkedin page</a>
