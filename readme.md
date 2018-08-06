# London Road
#### by Clarence Ji
<img src="http://forthebadge.com/images/badges/made-with-swift.svg" height="30">
___
## How to build and run the code
1. Unarchive the .zip file and double click on `London Roads.xcodeproj`
2. *(If only running on Simulator, skip this step)*  
In Xcode, click on the project file in Project navigator (on the left pane). Change Team to your team (or name).
3. Make sure the current active scheme (next to play/stop button on the top left) is selected as "London Roads" and the device as your connected iPhone or a simulator.
4. ⌘+B to build the project, ⌘+R to run the project on the selected testing device.

## Enter the API key and secret first
The TfL API requires an API key and secret. You can open `AppConfig.plist` in Xcode to add them. This should be easily done by pasting strings in the correct fields.

## How to run tests
There are two types of tests used in the project, the UI Test and Unit Test. You can follow the steps below to easily run all tests:
1. Go to the Navigator on the left hand side. Click on Test navigator icon (6th from left).
2. To run all Unit tests, hover on `London_RoadsTests` and click on the run button appeared on the right. This will launch a separate app on the simulator/testing device.
3. To run all UI tests, hover on `London_RoadsUITests` and click on the run button appeared on the right. This will launch the original app on the simulator/testing device. Xcode will run different simulations on the screen to test the user interface.

## Assumptions made during the development

## Anomalies with the API found during the development
