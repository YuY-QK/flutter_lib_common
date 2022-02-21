import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

/// 构建变化的子组件
typedef ValueNotifyBuilder<W extends Widget, T> = W Function(BuildContext context, T value);

typedef ValueChange<T> = void Function(T changeValue);

class StateNotifier<W extends Widget, T> extends StatelessWidget {

  final ValueNotifyData<T> valueNotify;
  final ValueNotifyBuilder<W, T> builder;

  StateNotifier({
    Key? key,
    required this.valueNotify,
    required this.builder,
  }) : super(
      key: key
  );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ValueNotifyData>(
      create: (_) => valueNotify,
      child: Consumer<ValueNotifyData>(
        builder: (context, _info, _child) {
          return builder(context, _info.valueChangeValue);
        },
      ),
    );
  }
}

class ValueNotifyData<T> with ChangeNotifier {
  T _valueChangeValue;

  ValueNotifyData(this._valueChangeValue);

  void changeData(T value) {
    _valueChangeValue = value;
    notifyListeners();
  }

  get valueChangeValue => _valueChangeValue;
}