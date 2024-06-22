import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_series_app/features/auth_feature/auth_feature.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = context.read<AuthState>();
      await _fetchPin(
        updateAuthState: provider.updateAuthState,
      );
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Authentication'),
        ),
        body: Consumer<AuthState>(builder: (context, provider, child) {
          switch (provider.authStateEnum) {
            case AuthStateEnum.initial:
              return const Center(child: CircularProgressIndicator());
            case AuthStateEnum.createPin:
              return Container();
            case AuthStateEnum.confirmPin:
              return Container();
          }
        }),
      );

  Future<void> _fetchPin({
    required void Function(AuthStateEnum) updateAuthState,
  }) async {

  }
}
