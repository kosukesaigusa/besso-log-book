import 'dart:typed_data';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker_web/image_picker_web.dart';

/// 選択された画像データ。
final chosenImageDataStateProvider =
    StateProvider.autoDispose<Uint8List?>((_) => null);

final chooseImageControllerProvider =
    Provider.autoDispose<ChooseImageController>(
  (ref) => ChooseImageController(
    chosenImageController: ref.watch(chosenImageDataStateProvider.notifier),
  ),
);

class ChooseImageController {
  ChooseImageController({
    required StateController<Uint8List?> chosenImageController,
  }) : _chosenImageDataController = chosenImageController;

  final StateController<Uint8List?> _chosenImageDataController;

  /// [ImagePickerWeb] を使用して、端末から画像を選択して返す。
  Future<void> pickImage() async {
    final imageData = await ImagePickerWeb.getImageAsBytes();
    _updateChoseImageData(imageData);
  }

  /// 選択された画像を破棄する。
  void resetChosenImage() => _chosenImageDataController.update((_) => null);

  /// 選択された画像を更新する。null の場合は更新しない。
  void _updateChoseImageData(Uint8List? imageData) {
    if (imageData == null) {
      return;
    }
    _chosenImageDataController.update((_) => imageData);
  }
}
