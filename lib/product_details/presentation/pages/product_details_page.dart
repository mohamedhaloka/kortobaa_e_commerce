import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kortobaa_ecommerce/cart/presentation/cubits/add_product_to_cart_cubit.dart';
import 'package:kortobaa_ecommerce/cart/presentation/cubits/delete_product_from_cart_cubit.dart';
import 'package:kortobaa_ecommerce/cart/presentation/pages/cart_page.dart';
import 'package:kortobaa_ecommerce/core/presentation/blocs/base_states/base_state.dart';
import 'package:kortobaa_ecommerce/core/presentation/widgets/error_view.dart';
import 'package:kortobaa_ecommerce/core/presentation/widgets/loader.dart';
import 'package:kortobaa_ecommerce/home/domain/entities/product.dart';
import 'package:kortobaa_ecommerce/injection.dart';
import 'package:kortobaa_ecommerce/product_details/presentation/cubits/get_product_by_id_cubit.dart';

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

  @override
  void initState() {
    _getProductByIdCubit.getProductById(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      body: BlocBuilder<GetProductByIdCubit, BaseState<Product>>(
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
                      padding: const EdgeInsets.only(top: kToolbarHeight + 50),
                      child: Image.network(
                        state.item!.imageLink,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  elevation: 1.0,
                  expandedHeight: 400,
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          state.item!.name,
                          style: themeData.textTheme.headlineSmall,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${state.item!.price} ج.م',
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
                          title: const Text('الوصف'),
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
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(4),
                                            bottomRight: Radius.circular(4),
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
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(4),
                                            bottomLeft: Radius.circular(4),
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${state.item!.price * state.item!.quantity} ج.م',
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
                              onPressed: () {
                                _addProductToCartCubit
                                    .addProductToCart(state.item!);
                                context.pushNamed(CartPage.path);
                              },
                              child: const Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_shopping_cart),
                                  SizedBox(width: 12),
                                  Text('أضف للسلة')
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
    );
  }
}
