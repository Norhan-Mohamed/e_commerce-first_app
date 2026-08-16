import 'package:e_commerce/network/dataBaseModel.dart';
import 'package:e_commerce/screens/constant.dart';
import 'package:flutter/material.dart';

import '../../network/cartDatabase.dart';
import '../../network/favDatabase.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  late Future<List<DataBaseModel>> _cartFuture;

  @override
  void initState() {
    super.initState();
    _cartFuture = CartDataProvider.instance.getData();
  }

  void _reload() {
    setState(() {
      _cartFuture = CartDataProvider.instance.getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Your Cart",
          style: TextStyle(
              color: Constants.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 30),
        ),
      ),
      body: FutureBuilder<List<DataBaseModel>>(
          future: _cartFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    'Your cart is empty',
                    style: TextStyle(color: Constants.secondryColor),
                  ),
                );
              }
              return GridView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final item = snapshot.data![index];
                  return Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Constants.thirdColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Constants.secondryColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: NetworkImage("https://${item.imageUrl}"),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 13),
                        ),
                        Text(
                          item.brandName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                        ),
                        Text(
                          "\$${item.price}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Material(
                              color: Constants.primaryColor,
                              borderRadius: BorderRadius.circular(5),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(5),
                                onTap: () async {
                                  await FavDataProvider.instance
                                      .insert(DataBaseModel(
                                    id: item.id,
                                    name: item.name,
                                    imageUrl: item.imageUrl,
                                    colour: item.colour,
                                    colourWayId: item.colourWayId,
                                    brandName: item.brandName,
                                    price: item.price,
                                  ));
                                },
                                child: const SizedBox(
                                  height: 28,
                                  width: 28,
                                  child: Icon(
                                    Icons.favorite,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Material(
                              color: Constants.secondryColor,
                              borderRadius: BorderRadius.circular(5),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(5),
                                onTap: () async {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                            'Do You Want To Delete This Item ?',
                                            style: TextStyle(
                                              color: Constants.secondryColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          actions: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  shape: const StadiumBorder(),
                                                  foregroundColor:
                                                      Constants.primaryColor,
                                                  backgroundColor:
                                                      Constants.secondryColor),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                'Cancel',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  shape: const StadiumBorder(),
                                                  foregroundColor:
                                                      Constants.primaryColor,
                                                  backgroundColor:
                                                      Constants.primaryColor),
                                              onPressed: () async {
                                                await CartDataProvider.instance
                                                    .delete(item.id!.toInt());
                                                if (!context.mounted) {
                                                  return;
                                                }
                                                Navigator.pop(context);
                                                _reload();
                                              },
                                              child: const Text(
                                                'Yes',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: const SizedBox(
                                  height: 28,
                                  width: 28,
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 220,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.68,
                    mainAxisSpacing: 12),
              );
            }
            return Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(
                  color: Constants.primaryColor,
                ),
              ),
            );
          }),
    );
  }
}
