# Shulmanquotesapi
api for shulmanquotes.vercel.app  This API provides access to a collection of quotes by Catherine Shulman. Users can retrieve all quotes, get a random quote, or fetch a specific quote by its ID.
# main
```swift
import Foundation
import shulmanquotesapi
let client = Shulmanquotesapi()

do {
    let apiInfo = try await client.getApiInfo()
    print(apiInfo)
} catch {
    print("Error: \(error)")
}
```

# Launch (your script)
```
swift run
```
