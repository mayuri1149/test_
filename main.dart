import 'package:flutter/material.dart';
import 'cart.dart';
import 'dish_object.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(title: 'Place order'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Dish> _dishes = [];

  List<Dish> _cartList = [];

  @override
  void initState() {
    super.initState();
    _populateDishes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 8.0),
            child: GestureDetector(
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Icon(
                    Icons.shopping_cart,
                    size: 36.0,
                  ),
                  if (_cartList.length > 0)
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: CircleAvatar(
                        radius: 8.0,
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        child: Text(
                          _cartList.length.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              onTap: () {
                if (_cartList.isNotEmpty)
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Cart(_cartList),
                    ),
                  );
              },
            ),
          )
        ],
      ),
      body: _buildGridView(),
    );
  }

  ListView _buildListView() {
    return ListView.builder(
      itemCount: _dishes.length,
      itemBuilder: (context, index) {
        var item = _dishes[index];
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 2.0,
          ),
          child: Card(
            elevation: 4.0,
            child: ListTile(
              leading: Icon(
                item.icon,
                color: item.color,
              ),
              title: Text(item.name),
              trailing: GestureDetector(
                child: (!_cartList.contains(item))
                    ? Icon(
                  Icons.add_circle,
                  color: Colors.green,
                )
                    : Icon(
                  Icons.remove_circle,
                  color: Colors.red,
                ),
                onTap: () {
                  setState(() {
                    if (!_cartList.contains(item))
                      _cartList.add(item);
                    else
                      _cartList.remove(item);
                  });
                },
              ),
            ),
          ),
        );
      },
    );
  }

  ListView _buildGridView() {
    return ListView.builder(
        padding: const EdgeInsets.all(4.0),
        // gridDelegate:
        // SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: _dishes.length,
        itemBuilder: (context, index) {
          var item = _dishes[index];
          return Card(
              elevation: 4.0,
              child: Stack(
                fit: StackFit.loose,
                alignment: Alignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        item.icon,
                        color: (_cartList.contains(item))
                            ? Colors.grey
                            : item.color,
                        size: 100.0,
                      ),
                      Text(
                        item.name,
                        textAlign: TextAlign.center,

                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 8.0,
                      bottom: 8.0,
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        child: (!_cartList.contains(item))
                            ? Icon(
                          Icons.add_circle,
                          color: Colors.green,
                        )
                            : Icon(
                          Icons.remove_circle,
                          color: Colors.red,
                        ),
                        onTap: () {
                          setState(() {

                            if (!_cartList.contains(item))
                              _cartList.add(item);
                            else
                              _cartList.remove(item);
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ));
        });
  }

  void _populateDishes() {
    var list = <Dish>[
      Dish(
        name: 'Android_Mobile',
        icon: Icons.mobile_screen_share_sharp,
        color: Colors.amber,
      ),
      Dish(
        name: 'Printer',
        icon: Icons.print,
        color: Colors.deepOrange,
      ),
      Dish(
        name: 'I-Phone',
        icon: Icons.mobile_friendly,
        color: Colors.brown,
      ),
      Dish(
        name: 'Tab',
        icon: Icons.tab,
        color: Colors.green,
      ),
      Dish(
        name: 'Laptop without OS',
        icon: Icons.laptop,
        color: Colors.purple,
      ),
      Dish(
        name: 'Mac wihout macOS',
        icon: Icons.laptop_mac,
        color: Colors.blueGrey,
      ),
    ];

    setState(() {
      _dishes = list;
    });
  }
}