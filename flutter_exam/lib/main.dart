import 'package:flutter/material.dart';
import 'food_menu.dart';
import 'money_box.dart';
import 'package:http/http.dart' as http;
import 'ExchangeRate.dart';
//ignore_for_file: prefer_const_constructors,
//ignore_for_file: prefer_const_literals_to_create_immutables

void main() async {
  print(await loginUser());

  runApp(MyApp());
}

Future<String> loginUser() async {
  var user = await getUserFromDatabase();
  return "name " + user;
}

Future<String> getUserFromDatabase() {
  return Future.delayed(Duration(seconds: 1), () => "username");
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My App",
      home: MyHomePage(),
      theme: ThemeData(primarySwatch: Colors.red),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ExchangeRate _dataFromAPI;

  List<FoodMenu> menu = [
    FoodMenu("Pig", "500", "assets/images/menu1.jpg"),
    FoodMenu("Beef", "900", "assets/images/menu2.jpg")
  ];
  int number = 0; // variable
  @override
  void initState() {
    super.initState();
    getExchangeRate();
  }

  Future<ExchangeRate> getExchangeRate() async {
    var url = Uri.parse('https://api.exchangerate-api.com/v4/latest/THB');
    var response = await http.get(url);
    print(response.body);
    _dataFromAPI = exchangeRateFromJson(response.body);
    return _dataFromAPI;
  }

  @override
  Widget build(BuildContext context) {
    // data.add(Text(
    //   number.toString(),
    //   style: TextStyle(fontSize: 60, color: Colors.blue),
    // ));
    print("เรียกใช้งาน build ");

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "อันตราการแลกเปลี่ยน",
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder(
        future: getExchangeRate(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var result = snapshot.data;
            double amount = 100;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  MoneyBox(
                      title: "สกุลเงิน ${result.base}",
                      amount: amount,
                      color: Colors.red,
                      size: 120),
                  SizedBox(
                    height: 5,
                  ),
                  MoneyBox(
                      title: "EUR",
                      amount: amount * result.rates["EUR"],
                      color: Colors.green,
                      size: 100),
                  SizedBox(
                    height: 5,
                  ),
                  MoneyBox(
                      title: "USD",
                      amount: amount * result.rates["USD"],
                      color: Colors.orange,
                      size: 100),
                  SizedBox(
                    height: 5,
                  ),
                  MoneyBox(
                      title: "GBP",
                      amount: amount * result.rates["GBP"],
                      color: Colors.blueAccent,
                      size: 100),
                  SizedBox(
                    height: 5,
                  ),
                  MoneyBox(
                      title: "JPY",
                      amount: amount * result.rates["JPY"],
                      color: Colors.orangeAccent,
                      size: 100),
                ],
              ),
            );
          }

          return LinearProgressIndicator();
        },
      ),

      // Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Column(
      //     children: [
      //       MoneyBox(
      //           title: "รายรับ",
      //           amount: 150,
      //           color: Colors.amberAccent,
      //           size: 120),
      //       SizedBox(
      //         height: 20,
      //       ),
      //       MoneyBox(
      //           title: "รายรับ",
      //           amount: 2000,
      //           color: Colors.greenAccent,
      //           size: 100),
      //       SizedBox(
      //         height: 20,
      //       ),
      //       MoneyBox(
      //           title: "รายจ่าย",
      //           amount: 2000,
      //           color: Colors.yellowAccent,
      //           size: 100),
      //       SizedBox(
      //         height: 20,
      //       ),
      //       MoneyBox(
      //           title: "ค้างชำระ",
      //           amount: 2000,
      //           color: Colors.orangeAccent,
      //           size: 100),
      //     ],
      //   ),
      // )

      // ListView.builder(
      //     itemCount: menu.length,
      //     itemBuilder: (BuildContext context, int index) {
      //       FoodMenu food = menu[index];
      //       return ListTile(
      //         leading: Image.asset(food.imgFood),
      //         title: Text(food.name),
      //         subtitle: Text("ราคา " + food.price),
      //       );
      //     }),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: addNumber,
      //   child: Icon(Icons.add),
      // ),
    );
  }

  List<Widget> getData(int count) {
    List<Widget> data = [];

    for (var i = 0; i < count; i++) {
      var menu = ListTile(
        title: Text("menu is  ${i + 1}"),
        subtitle: Text("sub title "),
      );
      data.add(menu);
    }

    return data;
  }

  void addNumber() {
    setState(() {
      number++;
    });
  }
}
