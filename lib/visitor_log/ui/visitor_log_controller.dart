import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker_web/image_picker_web.dart';

import '../../firestore/firestore_models/visitor_log.dart';
import '../../loading/loading.dart';
import '../../scaffold_messenger_controller.dart';
import '../visitor_log.dart';

/// 購読された [VisitorLog] 一覧を返す [StreamProvider]。
/// たとえば [VisitorLogController] に [StateNotifier] などを継承させた上で、
/// `subscribe` のようなメソッドを定義し、ローディング状態と取得された
/// [VisitorLog] を管理しても良いが、そのあたりを UI から
/// `ref.watch(visitorLogs).when()` とするだけで良い [StreamProvider] が
/// 使いやすいと判断してこのように切り出した。
/// なお、やや冗長だが、コントローラから `Repository` と直接やり取りしないように
/// しているので、内部では [VisitorLogService] のメソッドを使用する。
final visitorLogsStreamProvider =
    StreamProvider.autoDispose<List<VisitorLog>>((ref) {
  final service = ref.watch(visitorLogServiceProvider);
  return service.subscribe();
});

/// 選択された画像データ。
final pickedImageDataStateProvider =
    StateProvider.autoDispose<Uint8List?>((_) => null);

/// 訪問者の名前の [TextEditingController]。
final nameTextEditingController =
    Provider.autoDispose<TextEditingController>((_) => TextEditingController());

/// 訪問者のひとことの [TextEditingController]。
final descriptionTextEditingController =
    Provider.autoDispose<TextEditingController>((_) => TextEditingController());

final visitorLogControllerProvider = Provider.autoDispose<VisitorLogController>(
  (ref) => VisitorLogController(
    service: ref.watch(visitorLogServiceProvider),
    pickedImageController: ref.watch(pickedImageDataStateProvider.notifier),
    scaffoldMessengerController: ref.watch(scaffoldMessengerControllerProvider),
    overlayLoadingController:
        ref.watch(showOverlayLoadingStateProvider.notifier),
  ),
);

/// [VisitorLog] に関する操作（主に書き込み系）を担当するコントローラ。
/// ユーザーによる入力を解釈して、サービスクラスと通信をして然るべき操作を行う。
/// UI とモデルの分離を明確にするために、やや冗長だが、このような構成にしている。
class VisitorLogController {
  VisitorLogController({
    required VisitorLogService service,
    required StateController<Uint8List?> pickedImageController,
    required ScaffoldMessengerController scaffoldMessengerController,
    required StateController<bool> overlayLoadingController,
  })  : _service = service,
        _pickedImageDataController = pickedImageController,
        _scaffoldMessengerController = scaffoldMessengerController,
        _overlayLoadingController = overlayLoadingController;

  final VisitorLogService _service;

  final StateController<Uint8List?> _pickedImageDataController;

  final ScaffoldMessengerController _scaffoldMessengerController;

  final StateController<bool> _overlayLoadingController;

  /// [ImagePickerWeb] を使用して、端末から画像を選択して返す。
  Future<void> pickImage() async {
    final imageData = await ImagePickerWeb.getImageAsBytes();
    _updateChosenImageData(imageData);
  }

  /// 選択された画像を破棄する。
  void resetPickedImage() => _pickedImageDataController.update((_) => null);

  /// 選択された画像を更新する。null の場合は更新しない。
  void _updateChosenImageData(Uint8List? imageData) {
    if (imageData == null) {
      return;
    }
    _pickedImageDataController.update((_) => imageData);
  }

  /// [VisitorLog] を作成する。
  Future<void> createVisitorLog({
    required String visitorName,
    required String description,
    required String imageUrl,
  }) async {
    try {
      await _service.create(
        visitorName: visitorName,
        description: description,
        imageUrl: imageUrl,
      );
    } on FirebaseException catch (e) {
      _scaffoldMessengerController.showSnackBarByFirebaseException(e);
    } finally {
      _overlayLoadingController.update((state) => false);
    }
  }

  /// 指定した [VisitorLog] を削除する。
  Future<void> delete({required VisitorLog visitorLog}) async {
    try {
      await _service.delete(visitorLog: visitorLog);
    } on FirebaseException catch (e) {
      _scaffoldMessengerController.showSnackBarByFirebaseException(e);
    } finally {
      _overlayLoadingController.update((state) => false);
    }
  }
}
