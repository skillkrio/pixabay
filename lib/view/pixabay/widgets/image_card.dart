import 'package:flutter/material.dart';
import 'package:pixabay/model/pixabay/pixabay_image_model.dart';

class PixaBayImageCard extends StatelessWidget {
  final PixabayImageModel image;
  final double height;
  final double width;
  const PixaBayImageCard(
      {super.key,
      required this.image,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(4),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage(
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset('assets/no_image.png');
              },
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              placeholder: const AssetImage('assets/bottle-loader.gif'),
              image: NetworkImage(
                image.url,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 8,
            right: 8,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.thumb_up, color: Colors.white, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        '${image.likes}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.visibility,
                          color: Colors.white, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        '${image.views}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
