import 'package:e_commerce/api/apiRequest.dart';
import 'package:e_commerce/api/lists.dart';
import 'package:e_commerce/screens/constant.dart';
import 'package:e_commerce/screens/details/details.dart';
import 'package:flutter/material.dart';

import '../../network/cartDatabase.dart';
import '../../network/dataBaseModel.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int indexCategory = -1;
  List indexList = [0, 1, 2, 3];
  List categoriesId = [4208, 4209, 4210, 3136];
  late String category = '';
  int initial = 4208;
  late Future<Lists> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = Api().ApiData(initial);
  }

  void _selectCategory(int index) {
    setState(() {
      initial = categoriesId[index];
      indexCategory = indexList[index];
      category = [
        "jeans",
        "shoes, Boots & Sneakers",
        "jewelery",
        "shirts",
      ][index];
      _productsFuture = Api().ApiData(initial);
    });
  }

  @override
  Widget build(BuildContext context) {
    List categories = [
      "jeans",
      "shoes, Boots & Sneakers",
      "jewelery",
      "shirts",
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: Icon(
            Icons.menu_rounded,
            color: Constants.primaryColor,
            size: 20,
          ),
          title: Column(
            children: [
              Row(
                children: [
                  const Text(
                    "Find ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20.0),
                  ),
                  Text(
                    "Your ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Constants.primaryColor,
                        fontSize: 20.0),
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Text(" Desire Product",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Constants.primaryColor,
                          fontSize: 20.0)),
                ],
              )
            ],
          ),
          actions: <Widget>[
            IconButton(
              color: Colors.white,
              icon: Icon(
                Icons.notifications_active_outlined,
                color: Constants.primaryColor,
              ),
              onPressed: () {},
            ),
          ]),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.only(top: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              height: 40,
              width: 300,
              decoration: BoxDecoration(
                color: Constants.thirdColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Constants.primaryColor,
                    size: 25,
                  ),
                  const Text(
                    "search item...",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                const Text(
                  'Categories',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(2),
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () => _selectCategory(index),
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Constants.thirdColor,
                          border: Border.all(
                              color: indexCategory == indexList[index]
                                  ? Constants.primaryColor
                                  : Colors.grey.shade300,
                              width: 2),
                        ),
                        child: Center(child: Text(categories[index])),
                      ),
                    ),
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      width: 10,
                    ),
                    itemCount: categories.length,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Products',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                FutureBuilder<Lists>(
                    future: _productsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SizedBox(
                            height: 400,
                            child: GridView.builder(
                              itemCount: snapshot.data?.products.length,
                              itemBuilder: (context, index) {
                                final product =
                                    snapshot.data!.products[index];
                                return GestureDetector(
                                  onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                    builder: (context) => DetailsScreen(
                                        product.id,
                                        product.name,
                                        product.imageUrl,
                                        product.brandName,
                                        product.colour,
                                        product.colourWayId,
                                        product.price.current.value),
                                  )),
                                  child: Hero(
                                    tag: 'photo_${product.id}',
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Constants.thirdColor,
                                        borderRadius:
                                            BorderRadius.circular(15),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.17,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      "https://${product.imageUrl}"),
                                                  fit: BoxFit.contain),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            product.name,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                            maxLines: 1,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    product.brandName,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.grey),
                                                  ),
                                                  Text(
                                                    product
                                                        .price.current.text,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                height: 35,
                                                width: 35,
                                                decoration: BoxDecoration(
                                                  color:
                                                      Constants.primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5),
                                                ),
                                                child: Center(
                                                  child: IconButton(
                                                    icon: const Icon(
                                                      Icons.add,
                                                      size: 15,
                                                      color: Colors.white,
                                                    ),
                                                    onPressed: () async {
                                                      await CartDataProvider
                                                          .instance
                                                          .insert(
                                                              DataBaseModel(
                                                        id: product.id,
                                                        name: product.name,
                                                        imageUrl:
                                                            product.imageUrl,
                                                        colour:
                                                            product.colour,
                                                        colourWayId: product
                                                            .colourWayId,
                                                        brandName: product
                                                            .brandName,
                                                        price: product.price
                                                            .current.value,
                                                      ));
                                                    },
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 200,
                                      crossAxisSpacing: 20,
                                      childAspectRatio: 3 / 4,
                                      mainAxisSpacing: 20),
                            ));
                      }
                      if (snapshot.hasError) {
                        return Text(snapshot.error!.toString());
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          color: Constants.primaryColor,
                        ),
                      );
                    }),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
