import 'package:e_commerce/api/details.dart';
import 'package:flutter/material.dart';

import '../../api/apiRequest.dart';
import '../../network/cartDatabase.dart';
import '../../network/dataBaseModel.dart';
import '../../network/favDatabase.dart';
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
      SnackBar(
        content: const Text('Added to cart'),
        backgroundColor: Constants.secondryColor,
      ),
    );
  }

  Future<void> _addToFavourite() async {
    await FavDataProvider.instance.insert(DataBaseModel(
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
      SnackBar(
        content: const Text('Added to favourites'),
        backgroundColor: Constants.primaryColor,
      ),
    );
  }

  String _plainDescription(String raw) {
    return raw
        .replaceAll(RegExp(r'<[^>]*>'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Constants.secondryColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Details',
          style: TextStyle(
            color: Constants.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: Constants.primaryColor,
            ),
            onPressed: _addToFavourite,
          ),
        ],
      ),
      body: FutureBuilder<Details>(
        future: _detailsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  snapshot.error.toString(),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(color: Constants.primaryColor),
            );
          }

          final details = snapshot.data!;
          final inStock = details.isInStock;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  height: 320,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Constants.secondryColor,
                      width: 2,
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    "https://${widget.imageUrl}",
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Icon(
                      Icons.image_not_supported_outlined,
                      size: 64,
                      color: Constants.secondryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                  decoration: BoxDecoration(
                    color: Constants.thirdColor,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Constants.fourthColor,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Text(
                            '\$${widget.price}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Constants.secondryColor,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: inStock
                                  ? Constants.primaryColor
                                  : Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              inStock ? 'In Stock' : 'Out of Stock',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        height: 28,
                        thickness: 1,
                        color: Constants.secondryColor.withValues(alpha: 0.4),
                      ),
                      const Text(
                        'Product Details',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _detailRow('Brand', widget.brandName),
                      _detailRow('Colour', widget.colour),
                      _detailRow('Gender', details.gender),
                      const SizedBox(height: 8),
                      Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Constants.fourthColor,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _plainDescription(details.description),
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          height: 1.4,
                          color: Colors.black87,
                        ),
                      ),
                      Divider(
                        height: 32,
                        thickness: 1,
                        color: Constants.secondryColor.withValues(alpha: 0.4),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.rate_review_rounded,
                            color: Constants.secondryColor,
                            size: 22,
                          ),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Text(
                              'Product Questions & Reviews',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.black54,
                            size: 16,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                onPressed: _addToFavourite,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Constants.primaryColor,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  'Favourite',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                onPressed: _addToCart,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Constants.secondryColor,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  'Add To Cart',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
