import 'package:flutter/material.dart';
import 'package:experimenting/model/data.dart';

const smallImagesAspectRatio = 7 / 9;

const TextStyle _nameTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 32,
);

const TextStyle _descriptionTextStyle = TextStyle(
  color: Colors.white,
  shadows: [
    Shadow(
      blurRadius: 7,
      color: Colors.black,
      offset: Offset(1, 2),
    ),
  ],
);

class GalleryPage extends StatefulWidget {
  final String name;
  final String imagePath;

  const GalleryPage({
    Key key,
    @required this.name,
    @required this.imagePath,
  }) : super(key: key);

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage>
    with TickerProviderStateMixin {
  Animation _descriptionAnimation;
  Animation _smallImagesAnimation;
  AnimationController _descriptionAnimationController;
  AnimationController _smallImagesAnimationController;

  List<String> smallImages;

  @override
  void initState() {
    super.initState();
    _descriptionAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 600,
      ),
    );
    _smallImagesAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 900,
      ),
    );
    _descriptionAnimation = _descriptionAnimationController
        .drive(CurveTween(curve: Curves.easeOut))
        .drive(
          Tween<Offset>(
            begin: Offset(-0.2, 0),
            end: Offset(0, 0),
          ),
        );
    _smallImagesAnimation = _smallImagesAnimationController
        .drive(CurveTween(curve: Curves.decelerate))
        .drive(
          Tween<Offset>(
            begin: Offset(1, 0),
            end: Offset(0, 0),
          ),
        );
    _descriptionAnimationController.forward();
    _smallImagesAnimationController.forward();
    initializeSmallImages();
  }

  void initializeSmallImages() {
    smallImages = List();
    var name = widget.name.toLowerCase();
    for (var i = 1; i <= 7; i++) {
      smallImages.add("assets/$name$i.jpg");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Hero(
              tag: widget.imagePath,
              child: Image.asset(
                widget.imagePath,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: 8,
              top: 32,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 32,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Positioned(
              left: 32,
              top: 128,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  LimitedBox(
                    maxWidth: 160,
                    child: Hero(
                      tag: widget.name,
                      child: Material(
                        type: MaterialType.transparency,
                        child: Text(
                          widget.name,
                          style: _nameTextStyle,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SlideTransition(
                    position: _descriptionAnimation,
                    child: LimitedBox(
                      maxWidth: 220,
                      child: Text(
                        Strings.descriptions[widget.name],
                        style: _descriptionTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 16,
              height: 160,
              width: MediaQuery.of(context).size.width,
              child: SlideTransition(
                position: _smallImagesAnimation,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 7,
                  itemBuilder: (context, position) {
                    return imageListTile(position);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageListTile(int position) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: AspectRatio(
        aspectRatio: smallImagesAspectRatio,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Image.asset(
            smallImages[position],
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _descriptionAnimationController.dispose();
    super.dispose();
  }
}
