import 'package:flutter/material.dart';
import 'package:transitions_page/pages/page_2_pag.dart';

class Page1Page extends StatelessWidget {
  const Page1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade400,
      body: Center(
        child: Text('Pagina 10'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, _crearRuta());
        },
        child: Icon(Icons.play_arrow),
      ),
    );
  }
  
  Route _crearRuta() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Page2Page(),
      transitionDuration: const Duration(seconds: 2),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.easeInOut);

        return RotationTransition(
          turns: Tween<double>(begin: 0.99, end: 1).animate(curvedAnimation),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0, end: 1).animate(curvedAnimation),
            child: child,
          )
        );

        return FadeTransition(
          opacity: Tween<double>(begin: 0, end: 1).animate(curvedAnimation),
          child: child,
        );

        return RotationTransition(
          turns: Tween<double>(begin: 0, end: 1).animate(curvedAnimation),
          child: child,
        );

        return ScaleTransition(
          scale: Tween<double>(begin: 0, end: 1).animate(curvedAnimation),
          child: child,
        );

        return SlideTransition(
          position: Tween<Offset>(begin: Offset(0, .3), end: Offset.zero).animate(curvedAnimation),
          child: child

        );
      },
    );
  }
}
