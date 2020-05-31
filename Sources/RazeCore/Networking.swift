//
//  Networking.swift
//  RazeCore
//
//  Created by Contingencia IS on 30/05/2020.

import Foundation

protocol NetworkSession {
    func get (from url: URL, completionHandler: @escaping (Data?, Error?) -> Void)
}
extension URLSession:NetworkSession {
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
            public enum NetworkResult<Value> {
                case success(Value)
                case failure(Error?)
            }
        }
    }
}
