# WIP

# react-native-snap-creativekit

React Native bridge for the Snap Creative Kit library

## Installation

```sh
npm install react-native-snap-creativekit
```

### iOS
1. Update Info.plist with the following required fields
    - SCSDKClientId
    - LSApplicationQueriesSchemes
2. 
Make sure 

More info here: https://kit.snapchat.com/docs/creative-kit-ios
## Usage

### Features supported
- share sticker by URL
- share lenses
- ability to add captions and attachment urls to a snap

```js
import SnapCreativekit from "react-native-snap-creativekit";

// ...

const result = await SnapCreativekit.multiply(3, 7);
```

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT
