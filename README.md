# Shulmanquotesapi
api for shulmanquotes.vercel.app  This API provides access to a collection of quotes by Catherine Shulman. Users can retrieve all quotes, get a random quote, or fetch a specific quote by its ID.
# main
```swift
import Foundation
import shulmanquotesapi
let client = Shulmanquotesapi()

do {
    let api_info = try await client.get_api_info()
    print(api_info)
} catch {
    print("Error: \(error)")
}
```

# Launch (your script)
```
swift run
```
