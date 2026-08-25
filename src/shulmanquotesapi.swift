import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension URLSession {
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        return try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: request) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let data = data, let response = response {
                    continuation.resume(returning: (data, response))
                } else {
                    continuation.resume(throwing: URLError(.unknown))
                }
            }
            task.resume()
        }
    }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

@MainActor
public class Shulmanquotesapi {
    private let api = "https://shulmanquotes.vercel.app/api"
    private var headers: [String: String]
    
    public init() {
        self.headers = [
            "charset": "utf-8",
            "Connection": "keep-alive",
            "Accept-Encoding": "deflate, zstd",
            "Accept-Language": "en-US,en;q=0.9",
            "User-Agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36"
        ]
    }
    
    private func fetchJSON(
        from urlString: String,
        method: HTTPMethod = .get,
        body: Data? = nil,
        queryParameters: [String: String]? = nil
    ) async throws -> Any {
        var urlComponents = URLComponents(string: urlString)
        if let queryParameters = queryParameters {
            urlComponents?.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        guard let url = urlComponents?.url else {
            throw NSError(domain: "Invalid URL", code: -1)
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        if let body = body {
            request.httpBody = body
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONSerialization.jsonObject(with: data)
    }
    
    public func getApiInfo() async throws -> Any {
        return try await fetchJSON(from: "\(api)/")
    }
    
    public func getQuoteById(quoteId: Int) async throws -> Any {
        return try await fetchJSON(from: "\(api)/quote/\(quoteId)")
    }
    
    public func searchQuote(q: String) async throws -> Any {
        return try await fetchJSON(
            from: "\(api)/search",
            method: .get,
            queryParameters: ["q": q]
        )
    }
    
    public func getRandomQuote() async throws -> Any {
        return try await fetchJSON(from: "\(api)/quote/random")
    }
    
    public func getQuoteList() async throws -> Any {
        return try await fetchJSON(from: "\(api)/quotes")
    }
    
    
    public func GetEpisodeProgramById(program: String, programId: Int) async throws -> Any {
        return try await fetchJSON(from: "\(api)/episodes/\(program)/\(programId)")
    }
    
    public func GetRandomEpisode(program: String) async throws -> Any {
        return try await fetchJSON(from: "\(api)/episodes/\(program)/random")
    }
    
    public func getAllProgramEpisodes(program: String) async throws -> Any {
        return try await fetchJSON(from: "\(api)/episodes/\(program)")
    }
    
    public func getAllEpisodes() async throws -> Any {
        return try await fetchJSON(from: "\(api)/episodes")
    }
    
    public func getAllLastEpisodes() async throws -> Any {
        return try await fetchJSON(from: "\(api)/last/episodes/all")
    }
    
    public func searchInEpisode(q: String) async throws -> Any {
        return try await fetchJSON(
            from: "\(api)/search/episodes",
            method: .get,
            queryParameters: ["q": q]
        )
    }
    
    public func getLastEpisode(program: String) async throws -> Any {
        return try await fetchJSON(from: "\(api)/last/episodes/\(program)")
    }

    
    public func getGithubAnalytics(username: String) async throws -> Any {
        return try await fetchJSON(from: "\(api)/github/\(username)/analytics")
    }
    
    public func getGithubLanguages(username: String) async throws -> Any {
        return try await fetchJSON(from: "\(api)/github/\(username)/")
    }
}
