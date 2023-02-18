import 'package:ecommerce_store/screens/web_admin/add_Product_Screen.dart';
import 'package:ecommerce_store/screens/web_admin/dashboard_Screen.dart';
import 'package:ecommerce_store/screens/web_admin/delete_Product_Screen.dart';
import 'package:ecommerce_store/screens/web_admin/update_Product_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class WebMainScreen extends StatefulWidget {
  static const String routeName = 'webmain';

  @override
  State<WebMainScreen> createState() => _WebMainScreenState();
}

class _WebMainScreenState extends State<WebMainScreen> {
  Widget selectedScreen = const DashBoardScreen();

  chooseScreens(item) {
    switch (item.route) {
      case DashBoardScreen.routeName:
        setState(() {
          selectedScreen = const DashBoardScreen();
        });
        break;

      case AddProductScreen.routeName:
        setState(() {
          selectedScreen = AddProductScreen();
        });
        break;

      case UpdateProductScreen.routeName:
        setState(() {
          selectedScreen = const UpdateProductScreen();
        });
        break;

      case DeleteProductScreen.routeName:
        setState(() {
          selectedScreen = const DeleteProductScreen();
        });
        break;

      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
        appBar: AppBar(
          title: const Text('Admin'),
          backgroundColor: Colors.black,
        ),
        sideBar: SideBar(
          onSelected: (item) {
            chooseScreens(item);
          },
          items: const [
            AdminMenuItem(
                title: 'Dashbaord',
                icon: Icons.dashboard,
                route: DashBoardScreen.routeName),
            AdminMenuItem(
                title: 'Add Products',
                icon: Icons.add,
                route: AddProductScreen.routeName),
            AdminMenuItem(
                title: 'Update Products',
                icon: Icons.update,
                route: UpdateProductScreen.routeName),
            AdminMenuItem(
                title: 'Delete Products',
                icon: Icons.delete,
                route: DeleteProductScreen.routeName),
            AdminMenuItem(
              title: 'Cart Items',
              icon: Icons.shop,
            ),
          ],
          selectedRoute: WebMainScreen.routeName,
        ),
        body: selectedScreen);
  }
}
