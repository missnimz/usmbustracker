import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
              color: Color(0xFF63398F),
              //gradient: LinearGradient(
                //colors: [
                  //Colors.purpleAccent, Colors.purple, Colors.purpleAccent
                //],

                //begin: Alignment.bottomRight,
                //end: Alignment.topLeft,
              )
          ),
        const Column(
          children: [
            SizedBox(height: 95,),
            // Image(image: ExactAssetImage("assets/images/usm_ens_logo.png",),
            // ),
            Center( // This centers the image horizontally within the column
              child: Image(
                image: ExactAssetImage("assets/images/logobus.png"),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Align(
            alignment: Alignment.center,
            child: child,
            //),
          ),
        ),
      ],
    );
  }

  /*@override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          height: size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              width: size.width,
              height: size.height * 0.8,//0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue.withOpacity(0.3),
              ),
              child: child,
            ),
          ),
        ),
      ],
    );
  }*/
}
