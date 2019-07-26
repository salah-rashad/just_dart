import 'package:flutter/material.dart';
import 'home.dart';

class Fun extends HomeState {
    bool _buttonPressed = false;
    bool _loopActive = false;
    // makes quantity change faster while press and hold on (+ / -) buttons
    static void _longPressQuantity(String s) async {
        // make sure that only one loop is active
        if (_loopActive) return;

        _loopActive = true;

        await Future.delayed(Duration(milliseconds: 700));

        while (_buttonPressed) {
            setState(() {
                if (s == "increment") {
                    increment();
                }
                if (s == "decrement") {
                    decrement();
                }
            });

            // wait a bit
            await Future.delayed(Duration(milliseconds: 100));
        }

        _loopActive = false;
    }

    // Fixing quantity if "Quantity Switch" is on
    static void fastQuantityFixed(bool value) {
        setState(() {
            quantitySwitch = value;
        });

        if (quantitySwitch) {
            if (quantity <= 10) {
                setState(() {
                    quantity = 10;
                });
            } else if (quantity <= 20) {
                setState(() {
                    quantity = 20;
                });
            } else if (quantity <= 30) {
                setState(() {
                    quantity = 30;
                });
            } else if (quantity <= 40) {
                setState(() {
                    quantity = 40;
                });
            } else if (quantity <= 50) {
                setState(() {
                    quantity = 50;
                });
            } else if (quantity <= 60) {
                setState(() {
                    quantity = 60;
                });
            } else if (quantity <= 70) {
                setState(() {
                    quantity = 70;
                });
            } else if (quantity <= 80) {
                setState(() {
                    quantity = 80;
                });
            } else if (quantity <= 90) {
                setState(() {
                    quantity = 90;
                });
            } else if (quantity <= 100 || quantity > 100) {
                setState(() {
                    quantity = 100;
                });
            }
            updateSummary();
        }
    }

    // Updates summary of the order.
    static void updateSummary() {
        setState(() {
            if (!creamValue) {
                totalCreamPrice = 0.0;
            }
            if (!chocoValue) {
                totalChocoPrice = 0.0;
            }
            calculatePrice();
            summaryValues =
            "$quantity cups\n×\n\$$basePrice\n+\n\$$totalCreamPrice\n+\n\$$totalChocoPrice";
        });
    }

    // Increases the quantity
    static void increment() {
        if (quantity >= 100) {
            SingleSnackBar.show(context, "You can't order more than 100 cups!");
            return;
        } else if (quantitySwitch) {
            if (quantity == 1) {
                setState(() {
                    quantity = 10;
                });
                updateSummary();
                return;
            }
            setState(() {
                quantity = quantity + 10;
            });
            updateSummary();
            return;
        }

        setState(() {
            quantity = quantity + 1;
            updateSummary();
        });
    }

    // Decreases the quantity
    static void decrement() {
        if (quantity <= 1) {
            SingleSnackBar.show(context, "You can't order less than 1 cup!");
            setState(() {
                quantity = 1;
            });
            return;
        } else if (quantitySwitch) {
            if (quantity <= 10) {
                setState(() {
                    quantity = 1;
                });
                updateSummary();
                return;
            }
            setState(() {
                quantity = quantity - 10;
            });
            updateSummary();
            return;
        }

        setState(() {
            quantity = quantity - 1;
            updateSummary();
        });
    }

    // Sends the order using mail app
    static void submitOrder() async {
        String priceMessage = createOrderSummary();

        String toMailId = "order@justdart.com";
        String subject = "Order ($quantity) cups for $userName";
        String body = "$priceMessage";

        var url = 'mailto:$toMailId?subject=$subject&body=$body';
        if (await canLaunch(url)) {
            await launch(url);
        } else {
            throw 'Could not launch $url';
        }
    }

    // Calculates the order prices:
    // - Total price
    // - Total toppings price
    // - Total "Whipped Cream" cups price
    // - Total "Chocolate" cups price
    static void calculatePrice() {
        setState(() {
            totalPrice = basePrice * quantity;
        });

        if (creamValue) {
            setState(() {
                totalPrice = totalPrice + quantity * whippedCreamCost;
                totalCreamPrice = quantity * whippedCreamCost;
            });
        }

        if (chocoValue) {
            setState(() {
                totalPrice = totalPrice + quantity * chocolateCost;
                totalChocoPrice = quantity * chocolateCost;
            });
        }

        setState(() {
            totalToppingsPrice = totalChocoPrice + totalCreamPrice;
        });
    }

    // Creates Order Summary for email message body
    static String createOrderSummary() {
        String priceMessage = "Name: $userName\n"
          "\n Add Whipped Cream? => $creamValue"
          "\n Add Chocolate? => $chocoValue\n"
          "\n Quantity: $quantity\n"
          "\n Total Cream price: \$$totalCreamPrice"
          "\n Total Chocolate price: \$$totalChocoPrice"
          "\n Total toppings price: \$$totalToppingsPrice\n"
          "\n Total = \$$totalPrice"
          "\n Thank you!";
        return priceMessage;
    }
}
}