import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kortobaa_ecommerce/cart/presentation/cubits/add_product_to_cart_cubit.dart';
import 'package:kortobaa_ecommerce/cart/presentation/cubits/delete_product_from_cart_cubit.dart';
import 'package:kortobaa_ecommerce/cart/presentation/cubits/get_cart_product_cubit.dart';
import 'package:kortobaa_ecommerce/core/dynamic_link_service.dart';
import 'package:kortobaa_ecommerce/core/presentation/blocs/base_states/base_state.dart';
import 'package:kortobaa_ecommerce/core/presentation/themes/app_theme.dart';
import 'package:kortobaa_ecommerce/core/presentation/utils/generated/translation/translations.dart';
import 'package:kortobaa_ecommerce/core/presentation/widgets/error_view.dart';
import 'package:kortobaa_ecommerce/core/presentation/widgets/loader.dart';
import 'package:kortobaa_ecommerce/favorite/presentation/cubits/add_product_to_favorite_cubit.dart';
import 'package:kortobaa_ecommerce/favorite/presentation/cubits/delete_product_from_favorite_cubit.dart';
import 'package:kortobaa_ecommerce/favorite/presentation/cubits/get_favorite_product_cubit.dart';
import 'package:kortobaa_ecommerce/home/domain/entities/product.dart';
import 'package:kortobaa_ecommerce/injection.dart';
import 'package:kortobaa_ecommerce/product_details/presentation/cubits/get_product_by_id_cubit.dart';
import 'package:share_plus/share_plus.dart';

class ProductDetailsPage extends StatefulWidget {
  static String path = 'productDetailsPage';
  const ProductDetailsPage(this.id, {super.key});
  final String id;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final GetProductByIdCubit _getProductByIdCubit = getIt<GetProductByIdCubit>();

  final AddProductToCartCubit _addProductToCartCubit =
      getIt<AddProductToCartCubit>();
  final DeleteProductFromCartCubit _deleteProductFromCartCubit =
      getIt<DeleteProductFromCartCubit>();

  final AddProductToFavoriteCubit _addProductToFavoriteCubit =
      getIt<AddProductToFavoriteCubit>();
  final DeleteProductFromFavoriteCubit _deleteProductFromFavoriteCubit =
      getIt<DeleteProductFromFavoriteCubit>();

  final GetFavoriteProductCubit _getFavoriteProductCubit =
      getIt<GetFavoriteProductCubit>();

  final GetCartProductCubit _getCartProductCubit = getIt<GetCartProductCubit>();

  bool inFav = false;
  bool inCart = false;
  Product? productInCart;

  @override
  void initState() {
    _getProductByIdCubit.getProductById(widget.id);
    _getFavoriteProductCubit.getFavoriteProduct(widget.id);
    _getCartProductCubit.getCartProduct(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final Translations tr = Translations.of(context)!;
    final Locale localization = Localizations.localeOf(context);
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<GetFavoriteProductCubit, BaseState<Product?>>(
            bloc: _getFavoriteProductCubit,
            listener: (_, state) {
              if (state.isSuccess) {
                if (state.item != null) {
                  inFav = true;
                }
                setState(() {});
              }
            },
          ),
          BlocListener<GetCartProductCubit, BaseState<Product?>>(
            bloc: _getCartProductCubit,
            listener: (_, state) {
              if (state.isSuccess) {
                if (state.item != null) {
                  inCart = true;
                  productInCart = state.item;
                }
                setState(() {});
              }
            },
          ),
        ],
        child: BlocBuilder<GetProductByIdCubit, BaseState<Product>>(
          bloc: _getProductByIdCubit,
          builder: (_, state) {
            if (state.isSuccess) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    title: Text(state.item!.name),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Padding(
                        padding:
                            const EdgeInsets.only(top: kToolbarHeight + 50),
                        child: Image.network(
                          state.item!.imageLink,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(kToolbarHeight),
                        child: Container(
                          height: kToolbarHeight,
                          color: Colors.white,
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    if (inFav) {
                                      _deleteProductFromFavoriteCubit
                                          .deleteProductFromFavorite(
                                              state.item!.id.toString());
                                    } else {
                                      _addProductToFavoriteCubit
                                          .addProductToCart(state.item!);
                                    }
                                    inFav = !inFav;

                                    setState(() {});
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.favorite,
                                        color: inFav
                                            ? themeData.appColors.secondaryColor
                                            : themeData.appColors.greyColor,
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        inFav
                                            ? tr.addedToCart
                                            : tr.addToFavorite,
                                        style: themeData.textTheme.bodyMedium!
                                            .copyWith(
                                          color: inFav
                                              ? themeData
                                                  .appColors.secondaryColor
                                              : null,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const VerticalDivider(),
                              Expanded(
                                child: InkWell(
                                  onTap: () => DynamicLinkHandler.I
                                      .createDynamicLink(state.item!)
                                      .then(
                                        (value) => Share.share(value),
                                      ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.share,
                                        color: themeData.appColors.greyColor,
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        tr.shareApp,
                                        style: themeData.textTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                    elevation: 1.0,
                    expandedHeight: 400,
                  ),
                  SliverList(
                      delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.item!.name,
                            textAlign: TextAlign.start,
                            style: themeData.textTheme.headlineSmall,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${state.item!.price} ${tr.egp}',
                                  style:
                                      themeData.textTheme.titleMedium!.copyWith(
                                    color: themeData.primaryColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      state.item!.rate,
                                      style: themeData.textTheme.titleSmall,
                                    ),
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amberAccent,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          const Divider(),
                          ExpansionTile(
                            title: Text(tr.description),
                            children: [
                              Text(
                                state.item!.description,
                                style: themeData.textTheme.titleMedium,
                              ),
                            ],
                          ),
                          const Divider(),
                          SizedBox(
                            height: 44,
                            child: Row(
                              children: [
                                Expanded(
                                    child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        state.item!.quantity--;
                                        setState(() {});
                                        if (state.item!.quantity == 0) {
                                          _deleteProductFromCartCubit
                                              .deleteProductFromCart(
                                                  state.item!.id.toString());
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: localization
                                                        .languageCode ==
                                                    'ar'
                                                ? const BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(4),
                                                    bottomRight:
                                                        Radius.circular(4),
                                                  )
                                                : const BorderRadius.only(
                                                    topLeft: Radius.circular(4),
                                                    bottomLeft:
                                                        Radius.circular(4),
                                                  ),
                                            color: themeData.primaryColor),
                                        padding: const EdgeInsets.all(16),
                                        child: const Icon(
                                          Icons.remove,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 44,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        child: Center(
                                          child: Text(
                                            state.item!.quantity.toString(),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        state.item!.quantity++;
                                        setState(() {});
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: localization
                                                        .languageCode ==
                                                    'ar'
                                                ? const BorderRadius.only(
                                                    topLeft: Radius.circular(4),
                                                    bottomLeft:
                                                        Radius.circular(4),
                                                  )
                                                : const BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(4),
                                                    bottomRight:
                                                        Radius.circular(4),
                                                  ),
                                            color: themeData.primaryColor),
                                        padding: const EdgeInsets.all(16),
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: SizedBox(
                                    height: 44,
                                    child: Card(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${(double.tryParse(state.item!.price) ?? 0.0) * state.item!.quantity} ${tr.egp}',
                                          textAlign: TextAlign.center,
                                          style:
                                              themeData.textTheme.headlineSmall,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 28),
                          Center(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      inCart ? themeData.appColors.green : null,
                                ),
                                onPressed: () {
                                  if (inCart) {
                                    _deleteProductFromCartCubit
                                        .deleteProductFromCart(
                                            state.item!.id.toString());
                                  } else {
                                    _addProductToCartCubit
                                        .addProductToCart(state.item!);
                                  }
                                  inCart = !inCart;

                                  setState(() {});
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.add_shopping_cart),
                                    const SizedBox(width: 12),
                                    Text(inCart ? tr.addedToCart : tr.addToCart)
                                  ],
                                )),
                          )
                        ],
                      ),
                    ),
                  ]))
                ],
              );
            } else if (state.isFailure) {
              return ErrorView(failure: state.failure);
            } else {
              return const Loader();
            }
          },
        ),
      ),
    );
  }
}
