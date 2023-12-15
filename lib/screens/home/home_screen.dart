import 'package:disappear/models/home/carousel_category_product_model.dart' as model;
import 'package:disappear/models/home/challenge_article.dart';
import 'package:disappear/screens/chatbot/new_chatbot_screen.dart';
import 'package:disappear/screens/home/components/latest_articles.dart';
import 'package:disappear/screens/home/components/latest_challenges.dart';
import 'package:disappear/screens/home/components/placeholders/categories_placeholder.dart';
import 'package:disappear/screens/home/components/best_seller_products.dart';
import 'package:disappear/screens/home/components/carousel.dart';
import 'package:disappear/screens/home/components/categories.dart';
import 'package:disappear/screens/home/components/placeholders/best_seller_products_placeholder.dart';
import 'package:disappear/screens/home/components/placeholders/carousel_placeholder.dart';
import 'package:disappear/screens/home/components/placeholders/challenges_placeholder.dart';
import 'package:disappear/screens/home/components/placeholders/latest_articles_placeholder.dart';
import 'package:disappear/screens/home/components/search_field.dart';
import 'package:disappear/screens/notification/notification_screen.dart';
import 'package:disappear/screens/cart/cart_screen.dart';
import 'package:disappear/themes/color_scheme.dart';
import 'package:disappear/view_models/cart/cart_view_model.dart';
import 'package:disappear/view_models/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routePath = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Future<model.CarouselCategoryProduct> _carouselCategoryProductFuture;

  late final Future<ChallengeArticle> _challengeArticleFuture;

  @override
  void initState() {
    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);

    _carouselCategoryProductFuture =
        homeViewModel.getCarouselsCategoriesAndProducts();
    _challengeArticleFuture = homeViewModel.getChallengesAndArticles();

    super.initState();
  }

  void _goToNotificationScreen() {
    Navigator.pushNamed(context, NotificationScreen.routePath);
  }

  void _goToCartScreen() {
    final cartViewModel = Provider.of<CartViewModel>(context, listen: false);
    cartViewModel.getCart();
    
    Navigator.pushNamed(context, CartScreen.routePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.pushNamed(context, NewChatbotScreen.routePath);
        },
        child: Image.asset(
          'assets/img/Secretary.png',
          fit: BoxFit.cover,
          width: 60,
          height: 60,
        ),
      ),
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Image.asset(
          'assets/img/DisappearLogo.png',
          height: 30,
          width: 100,
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: _goToNotificationScreen,
            icon: SvgPicture.asset('assets/img/NotificationIcon.svg'),
          ),
          IconButton(
              onPressed: _goToCartScreen,
              icon: SvgPicture.asset('assets/img/CartIcon.svg')),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        shrinkWrap: true,
        children: [
          const SearchField(),
          const SizedBox(
            height: 14,
          ),
          Consumer<HomeViewModel>(builder: (context, state, _) {
            return FutureBuilder(
                future: _carouselCategoryProductFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Carousel(carousels: snapshot.data!.carousel,),
                        const SizedBox(height: 20,),
                        Categories(categories: snapshot.data!.category,),
                        const SizedBox(height: 20,),
                        BestSellerProducts(products: snapshot.data!.product),
                      ],
                    );
                  }

                  if (snapshot.hasError) {
                    return const SizedBox.shrink();
                  }

                  return const Column(
                    children: [
                      CarouselPlaceholder(),
                      SizedBox(
                        height: 20,
                      ),
                      CategoriesPlaceholder(),
                      SizedBox(
                        height: 20,
                      ),
                      BestSellerProductsPlaceholder()
                    ],
                  );
                });
          }),
          const SizedBox(
            height: 20,
          ),
          Consumer<HomeViewModel>(builder: (context, state, _) {
            return FutureBuilder(
                future: _challengeArticleFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LatestChallenges(challenges: snapshot.data!.challenge),
                        const SizedBox(height: 20,),
                        LatestArticles(articles: snapshot.data!.articles),
                      ],
                    );
                  }

                  if (snapshot.hasError) {
                    return const SizedBox.shrink();
                  }

                  return const Column(
                    children: [
                      ChallengesPlaceholder(),
                      SizedBox(
                        height: 20,
                      ),
                      LatestArticlesPlaceholder()
                    ],
                  );
                });
          }),
        ],
      ),
    );
  }
}
