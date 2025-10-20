import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:color_palette_plus/color_palette_plus.dart';
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

  IconData have_Heart(int index){
    IconData icon;
    if (favorites.contains(index)) {
      return(icon = Icons.favorite);
    } else {
      return(icon = Icons.favorite_border);
    }
  }

  IconData have_Delete(int index){
    IconData icon;
    if (favorites.contains(index)) {
      return(icon = Icons.delete);
    } else {
      return(icon = Icons.delete);
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
  Map<int, Color> color_map = {};
  Color baseColor = Color(0xFF2196F3); // Blue
  List list_example = [];
  // late double color_double;
  // late Color color_type;
  // late String color_string;
  // List<int> color_list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  // List<Color> inner_map =

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 10; i++) {
      color_map[i] = Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withAlpha(255);
      // color_double = (math.Random().nextDouble() * 0xFFFFFF);
      // color_number = Color((color_double).toInt()).withAlpha(255);
      // color_string = '#${color_number.toARGB32().toRadixString(16)}';
    }
    MaterialColor swatch = ColorPalette.generateSwatch(baseColor);
  }



  Widget methodReturnWidget(final int index) {
    // print(index);
    return (color_map[index] == null)? Icon(Icons.abc_sharp) : ColoredBox(color: color_map[index]!, child: SizedBox.fromSize(size: Size.fromRadius(10)),);
  }

  Widget methodReturnText(final int index) {
    // print(index);
    return (color_map[index] == null)? Text('null') : Text('#${color_map[1]!.toARGB32().toRadixString(16)}',);
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    IconData icon = Icons.favorite_border;

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
                                      iconColor: color_map[index],
                                      title: methodReturnText(index),
                                      trailing: ElevatedButton.icon(
                                        onPressed: () {
                                          appState.delete(index);
                                        },
                                        icon: Icon(appState.have_Delete(index)),
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
        itemCount: color_map.length,
        itemBuilder: (final BuildContext, final int index) {
          return ListTile(
            leading: methodReturnWidget(index),
            iconColor: color_map[index],
            title: methodReturnText(index),
            trailing: ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite(index);
              },
              icon: Icon(appState.have_Heart(index)),
              label: Text('like')
            ),
          );
        }
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
