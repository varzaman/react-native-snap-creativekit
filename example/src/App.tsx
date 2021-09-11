import * as React from 'react';

import { StyleSheet, View, Text, TouchableOpacity } from 'react-native';
import SnapCreativekit, {
  LaunchData,
  SnapOptions,
} from 'react-native-snap-creativekit';

export default function App() {
  const onLensPress = async () => {
    const options: SnapOptions = {
      caption: 'hello world, this is a lens',
    };
    const launchData: LaunchData = {
      hint: 'TAP!',
    };

    try {
      const uuid = 'b4b839c3ba9d426da0d67d069e50c9bd';
      await SnapCreativekit.shareLens(uuid, options, launchData);
    } catch (e) {
      console.log(e);
    }
  };

  const onStickerPress = async () => {
    const options: SnapOptions = {
      caption: 'hello world, this is a sticker',
    };

    try {
      const url =
        'https://clipart.info/images/minicovers/1522852544cute-cat-png-image-download-picture-kitten.png';
      await SnapCreativekit.shareSticker(url, options);
    } catch (e) {
      console.log(e);
    }
  };

  const renderButton = (text: string, func: () => void) => (
    <TouchableOpacity onPress={func} style={styles.button}>
      <Text>{text}</Text>
    </TouchableOpacity>
  );

  return (
    <View style={styles.container}>
      {renderButton('Share Lens', onLensPress)}
      {renderButton('Share sticker', onStickerPress)}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
  button: {
    height: 50,
    width: 100,
  },
});
