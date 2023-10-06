import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kortobaa_ecommerce/cart/presentation/cubits/add_product_to_cart_cubit.dart';
import 'package:kortobaa_ecommerce/cart/presentation/pages/cart_page.dart';
import 'package:kortobaa_ecommerce/core/presentation/blocs/base_states/base_state.dart';
import 'package:kortobaa_ecommerce/core/presentation/themes/app_theme.dart';
import 'package:kortobaa_ecommerce/core/presentation/utils/generated/translation/translations.dart';
import 'package:kortobaa_ecommerce/favorite/presentation/cubits/delete_product_from_favorite_cubit.dart';
import 'package:kortobaa_ecommerce/favorite/presentation/cubits/get_favorite_product_list_cubit.dart';
import 'package:kortobaa_ecommerce/home/domain/entities/product.dart';
import 'package:kortobaa_ecommerce/injection.dart';

import '../../../core/presentation/utils/sliver_grid_delegate_with_fixed_height.dart';

class FavoriteListPage extends StatefulWidget {
  static String path = '/favoritePage';
  const FavoriteListPage({super.key});

  @override
  State<FavoriteListPage> createState() => _FavoriteListPageState();
}

class _FavoriteListPageState extends State<FavoriteListPage> {
  Set<Product> products = {};

  final GetFavoriteProductListCubit _getFavoriteProductListCubit =
      getIt<GetFavoriteProductListCubit>();

  final AddProductToCartCubit _addProductToCartCubit =
      getIt<AddProductToCartCubit>();

  final DeleteProductFromFavoriteCubit _deleteProductFromFavoriteCubit =
      getIt<DeleteProductFromFavoriteCubit>();

  @override
  void initState() {
    _getFavoriteProductListCubit.getFavoriteProductList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Translations tr = Translations.of(context)!;
    final Size screenSize = MediaQuery.sizeOf(context)!;
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        title: Text(tr.favorite),
        centerTitle: true,
        elevation: 3,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
      body: BlocListener<GetFavoriteProductListCubit, BaseState<List<Product>>>(
        bloc: _getFavoriteProductListCubit,
        listener: (_, state) {
          if (state.isSuccess) {
            products.addAll(state.item!);
            setState(() {});
          }
        },
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
            crossAxisCount: screenSize.width > 500 ? 3 : 1,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            height: 380,
          ),
          padding: const EdgeInsets.all(16),
          itemBuilder: (_, int index) => _FavoriteItemWidget(
            products.toList()[index],
            onDelete: (product) {
              _deleteProductFromFavoriteCubit
                  .deleteProductFromFavorite(product.id.toString());
              products.remove(product);
              setState(() {});
            },
            onAddToCart: (product) {
              _addProductToCartCubit.addProductToCart(product);
              setState(() {});
              context.pushNamed(CartPage.path);
            },
          ),
          itemCount: products.length,
        ),
      ),
    );
  }
}

class _FavoriteItemWidget extends StatelessWidget {
  const _FavoriteItemWidget(
    this.product, {
    required this.onDelete,
    required this.onAddToCart,
  });
  final Product product;
  final void Function(Product) onDelete;
  final void Function(Product) onAddToCart;

  @override
  Widget build(BuildContext context) {
    final Translations tr = Translations.of(context)!;
    final ThemeData themeData = Theme.of(context);
    final Size screenSize = MediaQuery.sizeOf(context);
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      child: Card(
        margin: EdgeInsets.zero,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                      child:
                          Image.network(product.imageLink, fit: BoxFit.cover)),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: InkWell(
                      onTap: () => onDelete(product),
                      child: Icon(
                        Icons.favorite,
                        color: themeData.appColors.secondaryColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      product.name,
                      style: themeData.textTheme.titleLarge!.copyWith(
                        height: 1.5,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Text.rich(
                      TextSpan(
                        text: '${product.price} ',
                        children: [
                          TextSpan(
                            text: tr.egp,
                            style: themeData.textTheme.titleMedium!.copyWith(
                              color: themeData.primaryColor,
                            ),
                          ),
                        ],
                        style: themeData.textTheme.titleMedium!.copyWith(
                          color: themeData.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width,
                    child: ElevatedButton(
                      onPressed: () => onAddToCart(product),
                      child: Text(tr.moveToCart),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
