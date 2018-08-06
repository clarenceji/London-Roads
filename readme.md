# London Road
<img src="http://forthebadge.com/images/badges/made-with-swift.svg" height="30">


## How to build and run the code
1. Unarchive the .zip file and double click on `London Roads.xcodeproj`
2. *(If only running on Simulator, skip this step)*  
In Xcode, click on the project file in Project navigator (on the left pane). Change Team to your team (or name).
3. Make sure the current active scheme (next to play/stop button on the top left) is selected as "London Roads" and the device as your connected iPhone or a simulator.
4. Command⌘+B to build the project, Command⌘+R to run the project on the selected testing device.

## Enter the API key and secret first
The TfL API requires an API key and secret. You can open `AppConfig.plist` in Xcode in order to add them. This should be easily done by pasting strings in the corresponding fields.

## How to run the tests
There are two types of tests used in the project, the UI Test and Unit Test. You can follow the steps below to easily run all tests:
1. Go to the Navigator on the left hand side. Click on Test navigator icon (6th from left).
2. To run all Unit tests, hover on `London_RoadsTests` and click on the run button appeared on the right. This will launch a separate app on the simulator/testing device.
3. To run all UI tests, hover on `London_RoadsUITests` and click on the run button appeared on the right. This will launch the original app on the simulator/testing device. Xcode will run different simulations on the screen to test the user interface.

## Assumptions made during the development
- The app is to be tested and run on devices running iOS 11.4 or above.
- There would be issues with internet connection on users' devices, eg. due to poor cellular reception / Wi-Fi networks that require log-in, etc.
  - Solution: The `APIService` class handles these situations and the app will present an alert when requests are made without internet connection.
- Users will not enter special characters / whitespaces in the text field.
  - The app will not crash but the request will not be made if whitespaces are included.
  - In the future we can validate the input by using regular expression, before sending the request to the API.

## Anomalies with the API found during the development
- The API can work without the API key and secret.
  - Solution: always pass a key and a secret. The app will throw a fatal error if the key or secret is empty in the `AppConfig.plist`.
- `statusSeverity` and `statusSeverityDescription` are simply `"Closure"` when there is a closure on the road. There is no details provided about the closure, which may be confusing to the users if only a small section of the road is closed.
  - In the future we can make use of other API endpoints to enrich the content, eg. using the `/Road/{ids}/Disruption` endpoint.
