import 'package:flutter/material.dart';
import 'package:posts_app/core/constants/sizes.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(Sizes.s16),
        child: SizedBox.square(
          dimension: 30,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
