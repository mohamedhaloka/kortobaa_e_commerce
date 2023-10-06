import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kortobaa_ecommerce/cart/presentation/cubits/add_product_to_cart_cubit.dart';
import 'package:kortobaa_ecommerce/cart/presentation/cubits/delete_product_from_cart_cubit.dart';
import 'package:kortobaa_ecommerce/cart/presentation/cubits/get_cart_product_list_cubit.dart';
import 'package:kortobaa_ecommerce/core/presentation/blocs/base_states/base_state.dart';
import 'package:kortobaa_ecommerce/core/presentation/themes/app_theme.dart';
import 'package:kortobaa_ecommerce/core/presentation/widgets/error_view.dart';
import 'package:kortobaa_ecommerce/core/presentation/widgets/loader.dart';
import 'package:kortobaa_ecommerce/favorite/presentation/cubits/add_product_to_favorite_cubit.dart';
import 'package:kortobaa_ecommerce/favorite/presentation/cubits/delete_product_from_favorite_cubit.dart';
import 'package:kortobaa_ecommerce/favorite/presentation/cubits/get_favorite_product_list_cubit.dart';
import 'package:kortobaa_ecommerce/home/domain/entities/product.dart';
import 'package:kortobaa_ecommerce/home/presentation/cubits/get_product_list_by_category_id_cubit.dart';
import 'package:kortobaa_ecommerce/injection.dart';
import 'package:kortobaa_ecommerce/product_details/presentation/pages/product_details_page.dart';

import '../../../core/presentation/utils/generated/translation/translations.dart';

class ProductHorizontalList extends StatefulWidget {
  const ProductHorizontalList(
      {super.key, required this.title, required this.categoryId});
  final String title;
  final String categoryId;

  @override
  State<ProductHorizontalList> createState() => _ProductHorizontalListState();
}

class _ProductHorizontalListState extends State<ProductHorizontalList> {
  final GetCartProductListCubit _getCartProductListCubit =
      getIt<GetCartProductListCubit>();

  final GetFavoriteProductListCubit _getFavoriteProductListCubit =
      getIt<GetFavoriteProductListCubit>();

  final GetProductListByCategoryIdCubit _getProductListByCategoryIdCubit =
      getIt<GetProductListByCategoryIdCubit>();

  final AddProductToCartCubit _addProductToCartCubit =
      getIt<AddProductToCartCubit>();

  final DeleteProductFromCartCubit _deleteProductFromCartCubit =
      getIt<DeleteProductFromCartCubit>();

  final AddProductToFavoriteCubit _addProductToFavoriteCubit =
      getIt<AddProductToFavoriteCubit>();

  final DeleteProductFromFavoriteCubit _deleteProductFromFavoriteCubit =
      getIt<DeleteProductFromFavoriteCubit>();

  Set<Product> productsInCart = <Product>{};
  Set<Product> productsInFavorite = <Product>{};

  @override
  void initState() {
    _getFavoriteProductListCubit.getFavoriteProductList();
    _getCartProductListCubit.getCartProductList();
    _getProductListByCategoryIdCubit.getProductsByCategoryId(widget.categoryId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final Translations tr = Translations.of(context)!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: themeData.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child:
                      Text(tr.showAll, style: themeData.textTheme.labelLarge),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          MultiBlocListener(
            listeners: [
              BlocListener<GetCartProductListCubit, BaseState<List<Product>>>(
                bloc: _getCartProductListCubit,
                listener: (_, state) {
                  if (state.isSuccess) {
                    productsInCart.addAll(state.item!);
                    setState(() {});
                  }
                },
              ),
              BlocListener<GetFavoriteProductListCubit,
                  BaseState<List<Product>>>(
                bloc: _getFavoriteProductListCubit,
                listener: (_, state) {
                  if (state.isSuccess) {
                    productsInFavorite.addAll(state.item!);
                    setState(() {});
                  }
                },
              ),
            ],
            child: BlocBuilder<GetProductListByCategoryIdCubit,
                BaseState<List<Product>>>(
              bloc: _getProductListByCategoryIdCubit,
              builder: (_, state) {
                if (state.isSuccess) {
                  return SizedBox(
                    height: 205,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) => InkWell(
                        onTap: () => context.pushNamed(
                          ProductDetailsPage.path,
                          extra: state.item![index].id.toString(),
                        ),
                        child: SizedBox(
                          width: 135,
                          child: Card(
                            margin: EdgeInsets.zero,
                            shape: const RoundedRectangleBorder(
                              side: BorderSide.none,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Positioned.fill(
                                            child: Image.network(
                                                state.item![index].imageLink)),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: InkWell(
                                            onTap: () {
                                              if (productsInFavorite.contains(
                                                  state.item![index])) {
                                                _deleteProductFromFavoriteCubit
                                                    .deleteProductFromFavorite(
                                                        state.item![index].id
                                                            .toString());
                                                productsInFavorite
                                                    .remove(state.item![index]);
                                              } else {
                                                _addProductToFavoriteCubit
                                                    .addProductToCart(
                                                        state.item![index]);
                                                productsInFavorite
                                                    .add(state.item![index]);
                                              }
                                              setState(() {});
                                            },
                                            child: Icon(
                                              productsInFavorite.contains(
                                                      state.item![index])
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color:
                                                  productsInFavorite.contains(
                                                          state.item![index])
                                                      ? themeData.appColors
                                                          .secondaryColor
                                                      : null,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          state.item![index].name.toString(),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text.rich(
                                              TextSpan(
                                                text:
                                                    '${state.item![index].price} ',
                                                children: [
                                                  TextSpan(
                                                    text: tr.egp,
                                                    style: themeData
                                                        .textTheme.labelMedium!
                                                        .copyWith(
                                                      color: themeData
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                ],
                                                style: themeData
                                                    .textTheme.labelMedium!
                                                    .copyWith(
                                                  color: themeData.primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                if (productsInCart.contains(
                                                    state.item![index])) {
                                                  _deleteProductFromCartCubit
                                                      .deleteProductFromCart(
                                                          state.item![index].id
                                                              .toString());
                                                  productsInCart.remove(
                                                      state.item![index]);
                                                } else {
                                                  _addProductToCartCubit
                                                      .addProductToCart(
                                                          state.item![index]);
                                                  productsInCart
                                                      .add(state.item![index]);
                                                }
                                                setState(() {});
                                              },
                                              child: Icon(
                                                Icons.add_shopping_cart,
                                                color: productsInCart.contains(
                                                        state.item![index])
                                                    ? themeData.primaryColor
                                                    : themeData
                                                        .appColors.greyColor,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemCount: state.item!.length,
                    ),
                  );
                } else if (state.isFailure) {
                  return ErrorView(failure: state.failure);
                } else {
                  return const Loader();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
