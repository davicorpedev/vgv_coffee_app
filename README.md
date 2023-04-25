# Very Good Coffee App

Start your day with a lovely coffee~

## How to run

Flutter Version: 3.7.12

To run the desired project either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
$ flutter run
```

## Testing

To run all unit and widget tests use the following command:

```sh
$ flutter test
```

To view the generated coverage report you can use lcov or the VSCode Flutter Coverage Extension.

```sh
# Run all tests
$ flutter test --coverage
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/
# Open Coverage Report
$ open coverage/index.html
```

## Architecture
- Application
    - Responsible for State Management 
    - Contains Blocs, Events and States
    - It is the connection between Business Logic (Repositories) and UI
- Data
    - Responsible for getting Remote Data and transforming it into Models
- Domain
    - Responsible for the Business Logic
    - It should be independent to the changes on the Data Source
- Presentation
    - Responsible for the UI
    - These Widgets then call Bloc Events and listen for Bloc States

