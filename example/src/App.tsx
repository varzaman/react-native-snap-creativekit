import * as React from 'react';

import { StyleSheet, View, Text, TouchableOpacity } from 'react-native';
import SnapCreativekit, { SnapOptions } from 'react-native-snap-creativekit';

export default function App() {
  const [result, setResult] = React.useState<number | undefined>(0);

  const onPress = async () => {
    const options: SnapOptions = {
      caption: 'hello world',
    };

    try {
      await SnapCreativekit.shareMedia(
        'https://clipart.info/images/minicovers/1522852544cute-cat-png-image-download-picture-kitten.png',
        undefined,
        options
      );
      setResult((result || 0) + 1);
    } catch (e) {
      console.log(e);
    }
  };

  const renderButton = (text: string, func: () => void) => (
    <TouchableOpacity onPress={func}>
      <Text>{text}</Text>
    </TouchableOpacity>
  );

  return (
    <View style={styles.container}>
      <Text>{result}</Text>
      {renderButton('Share image', onPress)}
      {renderButton('Share image with caption', onPress)}
      {renderButton('Share video', onPress)}
      {renderButton('Share sticker', onPress)}
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
});
