import 'package:experimenting/model/state_manager.dart';
import 'package:flutter/material.dart';
import 'package:experimenting/widgets/card_list.dart';
import 'package:experimenting/model/custom_icons.dart';
import 'package:experimenting/model/data.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  Widget _buildTitle() {
    return Positioned(
      top: 24,
      left: 16,
      right: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Asia",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
          IconButton(
            icon: Icon(
              CustomIcons.menu,
              color: Colors.black,
              size: 24,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildCountriesList(double height, StateManager stateManager) {
    var itemColor = Color.fromARGB(255, 18, 59, 247);

    return Positioned(
      top: height * .12,
      left: 16,
      right: 0,
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: Strings.countries.length,
        itemBuilder: ((context, position) {
          var currentCountry = Strings.countries[position];
          var isSelected = currentCountry == stateManager.selectedCountry;
          return FlatButton(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              currentCountry,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            color: isSelected ? itemColor : Colors.grey.shade300,
            onPressed: () {
              stateManager.updateSelectedCountry(currentCountry);
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          );
        }),
        separatorBuilder: ((context, position) {
          return SizedBox(
            width: 16,
          );
        }),
      ),
    );
  }

  Widget _buildBottomNavbar(StateManager stateManager) {
    var iconsList = [
      CustomIcons.globe,
      CustomIcons.target_circle,
      CustomIcons.briefcase,
      CustomIcons.user,
    ];

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      height: 64,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black,
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: iconsList.map((icon) {
            return ClipOval(
              child: Material(
                type: MaterialType.transparency,
                child: IconButton(
                  icon: Icon(
                    icon,
                    color: (icon == stateManager.selectedMenuIcon)
                        ? Colors.black
                        : Colors.grey,
                  ),
                  onPressed: () {
                    stateManager.updateMenuIcon(icon);
                  },
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final stateManager = Provider.of<StateManager>(context);
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Eina03',
      ),
      home: Scaffold(
        body: LayoutBuilder(
          builder: ((context, constraints) {
            var height = constraints.maxHeight;
            var width = constraints.maxWidth;

            return Stack(
              fit: StackFit.expand,
              children: <Widget>[
                _buildTitle(),
                _buildCountriesList(height, stateManager),
                Positioned(
                  top: height * .2,
                  bottom: height * .13,
                  width: width,
                  child: CardList(),
                ),
                _buildBottomNavbar(stateManager),
              ],
            );
          }),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
