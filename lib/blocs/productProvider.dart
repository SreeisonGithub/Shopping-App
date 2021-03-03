import 'package:flutter/cupertino.dart';

import 'productBloc.dart';
export 'productBloc.dart';

class ProductProvider extends InheritedWidget {
  final ProductBloc bloc;

  ProductProvider({Key key, Widget child})
      : bloc = ProductBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static ProductBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType(aspect: ProductProvider)
            as ProductProvider)
        .bloc;
  }
}
