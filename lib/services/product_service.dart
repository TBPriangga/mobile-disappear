import 'package:dio/dio.dart';
import 'package:disappear/models/product_model.dart';
import 'package:disappear/services/api.dart';

const dummyData = [
  {
    "id": 1,
    "name": "Hello 8",
    "price": 100000,
    "rating": 0,
    "image_url": [
      {
        "id": 1,
        "image_url": "https://res.cloudinary.com/dufa4bel6/image/upload/v1700487557/disappear/njzyjhbuv1robeglty1e.jpg"
      },
      {
        "id": 2,
        "image_url": "https://res.cloudinary.com/dufa4bel6/image/upload/v1700487567/disappear/lc2fbsdzy3glxc1aqifr.jpg"
      },
      {
        "id": 3,
        "image_url": "https://res.cloudinary.com/dufa4bel6/image/upload/v1700487572/disappear/a4qmtkw5bo8wtsqay8ph.jpg"
      },
      {
        "id": 4,
        "image_url": "https://res.cloudinary.com/dufa4bel6/image/upload/v1700487589/disappear/cqbzezuluerybn6wsldc.jpg"
      }
    ],
  },
  {
    "id": 2,
    "name": "Hello 10",
    "price": 100000,
    "rating": 0,
    "image_url": [
      {
        "id": 5,
        "image_url": "https://res.cloudinary.com/dufa4bel6/image/upload/v1700487615/disappear/htsr3fakil3s1ysi71si.jpg"
      },
      {
        "id": 6,
        "image_url": "https://res.cloudinary.com/dufa4bel6/image/upload/v1700487620/disappear/fwyugrwzfj90uhfblo0h.jpg"
      }
    ],
  },
  {
    "id": 3,
    "name": "Test update Product",
    "price": 100000,
    "rating": 0,
    "image_url": [
      {
        "id": 7,
        "image_url": "https://res.cloudinary.com/dufa4bel6/image/upload/v1700988762/disappear/paybvz3r7l60wzvhjsam.webp"
      },
      {
        "id": 8,
        "image_url": "https://res.cloudinary.com/dufa4bel6/image/upload/v1700988766/disappear/di8tmdbosgcdcly9oazw.webp"
      }
    ],
  },
  {
    "id": 4,
    "name": "Test update Product",
    "price": 100000,
    "rating": 0,
    "image_url": [
      {
        "id": 7,
        "image_url": "https://res.cloudinary.com/dufa4bel6/image/upload/v1700988762/disappear/paybvz3r7l60wzvhjsam.webp"
      },
      {
        "id": 8,
        "image_url": "https://res.cloudinary.com/dufa4bel6/image/upload/v1700988766/disappear/di8tmdbosgcdcly9oazw.webp"
      }
    ],
  },
  {
    "id": 4,
    "name": "Test update Product",
    "price": 100000,
    "rating": 0,
    "image_url": [
      {
        "id": 7,
        "image_url": "https://res.cloudinary.com/dufa4bel6/image/upload/v1700988762/disappear/paybvz3r7l60wzvhjsam.webp"
      },
      {
        "id": 8,
        "image_url": "https://res.cloudinary.com/dufa4bel6/image/upload/v1700988766/disappear/di8tmdbosgcdcly9oazw.webp"
      }
    ],
  },
  {
    "id": 4,
    "name": "Test update Product",
    "price": 100000,
    "rating": 0,
    "image_url": [
      {
        "id": 7,
        "image_url": "https://res.cloudinary.com/dufa4bel6/image/upload/v1700988762/disappear/paybvz3r7l60wzvhjsam.webp"
      },
      {
        "id": 8,
        "image_url": "https://res.cloudinary.com/dufa4bel6/image/upload/v1700988766/disappear/di8tmdbosgcdcly9oazw.webp"
      }
    ],
  },
];

class ProductService {
  Future<List<ProductModel>> getBestSellerProducts() async {
    final dio = createDio();

    // final Response response = await dio.get('/products?page=1&pageSize=5');
    final response = await Future.delayed(const Duration(seconds: 1), () => dummyData);

    // return response.data['data']
    return response
      .map<ProductModel>((data) {
        final product = ProductModel(
          id: data['id'] as int,
          name: data['name'] as String,
          rating: data['rating'] as int,
          price: data['price'] as int
        );

        product.addImagesFromListOfMap(data['image_url'] as List<Map<dynamic, dynamic>>);

        return product;
      })
      .toList();
  }

  Future<List<ProductModel>> getProducts({
    required String keyword,
    required int page,
    int pageSize = 4,
    bool withPromo = false,
    int filterType = 0,
  }) async {
    final dio = createDio();

    // final Response response = await dio.get('/products?page=1&pageSize=5');
    final response = await Future.delayed(const Duration(seconds: 1), () => dummyData);

    // return response.data['data']
    return response
      .map<ProductModel>((data) {
        final product = ProductModel(
          id: data['id'] as int,
          name: data['name'] as String,
          rating: data['rating'] as int,
          price: data['price'] as int
        );

        product.addImagesFromListOfMap(data['image_url'] as List<Map<dynamic, dynamic>>);

        return product;
      })
      .toList();
  }
}