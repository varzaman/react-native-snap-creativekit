import { NativeModules } from 'react-native';

type SnapCreativekitType = {
  multiply(a: number, b: number): Promise<number>;
};

const { SnapCreativekit } = NativeModules;

export default SnapCreativekit as SnapCreativekitType;
