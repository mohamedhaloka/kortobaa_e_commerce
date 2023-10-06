import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kortobaa_ecommerce/core/presentation/themes/app_theme.dart';
import 'package:kortobaa_ecommerce/core/presentation/utils/generated/generated_assets/assets.gen.dart';
import 'package:kortobaa_ecommerce/core/presentation/utils/generated/translation/translations.dart';
import 'package:kortobaa_ecommerce/home/presentation/widgets/category_horizontal_list.dart';
import 'package:kortobaa_ecommerce/home/presentation/widgets/home_slider.dart';
import 'package:kortobaa_ecommerce/home/presentation/widgets/product_horizontal_list.dart';

class HomePage extends StatefulWidget {
  static String path = '/homePage';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> sliderImages = [
    Assets.images.sliderPhotoOne.path,
    Assets.images.sliderPhotoTwo.path,
  ];

  int currentSliderImage = 0;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);
    final ThemeData themeData = Theme.of(context);
    final Translations tr = Translations.of(context)!;
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          SizedBox(
            height: 220,
            width: screenSize.width,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage(sliderImages[currentSliderImage]),
                  fit: BoxFit.cover,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  height: 220,
                  decoration:
                      BoxDecoration(color: Colors.white.withOpacity(0.5)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: kToolbarHeight),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.menu),
                          ),
                          const Spacer(),
                          Text(tr.home),
                          const Spacer(),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 7),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.white60,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search,
                        color: themeData.appColors.greyColor,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        tr.whatYouSearchFor,
                        style: themeData.textTheme.titleSmall,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      HomeSlider(
                        sliderImages: sliderImages,
                        onSliderChanged: (int page) =>
                            setState(() => currentSliderImage = page),
                      ),
                      const CategoriesHorizontalList(),
                      ProductHorizontalList(
                        title: tr.recentlyArrived,
                        categoryId: '1',
                      ),
                      ProductHorizontalList(
                        title: tr.theMostPopular,
                        categoryId: '5',
                      ),
                    ],
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
