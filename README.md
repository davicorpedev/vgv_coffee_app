# Very Good Coffee App

Start your day with a lovely coffee~

## How to run

The app does not require to add any configuration or files, simply clone the project and execute the App on your simulator or device.

## Architecture
- Application
    - Layer responsible for the State Management 
    - Contains Blocs, Events and States
    - It is the connection between Business Logic (Repositories) and UI
- Data
    - Layer responsible for getting remote data and transforming it
- Domain
    - Layer responsible for the Business Logic
    - It should be independent to the changes on the data source
- Presentation
    - Layer responsible for the UI
    - These Widgets then call Bloc Events and listen for Bloc States

## Testing
100% Test Coverage

## Info
Flutter: 3.3.5
