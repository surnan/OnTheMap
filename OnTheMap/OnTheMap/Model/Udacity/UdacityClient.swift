//
//  UdacityClient.swift
//  OnTheMap
//
//  Created by admin on 1/31/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

class UdacityClient {
    struct UserInfo {
        static var username = ""
        static var password = ""
        static var accountRegistered = ""
        static var accountKey = ""
        static var sessionId = ""
        static var sessionExpiration = ""
    }

    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1"
        case postingSession
        case deletingSession
        case onTheMapUserData
        
        var toString: String {
            switch self {
            case .postingSession: return Endpoints.base + "/session"
            case .deletingSession: return Endpoints.base + "/session"
            case .onTheMapUserData: return Endpoints.base + "/users/" + UserInfo.username
            }
        }
        
        var url: URL {
            return URL(string: self.toString)!
        }
    }
    
    
    class func authenticateSession(name: String, password: String, completion: @escaping (Bool)-> Void){
        
        var request = URLRequest(url: Endpoints.postingSession.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
     
        let body = UdacityRequest(udacity: Credentials(username: name, password: password))
        request.httpBody = try! JSONEncoder().encode(body)
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                //Error returned on login error if all URL info is good
                completion(false)
                return
            }
            
            guard let data = data else {return}
            
            print(String(data: data, encoding: .utf8)!)
            let range = (5..<data.count)
            let newData = data.subdata(in: range)
            print(String(data: newData, encoding: .utf8)!)
            
            do {
                let dataObject = try JSONDecoder().decode(UdacityResponse.self, from: newData)
                print(dataObject)
                completion(true)
                return
            } catch let decodeErr {
                print("Unable to decode\n\(decodeErr)")
                completion(false)
                return
            }
        }.resume()
    }
        
    
    
    
    
    
}

















/*
class UdacityClient {

    
    struct UserInfo {
        static var userId = ""
        static var accountKey = ""
        static var sessionId = ""
    }
    
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1"
        case postingSession
        case deletingSession
        case onTheMapUserData
        
        var toString: String {
            switch self {
            case .postingSession: return Endpoints.base + "/session"
            case .deletingSession: return Endpoints.base + "/session"
            case .onTheMapUserData: return Endpoints.base + "/users/" + UserInfo.userId
            }
        }
        
        var url: URL {
            return URL(string: self.toString)!
        }
    }
    
    class func authenticateSession(name: String, password: String, completion: @escaping(Bool, Error?)-> Void){
        var request = URLRequest(url: UdacityClient.Endpoints.postingSession.url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
//        let testCred = UdacityLogin(udacity: Credentials(username: "4suresh@gmail.com", password: "atDZ8=Gm%=VU"))
        let userCredentialsForUdacity = UdacityRequest(udacity: Credentials(username: name, password: password))
        
        do {
            let body = try JSONEncoder().encode(userCredentialsForUdacity)
            request.httpBody = body
        } catch let encodingError{
            print("Unable to encode 'userCredentialsForUdacity -->\(userCredentialsForUdacity)\n\(encodingError)")
            completion(false, encodingError)
            return
        }
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error...
                print("Error response from URLSession(request)-->\(request)\n\(String(describing: error))")
                completion(false, error)
                return
            }
            
            guard let dataObject = data else {
                print("Unable to decode URLSession data")
                print(String(data: data ?? Data("".utf8), encoding: .utf8)!)
                completion(false, error)
                return
            }
            
            print(String(data: dataObject, encoding: .utf8)!)
            
            do{
                let temp = try JSONDecoder().decode(UdacityResponse.self, from: dataObject)
                UserInfo.userId = temp.account.key
                UserInfo.userId = temp.session.id
                completion(true, nil)
                return
            } catch let decodeErr{
                print("Unable to decode data \(decodeErr)")
                completion(false, decodeErr)
                false
            }


        }
        task.resume()
    }
}



//    var PostingSession = "https://onthemap-api.udacity.com/v1/session"
//    var deletingSession = "https://onthemap-api.udacity.com/v1/session"
//    var onTheMapUserData = "https://onthemap-api.udacity.com/v1/users/<user_id>"

*/
