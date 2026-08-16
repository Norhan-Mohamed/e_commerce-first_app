import 'package:e_commerce/api/details.dart';
import 'package:flutter/material.dart';

import '../../api/apiRequest.dart';
import '../../network/cartDatabase.dart';
import '../../network/dataBaseModel.dart';
import '../constant.dart';

class DetailsScreen extends StatefulWidget {
  final int id;
  final String name;
  final String imageUrl;
  final String colour;
  final int colourWayId;
  final String brandName;
  final num price;

  const DetailsScreen(
    this.id,
    this.name,
    this.imageUrl,
    this.brandName,
    this.colour,
    this.colourWayId,
    this.price, {
    super.key,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late Future<Details> _detailsFuture;

  @override
  void initState() {
    super.initState();
    _detailsFuture = ApiInfo().ApiDetails(widget.id);
  }

  Future<void> _addToCart() async {
    await CartDataProvider.instance.insert(DataBaseModel(
      id: widget.id,
      name: widget.name,
      imageUrl: widget.imageUrl,
      colour: widget.colour,
      colourWayId: widget.colourWayId,
      brandName: widget.brandName,
      price: widget.price.toDouble(),
    ));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Added to cart')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xff0c9173),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Hero(
        tag: 'photo_${widget.id}',
        child: SingleChildScrollView(
          child: FutureBuilder<Details>(
              future: _detailsFuture,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 350,
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: Constants.secondryColor,
                          width: 3,
                        )),
                        child: Image.network(
                          "https://${widget.imageUrl}",
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                        height: 800,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Constants.thirdColor,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              widget.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Constants.fourthColor,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Divider(
                              height: 25,
                              thickness: 2,
                              color: Constants.secondryColor,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Price",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "${widget.price}\$",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              height: 25,
                              thickness: 1,
                              color: Constants.secondryColor,
                            ),
                            const Text("Product Details",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 20)),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Brand Name: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  widget.brandName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Colour :${widget.colour}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const Text(
                                  "gender: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  snapshot.data!.gender,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Is in Stock: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  snapshot.data!.isInStock.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Description",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Constants.fourthColor,
                                  ),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  snapshot.data!.description,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Divider(
                              height: 20,
                              thickness: 1,
                              color: Constants.secondryColor,
                            ),
                            const Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.rate_review_rounded,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                Text(
                                  "24 Product Question & Review",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 20),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.black,
                                  size: 20,
                                )
                              ],
                            ),
                            Divider(
                              height: 15,
                              thickness: 1,
                              color: Constants.secondryColor,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 50,
                                  width: 150,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Constants.primaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Text(
                                    "Buy Now",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: _addToCart,
                                  child: Container(
                                    height: 50,
                                    width: 150,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Constants.secondryColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Text(
                                      "Add To Cart",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return const Center(
                    child: SizedBox(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(),
                ));
              }),
        ),
      ),
    );
  }
}
