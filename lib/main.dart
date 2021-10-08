// ignore_for_file: slash_for_doc_comments, prefer_const_constructors

import 'package:flutter/material.dart';
import 'food_menu.dart';
import 'money_box.dart';
import 'exchange_rate.dart';
import 'package:http/http.dart' as http;

main() {
  var app = const MyApp();
  runApp(app);
}

/**
 * Created my own StateLess Widget (First Widget)
 * StateLess Widget do not deal with State
 * Things inside StateLess Widget (except Stateful Widget) 
 * CAN'T be changed during Run Time
 */
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "My App",

        /**
         * Select Output from these 3
         */
        // home: MyHomePage(),
        // home: FoodMenuPage(),
        // home: BillApp(),
        home: CurrencyExchange(),
        theme: ThemeData(primarySwatch: Colors.purple));
  }
}

/**
 * Create my own StateFul Widget
 * StateFull Widget deal with State
 * Compunents inside StateFul Widget CAN be changed during Run Time
 * 
 * P.S : Kinda messy, contains multiple things
 */
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int number = 0; // Declaring State
  @override
  Widget build(BuildContext context) {
    /// Add Widgets to List
    List<Widget> data = [];
    data.add(Text("Press button to increase number"));
    data.add(Text(number.toString(), style: TextStyle(fontSize: 60)));
    data.add(Text("Flutter"));

    /// Control App Layout with Scaffold Widget (Template)
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello Demo Flutter"),
      ),

      /*
      ListView.builder can be used, when dealt with LARGE quantity 
      */
      // body: ListView.builder(
      //     itemCount: 30,
      //     itemBuilder: (BuildContext context, int index) {
      //       return ListTile(
      //         title: Text("menu No.${index + 1}"),
      //       );
      //     }),

      /*
      There can be only 1 Widget inside Center (only 1 inside child)
      */
      body: Center(
        /*
        Use List to holds multiple Widgets inside (Uncheck the above & below)
        */
        // child: ListView(children: getData(10)),

        /*
        Column Widget can hold MULTIPLE Widgets, in either horizontal or vertical
        */
        child:
            Column(mainAxisAlignment: MainAxisAlignment.center, children: data),

        /*
        Print Image from Internet
        */
        // child: Image(
        //   image: NetworkImage(
        //       "https://cdn.pixabay.com/photo/2020/07/21/16/24/landscape-5426755__340.jpg"),
        // ),

        /*
        Print simple easy Text
        */
        // child: Text(
        //   "First time with Flutter",
        //   style: TextStyle(fontSize: 30, color: Colors.green),
        // ),
      ),

      /*
      Create Float Action Button
      */
      floatingActionButton: FloatingActionButton(
        /*
        When Pressed calls the given function
        */
        onPressed: addNumber,
        /*
        Decorate Button Widget with given Icons.something
        */
        child: Icon(Icons.add),
      ),
    );
  }

/**
 * When Called, this function will look for variable (state)
 * that need to be changed
 */
  void addNumber() {
    setState(() {
      number++;
    });
  }

/**
 * Return List<Widget> equals to a given value in parameter
 */
  List<Widget> getData(int count) {
    List<Widget> data = [];
    for (int i = 0; i < count; i++) {
      var menu = ListTile(
        title: Text(
          "menu No.${i + 1}",
          style: TextStyle(fontSize: 25),
        ),
        subtitle: Text("sub-menu ${i + 1}"),
      );
      data.add(menu);
    }
    return data;
  }
}

/*
Create Food Menu Page (StateFull Widget)
*/
class FoodMenuPage extends StatefulWidget {
  const FoodMenuPage({Key? key}) : super(key: key);

  @override
  _FoodMenuPageState createState() => _FoodMenuPageState();
}

class _FoodMenuPageState extends State<FoodMenuPage> {
  /// Create A List of menu with FoodMenu class
  List<FoodMenu> menu = [
    FoodMenu("Egg benedict", "15.00", "assets/images/egg_benedict.jpg"),
    FoodMenu("Burger", "16.00", "assets/images/burger.jpg"),
    FoodMenu("Pasta", "14.00", "assets/images/pasta.jpg"),
    FoodMenu("Chowder", "9.00", "assets/images/chowder.jpg")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Your Menu"),
      ),
      body: ListView.builder(
          itemCount: menu.length,
          itemBuilder: (BuildContext context, int index) {
            FoodMenu food = menu[index];
            return ListTile(
              leading: Image.asset(food.img),
              title: Text(
                food.name,
                style: TextStyle(fontSize: 25),
              ),
              subtitle: Text("Price \$" + food.price),

              /*
              When clicked on menu in list, print
              */
              onTap: () {
                print("You pick menu: " + food.name);
              },
            );
          }),
    );
  }
}

/*
Create a widget for Bill App (Bank Account) (Stateful Widget)
*/
class BillApp extends StatefulWidget {
  const BillApp({Key? key}) : super(key: key);

  @override
  _BillAppState createState() => _BillAppState();
}

class _BillAppState extends State<BillApp> {
  /*
  The initState() will be called only once per build,
  when the widget builded sucessfully       (before build())

  initState() is equavalent with constructor of Object
  */
  @override
  void initState() {
    super.initState();
    print("Called initState()");
  }

  /*
  This build() will be called every time when there were changed in widget
  The build() will be called after initState
  */
  @override
  Widget build(BuildContext context) {
    print("Called build() to update widget and state");
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "My Bank Account",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        /*
        Cover Column widget in Padding widget (create empty space on Left&Right)
        */
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              MoneyBox("Balance", 2000000, Colors.lightBlue, 120),
              SizedBox(
                height: 5,
              ),
              MoneyBox("Income", 20000, Colors.green, 100),
              SizedBox(
                height: 5,
              ),
              MoneyBox("Expense", 15000.888, Colors.red, 100),
              SizedBox(
                height: 5,
              ),
              MoneyBox("Credit Debt", 55000, Colors.orange, 100),
            ],
          ),
        ));
  }
}

/*
Create Currency Exchange (StateFull Widget)
*/
class CurrencyExchange extends StatefulWidget {
  const CurrencyExchange({Key? key}) : super(key: key);

  @override
  _CurrencyExchangeState createState() => _CurrencyExchangeState();
}

class _CurrencyExchangeState extends State<CurrencyExchange> {
  late ExchangeRate _dataFromAPI;

  @override
  void initState() {
    super.initState();
    getExchangeRate();
  }

  /*
  Need to use Future<> when dealing with API,
  or when need to get data from outer source
  */
  Future<void> getExchangeRate() async {
    /// Passing URL
    var url = Uri.parse('https://api.exchangerate-api.com/v4/latest/THB');

    /*
    Get data from the above url by http method
    Process wait unil recieved data from url

    The RETURNED data will be in Json Object
    */
    var response = await http.get(url);

    /*
    json => dart object
    */
    _dataFromAPI = exchangeRateFromJson(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Currency Exchange Rate",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
