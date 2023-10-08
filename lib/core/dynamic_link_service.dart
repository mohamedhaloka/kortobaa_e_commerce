import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:kortobaa_ecommerce/home/domain/entities/product.dart';
import 'package:kortobaa_ecommerce/product_details/presentation/pages/product_details_page.dart';
import 'package:uni_links/uni_links.dart';

class DynamicLinkHandler {
  DynamicLinkHandler._();

  bool _initialURILinkHandled = false;
  static DynamicLinkHandler I = DynamicLinkHandler._();

  Future<String> createDynamicLink(Product product) async {
    return Uri.encodeFull('https://kortobaa.com/${product.id}');
  }

  Future<void> initDynamicLinks(BuildContext context) async {
    uriLinkStream.listen((dynamicLinkData) {
      if (dynamicLinkData == null) return;
      handleDeepLink(context, dynamicLinkData);
    }).onError((error) {
      log(error.message.toString(), name: 'DYNAMIC LINK ERROR');
    });

    initUniLinks(context);
  }

  Future<void> initUniLinks(BuildContext context) async {
    try {
      if (_initialURILinkHandled) return;
      _initialURILinkHandled = false;
      final Uri? initialURI = await getInitialUri();

      if (initialURI == null) return;
      handleDeepLink(context, initialURI);
    } catch (e) {
      log(e.toString(), name: 'ERROR INITIAL LINK');
    }
  }

  void handleDeepLink(BuildContext context, Uri url) {
    List<String> pathComponents = url.pathSegments;

    int? productId = int.tryParse(pathComponents[0]);

    if (productId != null) {
      context.pushNamed(ProductDetailsPage.path, extra: productId);
    }
  }
}
