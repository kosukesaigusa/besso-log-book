import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
    final fileName = '${_getFormattedDate()}_${imageData.hashCode}.jpg';
    final ref = _storageRef.child(fileName);
    await ref.putData(imageData);
    return ref.getDownloadURL();
  }

  /// 日本時間で
  String _getFormattedDate() {
    final now = DateTime.now();
    final dateFormatter = DateFormat('yyyy-MM-dd:HH:mm:ss');
    return dateFormatter.format(now);
  }
}
