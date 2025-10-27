import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (context) => MyAppState(),
        child: const MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const MyHomePage(title: 'Random Color'),
    );
  }
}

class MyAppState extends ChangeNotifier {
  List favorites = <int>[];

  void toggleFavorite(int index) {
    // print(index);
    if (favorites.contains(index)) {
      favorites.remove(index);
    } else {
      favorites.add(index);
    }
    notifyListeners();
  }

  void delete(int index) {
    favorites.remove(index);
    notifyListeners();
  }

  IconData haveHeart(int index){
    if (favorites.contains(index)) {
      return(Icons.favorite);
    } else {
      return(Icons.favorite_border);
    }
  }


}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // late (int, Color) color_record;
  Map<int, Color> colorMap = {};
  Color baseColor = Color(0xFF2196F3); // Blue
  List listExample = [];
  // late double color_double;
  // late Color color_type;
  // late String color_string;
  // List<int> color_list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  // List<Color> inner_map =

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 10; i++) {
      colorMap[i] = Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withAlpha(255);
      // color_double = (math.Random().nextDouble() * 0xFFFFFF);
      // color_number = Color((color_double).toInt()).withAlpha(255);
      // color_string = '#${color_number.toARGB32().toRadixString(16)}';
    }
  }



  Widget methodReturnWidget(final int index) {
    // print(index);
    return (colorMap[index] == null)? Icon(Icons.abc_sharp) : ColoredBox(color: colorMap[index]!, child: SizedBox.fromSize(size: Size.fromRadius(10)),);
  }

  Widget methodReturnText(final int index) {
    // print(index);
    return (colorMap[index] == null)? Text('null') : Text('#${colorMap[1]!.toARGB32().toRadixString(16)}',);
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Colors'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            tooltip: 'Show favorite',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute<void>(

                      builder: (BuildContext context) {
                        var appState = context.watch<MyAppState>();
                        return Scaffold(
                          appBar: AppBar(title: const Text('Favorite')),
                          body: Column(children: [
                            for(var index in appState.favorites)
                              ListTile(
                                      leading: methodReturnWidget(index),
                                      iconColor: colorMap[index],
                                      title: methodReturnText(index),
                                      trailing: ElevatedButton.icon(
                                        onPressed: () {
                                          appState.delete(index);
                                        },
                                        icon: Icon(Icons.delete),
                                        label: Text('delete'),
                                      )
                              )
                          ]
                        )
                        );
                      },
                  )
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: colorMap.length,
        itemBuilder: (final BuildContext context, final int index) {
          return ListTile(
            leading: methodReturnWidget(index),
            iconColor: colorMap[index],
            title: methodReturnText(index),
            trailing: ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite(index);
              },
              icon: Icon(appState.haveHeart(index)),
              label: Text('like')
            ),
          );
        }
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
