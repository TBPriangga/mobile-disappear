// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:disappear/models/carousel_article_model.dart';
import 'package:disappear/screens/article/components/carousel_article_component.dart';
import 'package:disappear/screens/article/components/list_articles_item.dart';
import 'package:disappear/screens/article/detail_article_screen.dart';
import 'package:disappear/screens/article/placeholders/list_article_placeholder.dart';
import 'package:disappear/themes/color_scheme.dart';
import 'package:disappear/themes/text_theme.dart';
import 'package:disappear/view_models/article/carouselArticle_view_model.dart';
import 'package:disappear/view_models/article/detail_articles_view_model.dart';
import 'package:disappear/view_models/article/filter_article_view_model.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

class ArticleScreen extends StatefulWidget {
  static String routePath = '/article-screen';

  const ArticleScreen({Key? key}) : super(key: key);

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  late ArticleFilterViewModel _articleFilterViewModel;
  late CarouselArticleViewModel _carouselArticleViewModel;
  late Future _articleFuture;
  late Future _articleCarouselFuture;

  @override
  void initState() {
    super.initState();
    _articleFilterViewModel =
        Provider.of<ArticleFilterViewModel>(context, listen: false);
    _articleFilterViewModel.fetchArticles();

    _articleFuture = _articleFilterViewModel.fetchArticles();

    _carouselArticleViewModel =
        Provider.of<CarouselArticleViewModel>(context, listen: false);
    _carouselArticleViewModel.getCarouselArticles();

    _articleCarouselFuture = _carouselArticleViewModel.getCarouselArticles();
  }

  void _goToDetailArticleScreen(int id) {
    final articleViewModel =
        Provider.of<DetailArticlesViewModel>(context, listen: false);
    articleViewModel.articleId = id;

    Navigator.pushNamed(context, DetailArticleScreen.routePath);
  }

  @override
  Widget build(BuildContext context) => buildScreen(context);

  void _goToCarouselScreen() {
    Navigator.pushNamedAndRemoveUntil(
        context, CarouselArticleScreen.routePath, (route) => false);
  }

  Widget buildScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary40,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 24.0,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Artikel",
          style: semiBoldBody1.copyWith(color: whiteColor),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              _goToCarouselScreen();
            },
            icon: const Icon(
              Icons.bookmark_border_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Consumer<ArticleFilterViewModel>(
          builder: (context, viewModel, child) {
            return ListView(
              children: [
                Column(
                  children: [
                    Consumer<CarouselArticleViewModel>(
                      builder: (context, state, _) {
                        return FutureBuilder(
                          future: _articleCarouselFuture,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Center(
                                  child: Text('Artikel tidak tersedia'));
                            } else if (snapshot.hasData) {
                              return Column(
                                children: [
                                  CarouselSlider(
                                    carouselController:
                                        state.carouselController,
                                    options: CarouselOptions(
                                      height: 195.0,
                                      autoPlay: true,
                                      enlargeCenterPage: true,
                                      onPageChanged: (index, reason) {
                                        state.currentIndex = index;
                                      },
                                    ),
                                    items: (snapshot.data
                                            as List<CarouselArticleModel>)
                                        .map((carousel) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return Stack(
                                            children: [
                                              GestureDetector(
                                                onTap: () =>
                                                    _goToDetailArticleScreen(
                                                        carousel.id),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 5.0),
                                                  decoration: BoxDecoration(
                                                    color: Colors.amber,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(6.0),
                                                    ),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                        carousel.photo,
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                left: 5,
                                                right: 5,
                                                child: Container(
                                                  height: 81.0,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(6.0),
                                                      bottomRight:
                                                          Radius.circular(6.0),
                                                    ),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    carousel.title,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }).toList(),
                                  ),

                                  // Indicator Carousel
                                  // Indicator Carousel
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: (snapshot.data
                                            as List<CarouselArticleModel>)
                                        .asMap()
                                        .entries
                                        .map((entry) {
                                      return GestureDetector(
                                        onTap: () {
                                          state.carouselController
                                              .animateToPage(entry.key,
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  curve: Curves.easeInOut);
                                        },
                                        child: Container(
                                          width: 12.0,
                                          height: 12.0,
                                          margin: const EdgeInsets.symmetric(
                                            vertical: 8.0,
                                            horizontal: 4.0,
                                          ),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                entry.key == state.currentIndex
                                                    ? primary10
                                                    : primary40,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              );
                            } else {
                              return const CircularProgressIndicator();
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
                // Dropdown
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    children: [
                      const Text('Urutkan Berdasarkan'),
                      DropdownButton<int>(
                        value: viewModel.sortOption,
                        onChanged: (int? newValue) async {
                          await viewModel.changeSortOption(newValue!);
                        },
                        items: const [
                          DropdownMenuItem<int>(
                            value: 0,
                            child: Text(' Terbanyak'),
                          ),
                          DropdownMenuItem<int>(
                            value: 1,
                            child: Text(' Terlama'),
                          ),
                          DropdownMenuItem<int>(
                            value: 2,
                            child: Text(' Abjad'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Tampilan daftar artikel
                Flexible(
                  child: FutureBuilder(
                    future: _articleFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: ListArticlePlaceholder());
                      } else if (snapshot.hasError) {
                        return const Center(
                            child: Text('Artikel tidak tersedia'));
                      } else if (snapshot.hasData) {
                        return ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => ListArticleItem(
                              article: viewModel.articles[index]),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          itemCount: viewModel.articles.length,
                        );
                      } else {
                        return const ListArticlePlaceholder();
                      }
                    },
                  ),
                ),
                // const SizedBox(height: 21),
                // ElevatedButton(
                //   onPressed: () async {
                //     await viewModel.fetchArticles();
                //   },
                //   style: ElevatedButton.styleFrom(
                //     elevation: 0,
                //     backgroundColor: Colors.white,
                //     foregroundColor: Colors.blue,
                //     shape: const RoundedRectangleBorder(
                //       borderRadius: BorderRadius.all(Radius.circular(8)),
                //       side: BorderSide(width: 2, color: Colors.blue),
                //     ),
                //   ),
                //   child: const Text(
                //     'Memuat artikel lainnya',
                //     style: TextStyle(color: Colors.blue),
                //   ),
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}
