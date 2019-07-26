import 'package:flutter/material.dart';
import 'Colors.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';
import 'fun.dart';

//TODO: Separate Functions in another file(s)

bool quantitySwitch = false;
bool creamValue = false;
bool chocoValue = false;

int quantity = 1;

const double basePrice = 5.0;
const double whippedCreamCost = 1.25;
const double chocolateCost = 2.5;

const String summary = "Quantity\n\n"
    "1Cup Price\n\n"
    "Total Cream Price\n\n"
    "Total Choco Price";

String summaryValues = "$quantity cups\n"
    "×\n"
    "\$$basePrice\n"
    "+\n"
    "\$$totalCreamPrice\n"
    "+\n"
    "\$$totalChocoPrice";

double totalCreamPrice = 0.0;
double totalChocoPrice = 0.0;
double totalToppingsPrice = 0.0;
double totalPrice = 5.0;

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new HomeState();
}

class HomeState extends State<Home> {

  // triggers when whipped cream CheckBox changes
  void _creamValueChanged(bool value) => setState(() {
        creamValue = value;
        Fun.updateSummary();
      });

  // triggers when chocolate CheckBox changes
  void _chocoValueChanged(bool value) => setState(() {
        chocoValue = value;
        updateSummary();
      });

  //////////////////////////////////////
  ///////////////// UI /////////////////
  //////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    Fun.updateSummary();
    return ListView(padding: EdgeInsets.all(16.0), children: <Widget>[
      Column(
        children: <Widget>[
          SwitchListTile(
            selected: true,
            activeColor: blue1,
            value: quantitySwitch,
            onChanged: Fun.fastQuantityFixed,
            title: Text('Quantity'.toUpperCase(),
                style: new TextStyle(color: grey2, fontSize: 15.0)),
          ),
          new Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(),
                  Listener(
                    child: ButtonTheme(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        height: 50,
                        minWidth: 50,
                        child: RaisedButton(
                          color: blue1,
                          textColor: white,
                          onPressed: Fun.decrement,
                          child: Text(
                            "-",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22.0),
                          ),
                        )),
                    onPointerDown: (details) {
                      _buttonPressed = true;
                      _longPressQuantity("decrement");
                    },
                    onPointerUp: (details) {
                      _buttonPressed = false;
                    },
                  ),
                  SizedBox(
                    width: 150,
                    child: Text(
                      "$quantity",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 72.0,
                          color: darkThemeOn ? lightGrey : black1),
                    ),
                  ),
                  Listener(
                    child: ButtonTheme(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      height: 50,
                      minWidth: 50,
                      child: RaisedButton(
                        color: blue1,
                        textColor: white,
                        onPressed: increment,
                        child: Text(
                          "+",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22.0),
                        ),
                      ),
                    ),
                    onPointerDown: (details) {
                      _buttonPressed = true;
                      _longPressQuantity("increment");
                    },
                    onPointerUp: (details) {
                      _buttonPressed = false;
                    },
                  ),
                  SizedBox(),
                ],
              )),
          new Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Toppings".toUpperCase(),
                  style: TextStyle(color: grey2, fontSize: 15.0),
                ),
                CheckboxListTile(
                  value: creamValue,
                  onChanged: _creamValueChanged,
                  title: Text('Whipped Cream'),
                  controlAffinity: ListTileControlAffinity.leading,
                  subtitle: Text('\$$whippedCreamCost / cup'),
                  secondary: Image.asset(
                    'assets/images/cream.png',
                    width: 48.0,
                    height: 48.0,
                  ),
                  activeColor: blue1,
                ),
                CheckboxListTile(
                  value: chocoValue,
                  onChanged: _chocoValueChanged,
                  title: Text('Chocolate'),
                  controlAffinity: ListTileControlAffinity.leading,
                  subtitle: Text('\$$chocolateCost / cup'),
                  secondary: Image.asset(
                    'assets/images/choco.png',
                    width: 48.0,
                    height: 48.0,
                  ),
                  activeColor: blue1,
                ),
              ],
            ),
          ),
          new Container(
            padding: EdgeInsets.all(16.0),
            child: new Column(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Summary".toUpperCase(),
                      style: TextStyle(color: grey2, fontSize: 15.0),
                    ),
                    SizedBox(height: 16.0),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 16.0,
                        ),
                        Expanded(
                          child: SizedBox(
                            child: Text(
                              "$summary",
                              style: TextStyle(
                                fontSize: 12.0,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            child: Text(
                              "\n:\n\n:\n\n:\n\n:\n",
                              style: TextStyle(fontSize: 12.0),
                            ),
                          ),
                        ),

                        SizedBox(
                          child: Text(
                            "$summaryValues",
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "\$$totalPrice",
                  style: TextStyle(color: green1, fontSize: 44.0),
                ),
                SizedBox(
                  height: 16.0,
                ),
                ButtonTheme(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  height: 50,
                  minWidth: 200,
                  child: RaisedButton(
                    onPressed: submitOrder,
                    color: blue1,
                    child: Text(
                      "Order".toUpperCase(),
                      style: TextStyle(color: white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      )
    ]);
  }

//  bool _buttonPressed = false;
//  bool _loopActive = false;
//  // makes quantity change faster while press and hold on (+ / -) buttons
//  void _longPressQuantity(String s) async {
//    // make sure that only one loop is active
//    if (_loopActive) return;
//
//    _loopActive = true;
//
//    await Future.delayed(Duration(milliseconds: 700));
//
//    while (_buttonPressed) {
//      setState(() {
//        if (s == "increment") {
//          increment();
//        }
//        if (s == "decrement") {
//          decrement();
//        }
//      });
//
//      // wait a bit
//      await Future.delayed(Duration(milliseconds: 100));
//    }
//
//    _loopActive = false;
//  }
//
//  // Fixing quantity if "Quantity Switch" is on
//  void fastQuantityFixed(bool value) {
//    setState(() {
//      quantitySwitch = value;
//    });
//
//    if (quantitySwitch) {
//      if (quantity <= 10) {
//        setState(() {
//          quantity = 10;
//        });
//      } else if (quantity <= 20) {
//        setState(() {
//          quantity = 20;
//        });
//      } else if (quantity <= 30) {
//        setState(() {
//          quantity = 30;
//        });
//      } else if (quantity <= 40) {
//        setState(() {
//          quantity = 40;
//        });
//      } else if (quantity <= 50) {
//        setState(() {
//          quantity = 50;
//        });
//      } else if (quantity <= 60) {
//        setState(() {
//          quantity = 60;
//        });
//      } else if (quantity <= 70) {
//        setState(() {
//          quantity = 70;
//        });
//      } else if (quantity <= 80) {
//        setState(() {
//          quantity = 80;
//        });
//      } else if (quantity <= 90) {
//        setState(() {
//          quantity = 90;
//        });
//      } else if (quantity <= 100 || quantity > 100) {
//        setState(() {
//          quantity = 100;
//        });
//      }
//      updateSummary();
//    }
//  }
//
//  // Updates summary of the order.
//  void updateSummary() {
//    setState(() {
//      if (!creamValue) {
//        totalCreamPrice = 0.0;
//      }
//      if (!chocoValue) {
//        totalChocoPrice = 0.0;
//      }
//      calculatePrice();
//      summaryValues =
//          "$quantity cups\n×\n\$$basePrice\n+\n\$$totalCreamPrice\n+\n\$$totalChocoPrice";
//    });
//  }
//
//  // Increases the quantity
//  void increment() {
//    if (quantity >= 100) {
//      SingleSnackBar.show(context, "You can't order more than 100 cups!");
//      return;
//    } else if (quantitySwitch) {
//      if (quantity == 1) {
//        setState(() {
//          quantity = 10;
//        });
//        updateSummary();
//        return;
//      }
//      setState(() {
//        quantity = quantity + 10;
//      });
//      updateSummary();
//      return;
//    }
//
//    setState(() {
//      quantity = quantity + 1;
//      updateSummary();
//    });
//  }
//
//  // Decreases the quantity
//  void decrement() {
//    if (quantity <= 1) {
//      SingleSnackBar.show(context, "You can't order less than 1 cup!");
//      setState(() {
//        quantity = 1;
//      });
//      return;
//    } else if (quantitySwitch) {
//      if (quantity <= 10) {
//        setState(() {
//          quantity = 1;
//        });
//        updateSummary();
//        return;
//      }
//      setState(() {
//        quantity = quantity - 10;
//      });
//      updateSummary();
//      return;
//    }
//
//    setState(() {
//      quantity = quantity - 1;
//      updateSummary();
//    });
//  }
//
//  // Sends the order using mail app
//  void submitOrder() async {
//    String priceMessage = createOrderSummary();
//
//    String toMailId = "order@justdart.com";
//    String subject = "Order ($quantity) cups for $userName";
//    String body = "$priceMessage";
//
//    var url = 'mailto:$toMailId?subject=$subject&body=$body';
//    if (await canLaunch(url)) {
//      await launch(url);
//    } else {
//      throw 'Could not launch $url';
//    }
//  }
//
//  // Calculates the order prices:
//  // - Total price
//  // - Total toppings price
//  // - Total "Whipped Cream" cups price
//  // - Total "Chocolate" cups price
//  calculatePrice() {
//    setState(() {
//      totalPrice = basePrice * quantity;
//    });
//
//    if (creamValue) {
//      setState(() {
//        totalPrice = totalPrice + quantity * whippedCreamCost;
//        totalCreamPrice = quantity * whippedCreamCost;
//      });
//    }
//
//    if (chocoValue) {
//      setState(() {
//        totalPrice = totalPrice + quantity * chocolateCost;
//        totalChocoPrice = quantity * chocolateCost;
//      });
//    }
//
//    setState(() {
//      totalToppingsPrice = totalChocoPrice + totalCreamPrice;
//    });
//  }
//
//  // Creates Order Summary for email message body
//  String createOrderSummary() {
//    String priceMessage = "Name: $userName\n"
//        "\n Add Whipped Cream? => $creamValue"
//        "\n Add Chocolate? => $chocoValue\n"
//        "\n Quantity: $quantity\n"
//        "\n Total Cream price: \$$totalCreamPrice"
//        "\n Total Chocolate price: \$$totalChocoPrice"
//        "\n Total toppings price: \$$totalToppingsPrice\n"
//        "\n Total = \$$totalPrice"
//        "\n Thank you!";
//    return priceMessage;
//  }
//}

// This is a class to prepare a SnackBar to show
// and prevent it to pop up for every tap on the button
// (Tap on the button 67 times but only the last tap will pop up the SnackBar)
class SingleSnackBar {
  static SnackBar mSnackBar;

  static void show(BuildContext context, String text) {
    if (mSnackBar != null) Scaffold.of(context).removeCurrentSnackBar();
    mSnackBar = new SnackBar(
      content: Text(
        text,
        style: TextStyle(color: (darkThemeOn) ? white : black1),
      ),
      backgroundColor: (darkThemeOn) ? lightBlack : lightGrey,
//      shape: Border(
//        top: BorderSide(color: blue1, width: 5.0),
//      ),
      elevation: 20.0,
    );
    Scaffold.of(context).showSnackBar(mSnackBar);
  }
}
