import 'package:dio/dio.dart';
import 'package:disappear/models/checkout/address/checkout_address_model.dart';
import 'package:disappear/models/checkout/created_order_model.dart';
import 'package:disappear/models/checkout/voucher/checkout_voucher_model.dart';
import 'package:disappear/services/api.dart';

class CheckoutService {
  Future<List<CheckoutVoucher>> fetchVoucher() async {
    final dio = createDio();

    final Response response = await dio.get('/vouchers/users');

    if (response.data['data'] != null) {
      return response.data['data']
        .map<CheckoutVoucher>((data) => CheckoutVoucher.fromMap(data))
        .toList();
    }

    return [];
  }

  Future<List<CheckoutAddress>> fetchAddress({ int page = 1 }) async {
    final dio = createDio();

    final Response response = await dio.get('/address?page=$page');

    if (response.data['data'] != null) {
      return response.data['data']
        .map<CheckoutAddress>((data) => CheckoutAddress.fromMap(data))
        .toList();
    }

    return [];
  }

  Future<CreatedOrder> createOrder({
    required int productId,
    required int addressId,
    required String note,
    required String paymentMethod,
    int? voucherId,
  }) async {
    final dio = createDio();

    final Response response = await dio.post(
      '/order',
      data: {
        'product_id': productId,
        'address_id': addressId,
        'voucher_id': voucherId,
        'note': note,
        'payment_method': paymentMethod,
        'shipment_fee': 0,
        'quantity': 1,
      }
    );

    return CreatedOrder.fromMap(response.data['data']);
  }
}