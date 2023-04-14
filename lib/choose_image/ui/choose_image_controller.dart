import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker_web/image_picker_web.dart';

/// 選択可能なカメラの [CameraDescription]。
final cameraDescription =
    Provider<CameraDescription?>((_) => throw UnimplementedError());

/// 選択された画像。
final chosenImageData = StateProvider.autoDispose<Uint8List?>((_) => null);

/// camera パッケージの [CameraController]。
final cameraController = Provider.autoDispose<CameraController>(
  (ref) =>
      CameraController(ref.watch(cameraDescription)!, ResolutionPreset.high),
);

final chooseImageController = Provider.autoDispose<ChooseImageController>(
  (ref) => ChooseImageController(
    cameraController: ref.watch(cameraController),
    chosenImageController: ref.watch(chosenImageData.notifier),
  ),
);

enum ImageSource { gallery, camera }

class ChooseImageController {
  ChooseImageController({
    required CameraController cameraController,
    required StateController<Uint8List?> chosenImageController,
  })  : _cameraController = cameraController,
        _chosenImageDataController = chosenImageController;

  final CameraController _cameraController;

  final StateController<Uint8List?> _chosenImageDataController;

  /// camera パッケージの [CameraController] を初期化する。
  late final Future<void> initializeCameraController =
      _cameraController.initialize();

  /// 端末から画像を選択するかカメラを起動して写真を撮るか、指定した方法で
  /// 画像を選択する。
  Future<void> chooseImage(ImageSource imageSource) async {
    switch (imageSource) {
      case ImageSource.gallery:
        await _chooseFromGallery();
        break;
      case ImageSource.camera:
        await _launchCamera();
        break;
    }
  }

  /// 選択された画像を破棄する。
  void resetChosenImage() => _chosenImageDataController.update((_) => null);

  /// [ImagePickerWeb] を使用して、端末から画像を選択して返す。
  Future<void> _chooseFromGallery() async {
    final imageData = await ImagePickerWeb.getImageAsBytes();
    _updateChoseImageData(imageData);
  }

  /// [CameraController] を使用して、カメラを起動して写真を撮影して返す。
  Future<void> _launchCamera() async {
    await initializeCameraController;
    final image = await _cameraController.takePicture();
    final imageData = await image.readAsBytes();
    _updateChoseImageData(imageData);
  }

  /// 選択された画像を更新する。null の場合は更新しない。
  void _updateChoseImageData(Uint8List? imageData) {
    if (imageData == null) {
      return;
    }
    _chosenImageDataController.update((_) => imageData);
  }
}
