import 'package:flutter/material.dart';
import '../features/booking/view/screens/search_by_category_screen.dart';

class Sandbox extends StatelessWidget {
  const Sandbox({super.key});

  @override
  Widget build(BuildContext context) {
    return const SearchByCategoryScreen(departmentName: "Cardiology");
  }
}
