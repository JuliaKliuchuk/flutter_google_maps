import 'package:flutter/material.dart';
import 'package:flutter_google_maps/pages/home/navBar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GridView.builder(
        padding: const EdgeInsets.all(20.0),
        itemCount: 10,
        itemBuilder: (context, i) => Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // img
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Container(
                  height: 300.0,
                  color: Colors.teal[100],
                ),
              ),
              // title
              const Padding(
                padding: EdgeInsets.only(left: 10.0, top: 5.0),
                child: Text(
                  'Sometext',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.85,
        ),
      ),
      drawer: const NavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
