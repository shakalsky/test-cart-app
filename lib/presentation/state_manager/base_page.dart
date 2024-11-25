part of 'base_cubit.dart';

abstract class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  State<BasePage> createState();
}

abstract class BasePageState<P extends BasePage, C extends BaseCubit> extends State<P> {
  @protected
  final cubit = i.get<C>();

  @override
  void initState() {
    super.initState();
    cubit.init();
  }

  @override
  void dispose() {
    super.dispose();
    cubit.dispose();
  }

  void pop() => Navigator.of(context).pop();
}
