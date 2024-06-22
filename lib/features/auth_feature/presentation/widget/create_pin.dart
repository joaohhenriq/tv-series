import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tv_series_app/features/home_feature/routes/home_route.dart';

class CreatePin extends StatefulWidget {
  const CreatePin({
    super.key,
    required this.loadingButton,
    required this.onTap,
  });

  final bool loadingButton;
  final Future<bool> Function(String) onTap;

  @override
  State<CreatePin> createState() => _CreatePinState();
}

class _CreatePinState extends State<CreatePin> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) => ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Please, create a pin with 4 numbers to access Tv Maze',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 12.0,
              left: 12.0,
              right: 12.0,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: TextField(
                        maxLength: 4,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        keyboardType: TextInputType.number,
                        controller: controller,
                        onSubmitted: (_) => _onTapButton(controller.text),
                        decoration: InputDecoration(
                          labelText: 'Enter your pin',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _onTapButton(controller.text),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF525557),
                    ),
                    child: const Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );

  Future<void> _onTapButton(String pin) async {
    if(widget.loadingButton) return;
    if(pin.length != 4) return;
    final result = await widget.onTap(pin);
    if(result) Modular.to.navigate(HomeNavigation.homeOptions);
  }
}
