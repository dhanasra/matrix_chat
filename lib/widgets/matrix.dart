import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';

class Matrix extends StatefulWidget {
  final Widget? child;
  final List<Client> clients;

  const Matrix({
    this.child,
    required this.clients,
    Key? key
  }) : super(key: key);

  @override
  State<Matrix> createState() => _MatrixState();
}

class _MatrixState extends State<Matrix> {


  @override
  Widget build(BuildContext context) {
    return widget.child!;
  }
}
