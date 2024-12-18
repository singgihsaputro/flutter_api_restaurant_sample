import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:api_integration/data/repository.dart';
import 'package:api_integration/util/json.dart';
import 'package:api_integration/widget/restaurant_item.dart';

import '../model/restaurant.dart';

class RestaurantList extends StatefulWidget {
  const RestaurantList({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  var restaurantList = [];
  var _loading = true;

  @override
  void initState() {
    super.initState();
    getDataResto();
  }

  Future<void> getDataResto() async {
    try {
      var data = await Repository().loadRestaurantList();
      setState(() {
        _loading = false;
        restaurantList = data;
      });
    } catch (error) {
      setState(() {
        _loading = false;
      });
      _showErrorSnackBar();
    }
  }

  void _showErrorSnackBar() {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Sistem sedang dalam perbaikan, coba sesaat lagi'),
        action: SnackBarAction(
            label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? CircularProgressIndicator()
        : Expanded(
        child: Container(
          alignment: Alignment.centerLeft,
          child: ListView.builder(
            itemCount: restaurantList.length,
            itemBuilder: (context, index) => RestaurantItem(
                restaurant: Restaurant.fromJson(restaurantList[index])),
          ),
        ));
  }
}