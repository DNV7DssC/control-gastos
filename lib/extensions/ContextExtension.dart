import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  ModalRoute get modalRoute => ModalRoute.of(this);
}
