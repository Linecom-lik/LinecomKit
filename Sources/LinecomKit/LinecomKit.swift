#if !os(macOS)
import UIKit
#endif
import Foundation
import Alamofire
import SwiftyJSON

private let void: Void = ()

public class LinecomKit {
    //MARK: Network
    public class NetworkAction {
        public static let shared = NetworkAction()
        
        @discardableResult
        open func request(_ convertible: URLConvertible, method: HTTPMethod = .get, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil, interceptor: RequestInterceptor? = nil, requestModifier: Session.RequestModifier? = nil) -> DataRequest {
            let convertible = RequestConvertible(url: convertible, method: method, parameters: parameters, encoding: encoding, headers: headers, requestModifier: requestModifier)
            return AF.request(convertible)
        }
        open func requestJSON(_ convertible: URLConvertible, method: HTTPMethod = .get, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil, interceptor: RequestInterceptor? = nil, requestModifier: Session.RequestModifier? = nil, callback: @escaping ((JSON, Bool) -> Void)) {
            let convertible = RequestConvertible(url: convertible, method: method, parameters: parameters, encoding: encoding, headers: headers, requestModifier: requestModifier)
            AF.request(convertible).responseData { response in
                let data = response.data
                if data != nil {
                    do {
                        let json = try JSON(data: data!)
                        callback(json, true)
                    } catch {
                        callback(JSON(), false)
                    }
                } else {
                    callback(JSON(), false)
                }
            }
        }
        open func requestString(_ convertible: URLConvertible, method: HTTPMethod = .get, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil, interceptor: RequestInterceptor? = nil, requestModifier: Session.RequestModifier? = nil, callback: @escaping ((String, Bool) -> Void)) {
            let convertible = RequestConvertible(url: convertible, method: method, parameters: parameters, encoding: encoding, headers: headers, requestModifier: requestModifier)
            AF.request(convertible).responseData { response in
                let data = response.data
                if data != nil {
                    let str = String(data: data!, encoding: .utf8)
                    if str != nil {
                        callback(str!, true)
                    } else {
                        callback("", false)
                    }
                } else {
                    callback("", false)
                }
            }
        }
        
        open func requestJSON(_ convertible: URLConvertible, method: HTTPMethod = .get, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil, interceptor: RequestInterceptor? = nil, requestModifier: Session.RequestModifier? = nil) async -> Result<JSON, Void> {
            await withCheckedContinuation { continuation in
                let convertible = RequestConvertible(url: convertible, method: method, parameters: parameters, encoding: encoding, headers: headers, requestModifier: requestModifier)
                AF.request(convertible).responseData { response in
                    let data = response.data
                    if data != nil {
                        do {
                            let json = try JSON(data: data!)
                            continuation.resume(returning: .success(json))
                        } catch {
                            continuation.resume(returning: .failure(void))
                        }
                    } else {
                        continuation.resume(returning: .failure(void))
                    }
                }
            }
        }
        open func requestString(_ convertible: URLConvertible, method: HTTPMethod = .get, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil, interceptor: RequestInterceptor? = nil, requestModifier: Session.RequestModifier? = nil) async -> Result<String, Void> {
            await withCheckedContinuation { continuation in
                let convertible = RequestConvertible(url: convertible, method: method, parameters: parameters, encoding: encoding, headers: headers, requestModifier: requestModifier)
                AF.request(convertible).responseData { response in
                    let data = response.data
                    if data != nil {
                        let str = String(data: data!, encoding: .utf8)
                        if str != nil {
                            continuation.resume(returning: .success(str!))
                        } else {
                            continuation.resume(returning: .failure(void))
                        }
                    } else {
                        continuation.resume(returning: .failure(void))
                    }
                }
            }
        }
        
        private struct RequestConvertible: URLRequestConvertible {
            let url: URLConvertible
            let method: HTTPMethod
            let parameters: Parameters?
            let encoding: ParameterEncoding
            let headers: HTTPHeaders?
            let requestModifier: Session.RequestModifier?

            func asURLRequest() throws -> URLRequest {
                var request = try URLRequest(url: url, method: method, headers: headers)
                try requestModifier?(&request)

                return try encoding.encode(request, with: parameters)
            }
        }
    }
}

#if os(iOS)
public protocol AlertIconAnimatable {
    func animate()
}
#endif

@frozen
public enum Result<Success, Failure> {
    case success(Success)
    case failure(Failure)
}
