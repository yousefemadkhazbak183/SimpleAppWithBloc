import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:to_do_app_with_cubit_bloc/model/product_model.dart';

class ProductRepo {
  getProductDate() async {
    var url = Uri.https('fakestoreapi.com', 'products');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> list = jsonDecode(response.body);
      return list.map((json) => ProductModel.fromMap(json)).toList();
    } else {
      throw Exception('Fail to Get Product');
    }
  }
}
