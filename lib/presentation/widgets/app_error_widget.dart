import 'package:flutter/material.dart';
import 'package:posts_app/core/constants/sizes.dart';
import 'package:posts_app/core/error/failures.dart';

class AppErrorWidget extends StatelessWidget {
  final Failure failure;
  const AppErrorWidget({super.key, required this.failure});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(Sizes.s16),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Text(
          failure.message,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
