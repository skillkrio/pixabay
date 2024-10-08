import 'package:pixabay/core/providers/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pixabay/model/pixabay/pixabay_image_model.dart';
part 'pixabay_controller.g.dart';

@riverpod
class PixabayProvider extends _$PixabayProvider {
  //Page index for paginating
  int _currentPage = 1;
  //If there are no images to load it will turn false
  bool hasMorePage = true;
  //How many images to fetch per request.
  int pageLimit = 20;
  @override
  FutureOr<List<PixabayImageModel>> build() async {
    return loadImage();
  }

  Future<List<PixabayImageModel>> loadImage() async {
    Future.delayed(const Duration(seconds: 5));
    final dio = await ref.read(dioProvider).get('?page=$_currentPage');
    final response = dio.data;
    final List<PixabayImageModel> imageList =
        PixabayImageModel.constructList(response['hits']);
    imageList;
    _currentPage++;
    if (imageList.length < pageLimit) {
      hasMorePage = false;
    }
    return imageList;
  }

  Future<void> loadPaginationImage() async {
    if (!hasMorePage) {
      return;
    }
    state = await AsyncValue.guard(
      () async {
        final results = await loadImage();
        return [...state.value!, ...results];
      },
    );
  }
}
