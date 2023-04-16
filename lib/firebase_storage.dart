import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:intl/intl.dart';

final firebaseStorageServiceProvider =
    Provider.autoDispose<FirebaseStorageService>(
  (_) => FirebaseStorageService(),
);

/// Firebase Storage への画像のアップロードなどを行うサービスクラス。
class FirebaseStorageService {
  final _storage = FirebaseStorage.instance;

  late final _storageRef = _storage.ref();

  /// 選択された画像を Firebase Storage にアップロードして、ダウンロード URL を
  /// 返す。
  Future<String> uploadImage({required Uint8List imageData}) async {
    final compressed = await _compressImageData(imageData);
    final fileName = '${_getFormattedDate()}_${compressed.hashCode}.jpg';
    final ref = _storageRef.child(fileName);
    await ref.putData(compressed, SettableMetadata(contentType: 'image/jpeg'));
    return ref.getDownloadURL();
  }

  /// 与えられた画像を圧縮して返す。
  Future<Uint8List> _compressImageData(Uint8List imageData) async {
    final decoded = img.decodeImage(imageData);
    if (decoded == null) {
      return imageData;
    }
    final resized = img.copyResize(decoded, width: 960);
    return Uint8List.fromList(img.encodeJpg(resized, quality: 40));
  }

  /// 定められたフォーマットで現在時刻文字列を返す。
  String _getFormattedDate() {
    final now = DateTime.now();
    final dateFormatter = DateFormat('yyyy-MM-dd:HH:mm:ss');
    return dateFormatter.format(now);
  }
}
