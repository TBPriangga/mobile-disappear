import 'package:disappear/models/order_detail_by_id_model.dart';
import 'package:disappear/screens/order_detail/components/address_components.dart';
import 'package:disappear/screens/order_detail/components/order_number_components.dart';
import 'package:disappear/screens/order_detail/components/order_summary_components.dart';
import 'package:disappear/screens/order_detail/components/payment_method_components.dart';
import 'package:disappear/screens/order_detail/components/products_components.dart';
import 'package:disappear/screens/order_detail/components/status_components.dart';
import 'package:disappear/themes/color_scheme.dart';
import 'package:disappear/themes/text_theme.dart';
import 'package:disappear/view_models/order/order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailOrderScreen extends StatefulWidget {
  static const String routePath = '/detail-order';

  const DetailOrderScreen({super.key});

  @override
  State<DetailOrderScreen> createState() => _DetailOrderScreenState();
}

class _DetailOrderScreenState extends State<DetailOrderScreen> {
  late final Future orderDetailFuture = _getOrder();

  Future<OrderDetailByIdModel?> _getOrder() async {
    final orderViewModel = Provider.of<OrderViewModel>(context, listen: false);
    final order = await orderViewModel.getDetailsOrderById();

    return order;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary40,
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_left,
            color: whiteColor,
            size: 32,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Rincian Pesanan',
          style: semiBoldBody1.copyWith(color: whiteColor),
        ),
        centerTitle: true,
      ),
      body: Consumer<OrderViewModel>(
        builder: (context, state, _) {
          return FutureBuilder(
            future: state.getDetailsOrderById(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: const CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return Text('No data available');
              } else {
                return ListView(
                  children: [
                    OrderStatus(orderDetail: snapshot.data!),
                    AddressComponents(orderDetail: snapshot.data!),
                    Products(orderDetail: snapshot.data!),
                    OrderSummary(orderDetail: snapshot.data!),
                    PaymentMethod(orderDetail: snapshot.data!),
                    OrderNumber(orderDetail: snapshot.data!),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 60),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            minimumSize: const Size(double.infinity, 45)),
                        child: const Text(
                          'Pesanan Diterima',
                          style: semiBoldBody7,
                        ),
                      ),
                    )
                  ],
                );
              }
            },
          );
        },
      ),
    );
  }
}