import 'package:flutter/material.dart';

class FullScreenImageView extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const FullScreenImageView({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  @override
  State<FullScreenImageView> createState() => _FullScreenImageViewState();
}

class _FullScreenImageViewState extends State<FullScreenImageView> {
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: widget.initialIndex);
  }

  bool isNetworkImage(String path) {
    return path.startsWith("http");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              final imagePath = widget.images[index];

              return InteractiveViewer(
                minScale: 1,
                maxScale: 4,
                child: Center(
                  child: isNetworkImage(imagePath)
                      ? Image.network(
                    imagePath,
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return const CircularProgressIndicator(
                        color: Colors.white,
                      );
                    },
                    errorBuilder: (_, __, ___) =>
                    const Icon(Icons.image_not_supported,
                        color: Colors.white, size: 60),
                  )
                      : Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                  ),
                ),
              );
            },
          ),

          // Close Button
          Positioned(
            top: 45,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.close,
                  color: Colors.white, size: 28),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
