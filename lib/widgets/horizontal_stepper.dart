import 'package:horizontal_stepper_flutter/horizontal_stepper_flutter.dart';

import '../barrels.dart';

class HorizontalStepper extends StatelessWidget {
   final int currentStep;
   const HorizontalStepper({super.key,required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return FlutterHorizontalStepper(steps: itemsTipo
    ,currentStepColor: Colors.brown
    ,completeStepColor: const Color.fromARGB(255, 211, 165, 148)
   // ,inActiveStepColor: const Color.fromARGB(255, 70, 50, 42)
    , radius: 45
    , currentStep: currentStep
    , child:const [
      Text('1', style: TextStyle(fontSize: 20, color: Colors.white)),
      Text('2', style: TextStyle(fontSize: 20, color: Colors.white)),
      Text('3', style: TextStyle(fontSize: 20, color: Colors.white)),

    ]);

  }
}