import 'package:flutter/material.dart';

class ImageLabel extends StatelessWidget {
  const ImageLabel(
      {Key? key, this.image = '', this.title = '', this.subTitle = ''})
      : super(key: key);

  final String image;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        children: [
          if (image.isNotEmpty)
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Image(
                image: NetworkImage(image),
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
            ),
          if (image.isNotEmpty)
            const SizedBox(
              width: 10,
            ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title.isNotEmpty)
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    softWrap: true,
                  ),
                if (subTitle.isNotEmpty)
                  Text(
                    subTitle,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
