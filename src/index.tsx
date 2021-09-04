import { NativeModules } from 'react-native';

export interface SnapOptions {
  caption?: string;
  attachmentUrl?: string;
}

type SnapCreativekitType = {
  multiply(a: number, b: number): Promise<number>;
  shareMedia(url?: string, uuid?: string, options?: SnapOptions): Promise<void>;
};

const { SnapCreativekit } = NativeModules;

export default SnapCreativekit as SnapCreativekitType;
