import 'package:fic9_ecommerce_template_app/common/extensions/int_ext.dart';
import 'package:fic9_ecommerce_template_app/presentation/cart/bloc/cart/cart_bloc.dart';
import 'package:fic9_ecommerce_template_app/presentation/cart/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/components/button.dart';
import '../../common/components/row_text.dart';
import '../../common/components/space_height.dart';
import '../../common/constants/colors.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final ongkir = 150000;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                loaded: (carts) {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) =>
                        const SpaceHeight(16.0),
                    itemCount: carts.length,
                    itemBuilder: (context, index) {
                      return CartItemWidget(
                        data: carts[index],
                      );
                    },
                  );
                },
              );
            },
          ),
          const SpaceHeight(70.0),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              border: Border.all(color: ColorName.border),
            ),
            child: Column(
              children: [
                BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return RowText(
                          label: 'Total Harga',
                          value: 0.currencyFormatRp,
                        );
                      },
                      loaded: (carts) {
                        int totalPrice = 0;
                        for (var element in carts) {
                          totalPrice +=
                              int.parse(element.product.attributes!.price!) *
                                  element.quantity;
                        }
                        return RowText(
                          label: 'Total Harga',
                          value: totalPrice.currencyFormatRp,
                        );
                      },
                    );
                  },
                ),
                // RowText(
                //   label: 'Total Price',
                //   value: 1750000.currencyFormatRp,
                // ),
                const SpaceHeight(12.0),
                RowText(
                  label: 'Biaya Pengiriman',
                  value: (ongkir).currencyFormatRp,
                ),
                const SpaceHeight(40.0),
                const Divider(color: ColorName.border),
                const SpaceHeight(12.0),
                BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return RowText(
                          label: 'Total Harga',
                          value: 0.currencyFormatRp,
                          valueColor: ColorName.primary,
                          fontWeight: FontWeight.w700,
                        );
                      },
                      loaded: (carts) {
                        int totalPrice = 0;
                        for (var element in carts) {
                          totalPrice +=
                              int.parse(element.product.attributes!.price!) *
                                  element.quantity;
                        }
                        final total = totalPrice + ongkir;
                        return RowText(
                          label: 'Total Harga',
                          value: total.currencyFormatRp,
                          valueColor: ColorName.primary,
                          fontWeight: FontWeight.w700,
                        );
                      },
                    );
                  },
                ),
                const SpaceHeight(16.0),
                Button.filled(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const PaymentPage(
                    //             url: '',
                    //           )),
                    // );
                  },
                  label: 'Bayar Sekarang',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
