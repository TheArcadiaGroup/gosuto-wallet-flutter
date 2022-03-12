import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'seed_phrase_controller.dart';

class SeedPhraseScreen extends GetView<SeedPhraseController> {
  const SeedPhraseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
      )),
    );
  }
}
