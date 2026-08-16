import 'package:e_commerce/network/cartDatabase.dart';
import 'package:e_commerce/network/favDatabase.dart';
import 'package:e_commerce/screens/Home/home.dart';
import 'package:e_commerce/screens/cart/cart.dart';
import 'package:e_commerce/screens/constant.dart';
import 'package:e_commerce/screens/favourite/favourite.dart';
import 'package:e_commerce/screens/splashScreen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FavDataProvider.instance.open();
  await CartDataProvider.instance.open();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Map<String, dynamic>> _pages = [
    {'page': Home(), 'title': 'Home'},
    {'page': CartScreen(), 'title': 'Cart'},
    {'page': FavouriteScreen(), 'title': 'Favourite'},
  ];
  int _selectedPageIndex = 0;

  void index(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 12,
        unselectedFontSize: 12,
        backgroundColor: Colors.white,
        selectedItemColor: Constants.primaryColor,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedPageIndex,
        onTap: index,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favourite'),
        ],
      ),
    );
  }
}
