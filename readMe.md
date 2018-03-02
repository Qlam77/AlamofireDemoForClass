This tutorial will help you utilize Alamofire and Alamofire Synchronous with SwiftyJson for pulling API’s

# Step 1
Create the custom JsonController object. This custom class contains both Alamofire and Alamofire Synchronous methods for obtaining a JSON file. Initialize the object by giving it a URL to get the JSON from.

# Step 2
Depending on your preference, call JsonController.loadAsync or JsonController.loadSync.

Note: The loadAsync method will get a JSON asynchronously and custom actions will be needed within the loadAsync method. loadSync will grab the JSON file and store the JSON in a class variable.

The loadAsync method will use regular Alamofire syntax.

The loadSync method will use Alamofire Synchronous syntax.

# Step 3
 Depending on how the structure of the JSON looks like, you may need to change the extractColumn method to get your data as an array.

 To grab individual data, you may use the JSON object and call it as an dictionary with key, value pairs. IE. JsonObject[0][‘nameOfKey’].stringValue where 0 indicates the index of the JSON object you’re looking for and where ‘nameOfKey’ is the name of the key value in the JSON file.

Note: More documentation about how SwiftyJSON extracts your data can be found at:
https://github.com/SwiftyJSON/SwiftyJSON
