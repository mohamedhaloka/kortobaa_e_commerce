import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kortobaa_ecommerce/cart/presentation/cubits/add_product_to_cart_cubit.dart';
import 'package:kortobaa_ecommerce/cart/presentation/cubits/delete_product_from_cart_cubit.dart';
import 'package:kortobaa_ecommerce/cart/presentation/cubits/get_cart_product_list_cubit.dart';
import 'package:kortobaa_ecommerce/cart/presentation/widgets/apply_coupon_input.dart';
import 'package:kortobaa_ecommerce/core/presentation/blocs/base_states/base_state.dart';
import 'package:kortobaa_ecommerce/core/presentation/themes/app_theme.dart';
import 'package:kortobaa_ecommerce/core/presentation/utils/generated/translation/translations.dart';
import 'package:kortobaa_ecommerce/core/presentation/utils/sliver_grid_delegate_with_fixed_height.dart';
import 'package:kortobaa_ecommerce/home/domain/entities/product.dart';
import 'package:kortobaa_ecommerce/injection.dart';

class CartPage extends StatefulWidget {
  static String path = '/cartPage';
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  static const platform = MethodChannel('order_methods');

  final GetCartProductListCubit _getCartProductListCubit =
      getIt<GetCartProductListCubit>();
  final AddProductToCartCubit _addProductToCartCubit =
      getIt<AddProductToCartCubit>();
  final DeleteProductFromCartCubit _deleteProductFromCartCubit =
      getIt<DeleteProductFromCartCubit>();

  Set<Product> products = <Product>{};

  double get totalPrice => products.fold(
      0.0,
      (sum, item) =>
          sum + (item.quantity * (double.tryParse(item.price) ?? 0.0)));

  @override
  void initState() {
    _getCartProductListCubit.getCartProductList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Translations tr = Translations.of(context)!;
    final Size screenSize = MediaQuery.sizeOf(context);
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        title: Text(tr.cart),
        centerTitle: true,
        elevation: 3,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
      body: BlocListener<GetCartProductListCubit, BaseState>(
        bloc: _getCartProductListCubit,
        listener: (_, state) {
          if (state.isSuccess) {
            products.addAll(state.item);
            setState(() {});
          }
        },
        child: products.isEmpty
            ? Center(
                child: Text(tr.cartEmpty),
              )
            : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 12),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: '(${products.length}) ',
                            children: [
                              TextSpan(
                                text: tr.item,
                                style: themeData.textTheme.titleMedium,
                              ),
                            ],
                            style: themeData.textTheme.titleMedium!.copyWith(
                              color: themeData.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            text: '${tr.total}: ',
                            children: [
                              TextSpan(
                                text:
                                    '${totalPrice.toStringAsFixed(2)} ${tr.egp}',
                                style: themeData.textTheme.titleMedium,
                              ),
                            ],
                            style: themeData.textTheme.titleMedium!.copyWith(
                              color: themeData.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GridView.builder(
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                      crossAxisCount: screenSize.width > 500 ? 3 : 1,
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 12.0,
                      height: 156,
                    ),
                    itemBuilder: (_, index) => _CartItemWidget(
                      products.toList()[index],
                      onUpdate: (product) {
                        _addProductToCartCubit.addProductToCart(product);
                        products.add(product);
                        setState(() {});
                      },
                      onDelete: (product) {
                        _deleteProductFromCartCubit
                            .deleteProductFromCart(product.id.toString());
                        products.remove(product);
                        setState(() {});
                      },
                    ),
                    itemCount: products.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  ),
                  const ApplyCouponInput(),
                  Card(
                    shape: const RoundedRectangleBorder(side: BorderSide.none),
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          _CartDetailsItemWidget(
                              title: tr.total, value: totalPrice),
                          const SizedBox(height: 14),
                          _CartDetailsItemWidget(title: tr.fees, value: 5.0),
                          const Divider(height: 28),
                          _CartDetailsItemWidget(
                              title: tr.totalWithFees, value: totalPrice + 5),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => platform.invokeMethod(
                      'confirmOrder',
                      {
                        'paymentUrl':
                            'https://www.linkedin.com/company/kortobaa/',
                      },
                    ),
                    child: Text(tr.confirmOrder),
                  )
                ],
              ),
      ),
    );
  }
}

class _CartItemWidget extends StatefulWidget {
  const _CartItemWidget(
    this.product, {
    required this.onDelete,
    required this.onUpdate,
  });
  final Product product;
  final void Function(Product) onUpdate;
  final void Function(Product) onDelete;

  @override
  State<_CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<_CartItemWidget> {
  late double productPrice;

  @override
  void initState() {
    productPrice = double.tryParse(widget.product.price) ?? 0.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final Translations tr = Translations.of(context)!;
    return SizedBox(
      height: 156,
      child: Card(
        shape: const RoundedRectangleBorder(
          side: BorderSide.none,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 112,
              child: Row(
                children: [
                  SizedBox(
                    width: 125,
                    child: Image.network(
                      widget.product.imageLink,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.product.name,
                          style: themeData.textTheme.titleMedium,
                        ),
                        Text.rich(
                          TextSpan(
                            text: '${widget.product.price} ',
                            children: [
                              TextSpan(
                                text: tr.egp,
                                style:
                                    themeData.textTheme.titleMedium!.copyWith(
                                  color: themeData.primaryColor,
                                ),
                              ),
                            ],
                            style: themeData.textTheme.titleMedium!.copyWith(
                              color: themeData.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
                ],
              ),
            ),
            const Divider(height: 0, thickness: 2),
            Expanded(
              child: Row(
                children: [
                  SizedBox(
                    width: 125,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            color: themeData.primaryColor,
                            child: IconButton(
                              onPressed: () {
                                widget.product.quantity++;

                                widget.onUpdate(widget.product);
                              },
                              icon: Icon(
                                Icons.add,
                                color: themeData.appColors.whiteColor,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            child: Text(
                          widget.product.quantity.toString(),
                          textAlign: TextAlign.center,
                        )),
                        Expanded(
                            child: Container(
                          color: themeData.primaryColor,
                          child: IconButton(
                            onPressed: () {
                              widget.product.quantity--;
                              if (widget.product.quantity == 0) {
                                widget.onDelete(widget.product);
                              } else {
                                widget.onUpdate(widget.product);
                              }
                            },
                            icon: Icon(
                              Icons.remove,
                              color: themeData.appColors.whiteColor,
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          '${widget.product.quantity * productPrice} ${tr.egp}',
                          textAlign: TextAlign.center,
                          style: themeData.textTheme.labelLarge,
                        )),
                        Container(
                          color: themeData.appColors.secondaryColor,
                          child: IconButton(
                            onPressed: () => widget.onDelete(widget.product),
                            icon: Icon(
                              Icons.delete_forever,
                              color: themeData.appColors.whiteColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartDetailsItemWidget extends StatelessWidget {
  const _CartDetailsItemWidget({required this.title, required this.value});
  final String title;
  final double value;

  @override
  Widget build(BuildContext context) {
    final Translations tr = Translations.of(context)!;
    final ThemeData themeData = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: themeData.textTheme.titleMedium!.copyWith(
            color: themeData.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '${value.toStringAsFixed(2)} ${tr.egp}',
          style: themeData.textTheme.titleMedium,
        ),
      ],
    );
  }
}
