import 'package:disappear/screens/checkout/use_coupon_screen.dart';
import 'package:disappear/themes/color_scheme.dart';
import 'package:disappear/themes/text_theme.dart';
import 'package:disappear/view_models/checkout/checkout_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

//INFORMASI PESANAN KOMPONEN CHECKOUT SCREEN//

class OrderInformation extends StatefulWidget {
  const OrderInformation({super.key});

  @override
  State<OrderInformation> createState() => _OrderInformationState();
}

class _OrderInformationState extends State<OrderInformation> {
  void _goToCouponScreen() {
    Navigator.of(context).pushNamed(UseCouponScreen.routePath);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Container(
            color: neutral00,
            padding: const EdgeInsets.only(top: 15, bottom: 15, left: 25),
            height: 48,
            width: double.infinity,
            child: const Text(
              'Informasi Pesanan',
              style: semiBoldBody7,
            ),
          ),
          Consumer<CheckoutViewModel>(
            builder: (context, state, _) {
              if (state.purchaseType == 'buy-now') {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  child: OrderItem(
                    imageUrl: state.product!.thumbnail?.imageUrl,
                    name: state.product!.name!,
                    gramPlastic: state.product!.gramPlastic!,
                    formattedPrice: state.product!.formattedPrice,
                    quantity: 1,
                  )
                );
              }
              
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                itemBuilder: (context, index) => const OrderItem(imageUrl: '', name: '', gramPlastic: 0, formattedPrice: '', quantity: 1,),
                separatorBuilder: (context, index) => const SizedBox(height: 20,),
                itemCount: 3,
              );
            }
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Consumer<CheckoutViewModel>(
              builder: (context, state, _) {
                return TextFormField(
                  controller: state.notesController,
                  decoration: const InputDecoration(
                    fillColor: Colors.transparent,
                    hintText: 'Tambah Catatan',
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.all(12),
                  ),
                  maxLines: null,
                );
              }
            ),
          ),
          InkWell(
            onTap: _goToCouponScreen,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              decoration: const BoxDecoration(
                border: Border.symmetric(horizontal: BorderSide(width: 1, color: neutral00))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/img/CheckoutCoupon.svg'),
                      const SizedBox(width: 10),
                      const Text(
                        'Kupon Toko',
                        style: mediumBody7,
                      )
                    ],
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: primary40,
                    size: 14,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final int gramPlastic;
  final String formattedPrice;
  final int quantity;

  const OrderItem({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.gramPlastic,
    required this.formattedPrice,
    required this.quantity
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: Builder(
                  builder: (context) {
                    if (imageUrl != null) {
                      return Image.network(
                        imageUrl!,
                        fit: BoxFit.cover,
                        width: 68,
                        height: 78,
                      );
                    }

                    return Image.asset(
                      'assets/img/totebeg_kanvas.png',
                      fit: BoxFit.cover,
                      width: 68,
                      height: 78,
                    );
                  }
                ),
              ),
              const SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: mediumBody6,
                  ),
                  const SizedBox(height: 6),
                  Text('$gramPlastic Gram', style: regularBody8),
                  const SizedBox(height: 5),
                  Text(formattedPrice, style: mediumBody6)
                ],
              )
            ],
          ),
        ),
        Text('x $quantity', style: mediumBody6)
      ],
    );
  }
}