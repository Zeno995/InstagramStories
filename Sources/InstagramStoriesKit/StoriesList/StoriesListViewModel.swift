/// Helper function to find the users.json file URL
private func findUsersJsonURL() -> URL? {
    // First, try the modern Bundle.module approach for Swift Package Manager
    #if SWIFT_PACKAGE
    if let url = Bundle.module.url(forResource: "users", withExtension: "json") {
        return url
    }
    #endif
    
    // Fallback: try using the bundle for the current class
    let bundle = Bundle(for: StoriesListViewModel.self)
    if let url = bundle.url(forResource: "users", withExtension: "json") {
        return url
    }
    
    // Another fallback: look in all loaded bundles
    for bundle in Bundle.allBundles {
        if let url = bundle.url(forResource: "users", withExtension: "json") {
            return url
        }
    }
    
    // Last resort: try main bundle
    return Bundle.main.url(forResource: "users", withExtension: "json")
} 