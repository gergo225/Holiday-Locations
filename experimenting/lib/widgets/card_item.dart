import 'package:flutter/material.dart';

const cardAspectRatio = 13 / 21;

const TextStyle _nameTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 32,
  fontWeight: FontWeight.bold,
);

typedef OnFavoritedCallback(CardItem cardItem);

class CardItem extends StatelessWidget {
  final String name;
  final String imagePath;
  final bool favorited;
  final OnFavoritedCallback onFavorited;

  const CardItem({
    Key key,
    @required this.name,
    @required this.imagePath,
    this.favorited,
    this.onFavorited,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4,),
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32.0),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              Hero(
                tag: imagePath,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 24,
                child: Hero(
                  tag: name,
                  child: Material(
                    type: MaterialType.transparency,
                    child: Text(
                      name,
                      style: _nameTextStyle,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  iconSize: 32.0,
                  icon: Icon(
                    favorited ? Icons.star : Icons.star_border,
                    color: Colors.white,
                  ),
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () {
                    onFavorited(context.widget);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
