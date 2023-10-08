import 'package:flutter/material.dart';
import 'package:kortobaa_ecommerce/core/presentation/themes/app_theme.dart';
import 'package:kortobaa_ecommerce/core/presentation/utils/generated/translation/translations.dart';

class ApplyCouponInput extends StatelessWidget {
  const ApplyCouponInput({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final Translations tr = Translations.of(context)!;
    return ClipPath(
      clipper: SinCosineWaveClipper(),
      child: Container(
        height: 140,
        color: themeData.primaryColor,
        margin: const EdgeInsets.symmetric(vertical: 32),
        padding: const EdgeInsets.all(12),
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.star,
                        color: themeData.appColors.whiteColor.withOpacity(.5),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            tr.doYouHaveCoupon,
                            style: themeData.textTheme.titleLarge!.copyWith(
                              color: themeData.appColors.textColor.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 5,
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: tr.enterCoupon,
                              hintStyle: themeData.textTheme.titleSmall!
                                  .copyWith(
                                      color: themeData.appColors.textColor),
                              fillColor: themeData.appColors.whiteColor
                                  .withOpacity(.5),
                            ),
                          )),
                      const SizedBox(width: 8),
                      Expanded(
                          flex: 3,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: themeData.appColors.whiteColor,
                            ),
                            onPressed: () {},
                            child: Text(
                              'تطبيق',
                              style: themeData.textTheme.titleMedium,
                            ),
                          ))
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: CustomPaint(
                  size: const Size(1, double.infinity),
                  painter: DashedLineVerticalPainter()),
            ),
            Expanded(
                child: Align(
              alignment: Alignment.topLeft,
              child: Icon(
                Icons.star,
                color: themeData.appColors.whiteColor.withOpacity(.5),
              ),
            ))
          ],
        ),
      ),
      // ),
    );
  }
}

class SinCosineWaveClipper extends CustomClipper<Path> {
  final double heightOfPoint;
  final int numberOfPoints;

  SinCosineWaveClipper({this.heightOfPoint = 8, this.numberOfPoints = 25});

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 0);
    double x = 0.0;
    double y = 0.0;
    double increment = size.width / numberOfPoints / 2;

    while (y < size.height) {
      y += increment;
      x = (x == 0) ? 0 + heightOfPoint : 0;
      path.lineTo(x, y);
    }
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);

    x = size.width;
    y = 0.0;

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => oldClipper != this;
}

class DashedLineVerticalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 8, dashSpace = 8, startY = 0;
    final paint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 5;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
