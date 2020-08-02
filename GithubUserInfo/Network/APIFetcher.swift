

import Foundation
import Combine
import Alamofire

protocol GithubFetchable {
    func repositories(userName: String) -> AnyPublisher<Repositories, GithubError>
}


class APIFetcher {
    
}

// MARK: - OpenWeatherMap API
private extension APIFetcher {
    struct GithubAPI {
        static let scheme = "https"
        static let host = "api.github.com"
        static let graphQLPath = "/graphql/"
        
        
        
        #warning("Fill this with your Github Token")
        static let token = "f6e4f5d3d6f3e6d4d5a1dd15f3f35ae6a69a4a57"
    }
    
    func makeRepositoriesComponent(
        withUserName userName: String
    ) -> URLComponents {
        var components = URLComponents()
        components.scheme = GithubAPI.scheme
        components.host = GithubAPI.host
        components.path = "/users/\(userName)/repos"
        
        return components
    }
    
    func makeUserComponent() -> URLComponents {
        var components = URLComponents()
        components.scheme = GithubAPI.scheme
        components.host = GithubAPI.host
        components.path = "/graphql"
        
        return components
    }
    
    func makeUserQuery(with UserName: String) -> [String : Any] {
        return ["query": "query User {user(login: \"\(UserName)\"){avatarUrl,company,companyHTML,createdAt,email,followers{totalCount},following{totalCount}, isHireable,id,location,login,name,url,websiteUrl,twitterUsername}}" as AnyObject] as [String : Any]
    }
}

//MARK: - WeatherFetchable
extension APIFetcher: GithubFetchable {
    func repositories(userName: String) -> AnyPublisher<Repositories, GithubError> {
        return request(with: makeRepositoriesComponent(withUserName: userName))
    }
    
    func user(userName: String) -> AnyPublisher<UserData, GithubError> {
        return requestGraphQL(with: makeUserComponent(), userName)
    }
    
    
    private func requestGraphQL<T>(with  components: URLComponents, _ userName: String) -> AnyPublisher<T, GithubError> where T: Codable {
        guard let url = components.url else {
            let error = GithubError.network(description: "URL couldn't be created")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        let parameters = makeUserQuery(with: userName)
        var data = Data()
        
        do {
            data = try JSONSerialization.data(withJSONObject: parameters, options: [])
        }
        catch{
            data = Data()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = ["Authorization": "Bearer \(GithubAPI.token)"]
        request.httpBody = data
        
        return Future<T, GithubError> { (promise) in
            
            
            
            AF.request(request).responseDecodable(completionHandler: { (response: DataResponse<T,AFError>) in
                print("API => REQUEST => \(String(describing: response.request))")
                print("API => STATUS CODE => \(response.response?.statusCode ?? -1)")
                switch response.result {
                case .success(let value):
                    print("API => Success => \(value)")
                    promise(.success(value))
                case .failure(let error):
                    switch error {
                    case .responseSerializationFailed(let reason):
                        if case .inputDataNilOrZeroLength = reason  {
                            print("API => Success => Empty Response")
                            promise(.success(EmptyResponse() as! T))
                        }
                        print("API => Fail => \(reason)")
                        promise(.failure(GithubError.failing(description: error.errorDescription ?? "Error")))
                    default:
                        print("API => Fail => \(error)")
                        promise(.failure(GithubError.failing(description: error.localizedDescription)))
                    }
                }
            })
        }.eraseToAnyPublisher()
        
    }
    
    private func request<T>(with components: URLComponents) -> AnyPublisher<T, GithubError> where T: Decodable {
        guard let url = components.url else {
            let error = GithubError.network(description: "URL couldn't be created")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        
        return Future<T, GithubError> { (promise) in
            _ = AF.request(url, method: .get).responseDecodable(completionHandler: { (response: DataResponse<T,AFError>) in
                print("API => REQUEST => \(String(describing: response.request))")
                print("API => STATUS CODE => \(response.response?.statusCode ?? -1)")
                switch response.result {
                case .success(let value):
                    print("API => Success => \(value)")
                    promise(.success(value))
                case .failure(let error):
                    switch error {
                    case .responseSerializationFailed(let reason):
                        if case .inputDataNilOrZeroLength = reason  {
                            print("API => Success => Empty Response")
                            promise(.success(EmptyResponse() as! T))
                        }
                        print("API => Fail => \(reason)")
                        promise(.failure(GithubError.failing(description: error.errorDescription ?? "Error")))
                    default:
                        print("API => Fail => \(error)")
                        promise(.failure(GithubError.failing(description: error.localizedDescription)))
                    }
                }
            })
        }.eraseToAnyPublisher()
    }
}
