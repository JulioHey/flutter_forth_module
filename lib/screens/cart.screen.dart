import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/cart_item.dart';
import '../providers/cart.provider.dart' show CartProvider;
import '../providers/orders.provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build (BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children : <Widget>[
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.headline1.color,
                      )
                    ),
                    backgroundColor: Theme.of(context).primaryColor,                      
                  ),
                  OrderButton(cart),
                ]
              )
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return 
                  CartItem(
                    cart.items.values.toList()[index].id,
                    cart.items.keys.toList()[index],
                    cart.items.values.toList()[index].price,
                    cart.items.values.toList()[index].quantity,
                    cart.items.values.toList()[index].title,
                  );
              },
              itemCount: cart.itemCount,
            )
          )
        ]
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  final CartProvider cart;

  OrderButton(this.cart);

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext build) {
    return _isLoading ? CircularProgressIndicator() : TextButton(
      child: Text(
        'Order Now',
        style: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
      ),
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading) ? null : () async {
        setState(() {
          _isLoading = true;
        });

        await Provider.of<OrdersProvider>(context, listen: false).addOrder(
          widget.cart.items.values.toList(), 
          widget.cart.totalAmount
        );

        setState(() {
          _isLoading = false;
        });

        widget.cart.clear();
      },
    );
  }
}

// For to call a listener inside a onPressed function you need to use listen: false