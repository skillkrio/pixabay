import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixabay/controller/pixabay/pixabay_controller.dart';
import 'package:pixabay/view/pixabay/widgets/image_card.dart';

class PixabayScreen extends ConsumerStatefulWidget {
  const PixabayScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<PixabayScreen> {
  final scrollController = ScrollController();
  bool hasMore = true;
  @override
  void initState() {
    scrollController.addListener(listener);
    super.initState();
  }

  Future<void> listener() async {
    if ((scrollController.position.pixels) >=
        scrollController.position.maxScrollExtent) {
      ref.read(pixabayProviderProvider.notifier).loadPaginationImage();
      hasMore = ref.read(pixabayProviderProvider.notifier).hasMorePage;
      setState(() {});
      log(hasMore.toString());
      log("reached end");
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pixbayState = ref.watch(pixabayProviderProvider);
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = (screenWidth / 200).floor();
    double itemWidth = screenWidth / crossAxisCount;
    double itemHeight = itemWidth;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Pixabay',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  ref.invalidate(pixabayProviderProvider);
                },
                icon: const Icon(Icons.refresh))
          ],
        ),
        body: pixbayState.when(
          data: (images) => CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverGrid.builder(
                itemCount: images.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: screenWidth * 0.01,
                    mainAxisSpacing: screenWidth * 0.01,
                    childAspectRatio: 1,
                    crossAxisCount: crossAxisCount),
                itemBuilder: (context, index) {
                  final image = images[index];
                  return PixaBayImageCard(
                    height: itemHeight,
                    width: itemWidth,
                    image: image,
                  );
                },
              ),
              if (hasMore)
                const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                )
            ],
          ),
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
        ));
  }
}
