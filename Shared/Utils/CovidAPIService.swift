//
//  CovidAPIService.swift
//  CovidTracker
//
//  Created by Sean.S.Nguyen on 22/12/20.
//

import Foundation

class CovidAPIService {
    
    static let shared = CovidAPIService()
    let apiSettings: APISettings
    
    // MARK: Typealias
    typealias covidDataAPIResponse = Result<Data, NetworkError>
    
    private init() {
        self.apiSettings = CovidAPIService.getAPISettings()!
    }
    
    // MARK: Functions
    func getCovidData(url: String, queryParam: Dictionary<String, String>, completionHander: @escaping (covidDataAPIResponse) -> Void) {
        
        guard var urlBuilder = URLComponents(string: url) else {
            completionHander(.failure(.invalidURL))
            return
        }

        var queryItems: [URLQueryItem] = []
        for (queryKey, queryValue) in queryParam {
            queryItems.append(URLQueryItem(name: queryKey, value: queryValue))
        }
        urlBuilder.queryItems = queryItems

        var request = URLRequest(url: urlBuilder.url!)
        request.httpMethod = "GET"
        request.setValue(apiSettings.x_rapidapi_key, forHTTPHeaderField: "x-rapidapi-key")
        request.setValue(apiSettings.x_rapidapi_host, forHTTPHeaderField: "x-rapidapi-host")
        request.setValue(apiSettings.useQueryString, forHTTPHeaderField: "useQueryString")
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    completionHander(.success(data))
                }
            } else if error != nil {
                completionHander(.failure(.invalidAPIRequest))
            }
        }).resume()
    }
    
    static func getAPISettings() -> APISettings? {
        let decoder = PropertyListDecoder()
        let url = Bundle.main.url(forResource: "Api-keys", withExtension: "plist")!
        
        if let data = try? Data(contentsOf: url) {
            if let apiSettings = try? decoder.decode(APISettings.self, from: data) {
                return apiSettings
            }
        }
        return nil
    }
}


enum NetworkError: Error {
    case invalidURL
    case invalidAPIRequest
}

struct APISettings: Codable {
    let x_rapidapi_key: String
    let x_rapidapi_host: String
    let useQueryString: String
}
