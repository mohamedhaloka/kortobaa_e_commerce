import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kortobaa_ecommerce/core/presentation/themes/app_theme.dart';

class HomeSlider extends StatefulWidget {
  const HomeSlider({
    super.key,
    required this.sliderImages,
    required this.onSliderChanged,
  });
  final List<String> sliderImages;
  final void Function(int) onSliderChanged;

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  PageController pageController = PageController();

  int currentPage = 0;
  Timer? timer;

  List<String> sliderImages = [];

  @override
  void initState() {
    sliderImages.addAll(widget.sliderImages);
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (currentPage == sliderImages.length - 1) {
        pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
        );
        return;
      }
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final Size screenSize = MediaQuery.sizeOf(context);
    return Column(
      children: [
        Container(
          height: screenSize.height > 700 ? screenSize.height * .3 : 150,
          margin: const EdgeInsets.only(top: 8, bottom: 16),
          constraints: const BoxConstraints(maxWidth: 800),
          child: PageView.builder(
            controller: pageController,
            itemCount: sliderImages.length,
            onPageChanged: (index) {
              setState(() => currentPage = index);

              widget.onSliderChanged(index);
            },
            itemBuilder: (_, int index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: Image.asset(
                  sliderImages[index],
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
        Wrap(
          children: sliderImages
              .map((e) => Container(
                    width: 16,
                    height: 4,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    color: sliderImages.indexOf(e) == currentPage
                        ? themeData.primaryColor
                        : themeData.appColors.greyColor,
                  ))
              .toList(),
        )
      ],
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
