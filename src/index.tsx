import { NativeModules } from 'react-native';

export interface SnapOptions {
  caption?: string;
  attachmentUrl?: string;
}

export interface LaunchData {
  hint?: string;
}

type SnapCreativekitType = {
  shareMedia(url?: string, uuid?: string, options?: SnapOptions): Promise<void>;
  shareLens(
    uuid: string,
    options: SnapOptions | null | undefined,
    launchData: LaunchData | null | undefined
  ): Promise<void>;
  shareSticker(
    url: string,
    options: SnapOptions | null | undefined
  ): Promise<void>;
};

const { SnapCreativekit } = NativeModules;

export default SnapCreativekit as SnapCreativekitType;
