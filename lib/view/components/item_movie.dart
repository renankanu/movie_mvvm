import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_mvvm/model/movie.dart';

import '../../core/constants/app_url.dart';

class ItemMovie extends StatelessWidget {
  const ItemMovie({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: '${AppUrl.imageBaseUrlW500}${movie.posterPath}',
            width: 160,
            height: 240,
          ),
        ),
      ),
    );
  }
}
