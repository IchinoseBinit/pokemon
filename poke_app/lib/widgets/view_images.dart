import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '/widgets/custom_appbar.dart';

class ViewImage extends StatelessWidget {
  const ViewImage({
    super.key,
    required this.url,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Image View",),
      body: Center(
        child: PhotoView(
          imageProvider: NetworkImage(
            url, 
          ),
        ),
      ),
    );
  }
}
