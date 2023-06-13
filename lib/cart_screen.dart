import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_provide.dart';
import 'dart_model.dart';
import 'db_helper.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  DBHelper dbHelper = DBHelper();
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Products'),
        centerTitle: true,
        actions: [
          Center(
            child: badges.Badge(
              badgeContent: Consumer<CartProvider>(
                builder: (context, value, child) {
                  return Text(value.getCounter().toString(),
                      style: const TextStyle(color: Colors.white));
                },
              ),
              child: const Icon(Icons.shopping_bag_outlined),
            ),
          ),
          const SizedBox(width: 20)
        ],
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: cart.getData(),
              builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Image(
                                            height: 100,
                                            width: 100,
                                            image: NetworkImage(snapshot
                                                .data![index].image
                                                .toString())),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    snapshot.data![index]
                                                        .productName
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  InkWell(
                                                      onTap: () {
                                                        dbHelper.delete(snapshot
                                                            .data![index].id!);
                                                        cart.removeCounter();
                                                        cart.removeTotalPrice(
                                                            snapshot
                                                                .data![index]
                                                                .productPrice!
                                                                .toDouble());
                                                      },
                                                      child: const Icon(
                                                          Icons.delete))
                                                ],
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                snapshot.data![index].unitTag
                                                        .toString() +
                                                    " " +
                                                    r"$" +
                                                    snapshot.data![index]
                                                        .initialPrice
                                                        .toString(),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              const SizedBox(height: 5),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: InkWell(
                                                    onTap: () {},
                                                    child: Container(
                                                      height: 35,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: Colors.green),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              int quantity =
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .quantity!;

                                                              int price = snapshot
                                                                  .data![index]
                                                                  .initialPrice!;
                                                              quantity++;
                                                              int newPrice =
                                                                  quantity *
                                                                      price;

                                                              dbHelper
                                                                  .update(Cart(
                                                                      id: snapshot
                                                                          .data![
                                                                              index]
                                                                          .id,
                                                                      productPrice:
                                                                          newPrice,
                                                                      image: snapshot
                                                                          .data![
                                                                              index]
                                                                          .image,
                                                                      initialPrice: snapshot
                                                                          .data![
                                                                              index]
                                                                          .initialPrice,
                                                                      productId: snapshot
                                                                          .data![
                                                                              index]
                                                                          .productId,
                                                                      productName: snapshot
                                                                          .data![
                                                                              index]
                                                                          .productName,
                                                                      quantity:
                                                                          quantity,
                                                                      unitTag: snapshot
                                                                          .data![
                                                                              index]
                                                                          .unitTag))
                                                                  .then(
                                                                      (value) {
                                                                newPrice = 0;
                                                                quantity = 0;
                                                                cart.addTotalPrice(snapshot
                                                                    .data![
                                                                        index]
                                                                    .initialPrice!
                                                                    .toDouble());
                                                              });
                                                            },
                                                            child: const Icon(
                                                              Icons.add,
                                                            ),
                                                          ),
                                                          Center(
                                                              child: Text(
                                                            snapshot
                                                                .data![index]
                                                                .quantity!
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          )),
                                                          InkWell(
                                                            onTap: () {},
                                                            child: const Icon(
                                                              Icons.remove,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }));
                }
                return const Text('');
              }),
          Consumer<CartProvider>(builder: (context, value, child) {
            return Visibility(
              visible: value.getTotalPrice().toStringAsFixed(2) == '0.00'
                  ? false
                  : true,
              child: Column(
                children: [
                  ReusableWidget(
                      title: 'Sub Total',
                      value: r'$' + value.getTotalPrice().toStringAsFixed(2))
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}

class ReusableWidget extends StatelessWidget {
  final String title, value;
  const ReusableWidget({super.key, required this.title, required this.value});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleSmall),
          Text(value, style: Theme.of(context).textTheme.titleSmall),
        ],
      ),
    );
  }
}
