import 'package:breaking_bad/constants/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'business_logic_layer/cubit/bloc_observer.dart';
import 'presentation_layer/app_router.dart';

void main() {



  BlocOverrides.runZoned(() {
    runApp(BreakingBadApp(AppRouter()));
  }
      ,blocObserver: MyBlocObserver()
  );
}

class BreakingBadApp extends StatelessWidget {
  late AppRouter appRouter;

  BreakingBadApp(this.appRouter);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
      theme: ThemeData(
          primaryColor: MyColors.yellow,
          scaffoldBackgroundColor: MyColors.grey,
          iconTheme: IconThemeData(
            color: MyColors.grey,
          )),
    );
  }
}
