import 'package:experimenting/model/state_manager.dart';
import 'package:experimenting/pages/gallery.dart';
import 'package:flutter/material.dart';
import 'package:experimenting/widgets/card_item.dart';
import 'package:experimenting/model/data.dart';
import 'package:provider/provider.dart';

const sidePagesPadding = 32;
const pageViewAspectRatio = 13 / 21 * 1.25; // cardItemAspectRatio * 1.25

class CardList extends StatefulWidget {
  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  PageController pageController;
  var currentPage;

  @override
  void initState() {
    currentPage = 0.0;
    super.initState();
    pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.8,
    )..addListener(() {
        setState(() {
          currentPage = pageController.page;
        });
      });
  }

  Widget _buildItem(int position, StateManager stateManager) {
    var name = Strings.names[position];
    return CardItem(
      key: UniqueKey(),
      name: name,
      imagePath: Strings.images[position],
      favorited: stateManager.isFavoriteCountry(name),
      onFavorited: (_) {
        stateManager.updateFavoriteCountries(name);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final stateManager = Provider.of<StateManager>(context);
    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        itemBuilder: (context, position) {
          double opacity = 0.6;
          if ((currentPage - position).abs() < 0.5) {
            opacity = 1;
          }
          return GestureDetector(
            child: Opacity(
              opacity: opacity,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: (currentPage - position).abs() * sidePagesPadding,
                ),
                child: _buildItem(position, stateManager),
              ),
            ),
            onTap: () {
              if (opacity == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) {
                    return GalleryPage(
                      name: Strings.names[position],
                      imagePath: Strings.images[position],
                    );
                  }),
                );
              }
            },
          );
        },
        itemCount: Strings.names.length,
      ),
    );
  }
}
