# News Feed

# Architecture
## The app code is separated out in 3 main layers
    UI Layer
    Business Layer
    Network Services and Persistence Storage.
    
    ## UI Layer
        The UI is coded in SwiftUI and responds a view models properties and events.
        Pagigation - Did not demonstrate pagination in this demo, due to time constraints, but would like to include in later versions.
    ## Business Layer
        NewsFeedDataManager - Manages Data fetch and store operations - News feeds and Bookmarking.
        ModuleFactory - This is a abstract factory that creates different modules. Particulary used for dependency Injection and unit testing.
    ## Network Services and Persistence Storage.
        Network Services - Async await paradigm is used for network calls 
        Persistence Store - SwiftData is used to store Bookmarked records.
    

# Unit Tests
    Have included unit tests for 2 classes for this demo app - NewsFeedDataManager and NewsFeedListViewModel class 
