//
//  Networking.swift
//  RazeCore
//
//  Created by Contingencia IS on 30/05/2020.

import Foundation

protocol NetworkSession {
    func get (from url: URL, completionHandler: @escaping (Data?, Error?) -> Void)
    func post(with request: URLRequest, completionHandler: @escaping (Data?, Error?)-> Void)
}
extension URLSession:NetworkSession {
    func post(with request: URLRequest, completionHandler: @escaping (Data?, Error?) -> Void) {
        let task = dataTask(with: request){ data, _, error in
            completionHandler(data,error)
        }
        task.resume()
    }
    
    func get(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
        let task = dataTask(with: url){ data, _, error in
            completionHandler(data,error)
            
            }
        task.resume()
    }
    
    
}
extension RazeCore {
    public class Networking {
        
        /// Responsible for handling networking
        /// - Warning : Must create before using public APIs
        public class Manager {
            
            internal var session:NetworkSession = URLSession.shared
            public init(){}
            /// Call to live internet to retrieve Data form a specific location
            /// - Parameters:
            ///   - url: The location you wish to fetch data from
            ///   - completionHandler: Returns a resul object wich the status of the request
            public func loadData(from url: URL, completionHandler:
                @escaping (NetworkResult<Data>) -> Void){
                session.get(from: url){data, error in
                    let result = data.map(NetworkResult<Data>.success) ??
                    .failure(error)
                    completionHandler(result)
                }
                
            }
            
            /// Calls to the live internet to send data to specific location
            /// - Parameters:
            ///   - url: The location you wish to send data to
            ///   - body: The object you wish to send over networl
            ///   - completationHandler: Returns a result object wich signifies the status of the request
            public func sendData<I: Codable>(to url: URL, body: I,
                                 completationHandler: @escaping(NetworkResult<Data>) -> Void ){
                var request = URLRequest(url: url)
                do {
                   let httpBody =  try JSONEncoder().encode(body)
                    request.httpBody = httpBody
                    session.post(with: request) { data, error in
                        let result = data.map(NetworkResult<Data>.success) ??
                        .failure(error)
                        completationHandler(result)
                        
                    }
                } catch let error {
                    return completationHandler(.failure(error))
                }
                
                
                
            }
        
            public enum NetworkResult<Value> {
                case success(Value)
                case failure(Error?)
            }
        }
    }
}
