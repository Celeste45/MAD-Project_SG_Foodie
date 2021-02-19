import 'package:flutter/material.dart';
import 'package:sg_foodie/interfaces/home/home.dart';
import 'package:sg_foodie/interfaces/me/me.dart';
import 'package:sg_foodie/interfaces/cart/cart.dart';
import 'package:sg_foodie/interfaces/sg_foodie/sg_foodie.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_selectedIndex].currentState.maybePop();
        // Let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.redAccent,
          unselectedItemColor: Colors.black45,
          selectedFontSize: 14.0,
          unselectedFontSize: 14.0,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_rounded,
                size: 35.0,
              ),
              label: ('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_rounded,
                size: 35.0,
              ),
              label: ('Me'),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart_rounded,
                size: 35.0,
              ),
              label: ('Cart'),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.ramen_dining,
                size: 35.0,
              ),
              label: ('SG Foodie'),
            ),
          ],
          onTap: (index) {
            setState(() => _selectedIndex = index);
          },
        ),
        body: Stack(
          children: [
            _buildOffstageNavigator(0),
            _buildOffstageNavigator(1),
            _buildOffstageNavigator(2),
            _buildOffstageNavigator(3),
          ],
        ),
      ),
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context, int index) {
    return {
      '/': (context) {
        return [
          Home(),
          Me(),
          Cart(),
          SGFoodie(),
        ].elementAt(index);
      },
    };
  }

  Widget _buildOffstageNavigator(int index) {
    var routeBuilders = _routeBuilders(context, index);

    return Offstage(
      offstage: _selectedIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => routeBuilders[routeSettings.name](context),
          );
        },
      ),
    );
  }
}
