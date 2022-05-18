# SimpleWeatherAppRN
SimpleWeatherApp with an integration with React Native


# Instructions for demo


## Install rbenv & ruby-build -- ruby version manager and build framework
See https://github.com/rbenv/rbenv for complete instructions on how to set it up

```bash
brew install rbenv ruby-build
```

# PreRequisites:
* NodeJS
* NPM 
* yarn
* watchman - install view brew => "brew install watchman"
* cocoapods


# Installation

1. Create folder for iOS project called "ios" and copy project into that directory directly
2. create a package.json
```javascript
{
  "name": "YourReactNativeApp",
  "version": "1.0.0",
  "private": true,
  "scripts": {
    "start": "yarn react-native start"
  }
}
```

3. Add react-native pacakges to project at the root of the project.
    'yarn add react-native'
    * watch for messages about uninstalled dependencies and run install/update them accordingly
        " > react-native@0.68.1" has unmet peer dependency "react@17.0.2"."

       * yarn add react@17.0.2

    * for the demo install these packages
        moment@2.29.3                       => 'yarn add moment'
        react-native-paper@4.12.1           => 'yarn add react-native-paper'
        react-native-vector-icons@9.1.0     => 'yarn add react-native-vector-icons'

4. Setup cocoapods for your iOS project.
    a. Goto the "ios" folder created in step 1
    b. 'pod init' if you don't have Podfile already
    c. modify Podfile to look like this 

```ruby
    ## SAMPLE Podfile
    require_relative '../node_modules/react-native/scripts/react_native_pods'
    require_relative '../node_modules/@react-native-community/cli-platform-ios/native_modules'
    
    platform :ios, '13.0'
    
    target 'yourreactnativeapp' do
      use_react_native!
    end
```

    d. Once Podfile has been modified with the changes run 'pod install'


5. Updating iOS project for React support
    a.  Modify Main VC to look like this:

```swift
    // ViewController.swift

    import UIKit
    import React
    
    class ViewController: UIViewController {
    
        override func viewDidLoad() {
            super.viewDidLoad()
        }
    
        override func loadView() {
            loadReactNativeView()
        }
    
        func loadReactNativeView() {
            let jsCodeLocation = URL(string: "http://localhost:8081/index.bundle?platform=ios")!
            
            let rootView = RCTRootView(
                bundleURL: jsCodeLocation,
                moduleName: "YourApp",
                initialProperties: nil,
                launchOptions: nil
            )
            self.view = rootView
        }
        
```

6. update React Native with support 
####  Modify __index.js__ 
```javascript
import React from 'react';
import {
    AppRegistry,
    Text,
    View
  } from 'react-native';

const YourApp = () => {
  return (
    <View style={{ flex: 1, justifyContent: "center", alignItems: "center" }}>
      <Text>
        Hello World! 🎉
      </Text>
    </View>
  );
}

AppRegistry.registerComponent('YourApp', () => YourApp);
````


# Test installation
To test and make sure that this is set up correctly, we to start Metro first by running the following command at the root of our project:

```bash
> yarn start
```

Metro is a light weight httpd server that allows us to make live edits to the JS.

Once it has finished loading.  Startup your iOS app by opening up the workspace file (<project>.xcworkspace and not <project>.xcodeproj)

