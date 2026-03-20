import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/global_button.dart';
class ResettingPasswordConfirmationButton extends StatelessWidget {
  const ResettingPasswordConfirmationButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GlobalButton(text: "Confirm", height: 56.h, width: 376.w, onPressed: (){
      //TODO
    });
  }
}