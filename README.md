## IMUI for React Native

[中文文档](./README_zh.md)

## InstallREADME_zh.md

```
npm install react-native-imui --save
react-native link
```

If link Android failed, you need modify `settings.gradle`:

```
include ':app', ':react-native-imui'
project(':react-native-imui').projectDir = new File(rootProject.projectDir, '../node_modules/react-native-imui/android')
```

And add dependency in your app's `build.gradle`:

```
dependencies {
    compile project(':react-native-imui')
}
```



## Configuration

- ### Android

  - Add Package:

  > MainApplication.java

  ```
  @Override
  protected List<ReactPackage> getPackages() {
      return Arrays.<ReactPackage>asList(
          new MainReactPackage(),
          new ReactIMUIPackage()
      );
  }
  ```

  - import IMUI from 'react-native-imui';


- ### iOS

  - PROJECT -> TARGETS -> Build Settings -> Enable Bitcode Set to No
  - Find PROJECT -> TARGETS -> General -> Embedded Binaries  and add RNTAuroraIMUI.framework
  - Before build you project ,you should build RNTAuroraIMUI.framework

## Usage
```
  import IMUI from 'react-native-imui';
  var MessageList = IMUI.MessageList;
  var ChatInput = IMUI.ChatInput;
  const AuroraIMUIModule = NativeModules.AuroraIMUIModule;
```
Refer to iOS,Android example
> [iOS Example usage](./sample/index.ios.js)
> [Android Example usage](./sample/react-native-android/pages/chat_activity.js)
## Data format

By using MessageList, you need define `message` object and `fromUser` object.

- message object format:

** status must be one of the four values: "send_succeed", "send_failed", "send_going", "download_failed", 
if you haven't define this property, default value is "send_succeed".**

 ```
  message = {  // text message
    msgId: "msgid",
    status: "send_going",
    msgType: "text",
    isOutgoing: true,
    text: "text"
    fromUser: {}
}

message = {  // image message
    msgId: "msgid",
    msgType: "image",
    isOutGoing: true,
    progress: "progress string"
    mediaPath: "image path"
    fromUser: {}
}


message = {  // voice message
    msgId: "msgid",
    msgType: "voice",
    isOutGoing: true,
    duration: number
    mediaPath: "voice path"
    fromUser: {}
}

message = {  // video message
    msgId: "msgid",
    status: "send_failed",
    msgType: "video",
    isOutGoing: true,
    druation: number
    mediaPath: "voice path"
    fromUser: {}
}
 ```

-    fromUser object format:

  ```
  fromUser = {
    userId: ""
    displayName: ""
    avatarPath: "avatar image path"
  }
  ```


  ## Event Handling

  ### MessageList Event
- onAvatarClick {message: {message json}} :Fires when click avatar

- onMsgClick {message: {message json} : Fires when click message bubble

- onStatusViewClick {message: {message json}}  Fires when click status view

- onPullToRefresh  Fires when pull MessageList to top, example usage: please refer sample's onPullToRefresh method.


- onBeginDragMessageList (iOS only)

  ### MessageList append/update/insert message event:

  For append/update/insert message to MessageList, you will use `MsgListModule`(Native Module) to send event to native.

- appendMessages([message])

 example:

```
var messages = [{
	msgId: "1",
	status: "send_going",
	msgType: "text",
	text: "Hello world",
	isOutgoing: true,
	fromUser: {
		userId: "1",
		displayName: "Ken",
		avatarPath: "ironman"
	},
	timeString: "10:00",
}];
AuroraIMUIModule.appendMessages(messages);
```

- updateMessage(message)

example:

```
var message = {
	msgId: "1",
	status: "send_going",
	msgType: "text",
	text: text,
	isOutgoing: true,
	fromUser: {
		userId: "1",
		displayName: "Ken",
		avatarPath: "ironman"
	},
	timeString: "10:00",
};
AuroraIMUIModule.updateMessage(message);
```

- insertMessagesToTop([message])

  **Notice that the order of message array must be sorted in chronological order**

example:

```
var messages = [{
    msgId: "1",
    status: "send_succeed",
    msgType: "text",
    text: "This",
    isOutgoing: true,
    fromUser: {
	  userId: "1",
	  displayName: "Ken",
	  avatarPath: "ironman"
    },
    timeString: "10:00",
  },{
    msgId: "2",
	status: "send_succeed",
	msgType: "text",
	text: "is",
	isOutgoing: true,
	fromUser: {
		userId: "1",
		displayName: "Ken",
		avatarPath: "ironman"
    },
    timeString: "10:10",
},{
    msgId: "3",
	status: "send_succeed",
	msgType: "text",
	text: "example",
	isOutgoing: true,
	fromUser: {
		userId: "1",
		displayName: "Ken",
		avatarPath: "ironman"
    },
    timeString: "10:20",
}];
AuroraIMUIModule.insertMessagesToTop(messages);
```

## Style 

### MessageList custom style

**In android, if your want to define your chatting bubble, you need to put a drawable file in drawable folder, and that image file must be [nine patch drawable file](https://developer.android.com/reference/android/graphics/drawable/NinePatchDrawable.html), see our example for detail.**



**In iOS, if your want to define your chatting bubble,you need to put a image file to you xcode,and specifies ` sendBubble.imageName` or `receiveBubble.imageName` to image name. if you need to set the default avatar, you need put you default avatar image to you xcode,and adjust the image name to `defoult_header`,see our example for detail.**

- sendBubble: PropTypes.object :
```
// eg:
	{ 
		imageName:"inComing_bubble",
		padding:{left:10,top:10,right:15,bottom:10}
	}
```

- receiveBubble: PropTypes.object,

- sendBubbleTextColor: PropTypes.string,

- receiveBubbleTextColor: PropTypes.string,

- sendBubbleTextSize: PropTypes.number,

- receiveBubbleTextSize: PropTypes.number,


This Padding object includes four properties: left, top, right, bottom. 
```
 // eg:
 {
 	left: 5, 
 	top: 5, 
 	right: 15, 
 	bottom: 5
 }
```
- sendBubblePadding: PropTypes.object

- receiveBubblePadding: PropTypes.object

- dateTextSize: PropTypes.number,

- dateTextColor: PropTypes.string,

- datePadding: PropTypes.number -- This is a number property, means padding left/top/right/bottom value is same.

Size object include width and height properties.

- avatarSize: PropTypes.object -- Example: avatarSize = {width: 50, height: 50}

- showDisplayName: PropTypes.bool, 

