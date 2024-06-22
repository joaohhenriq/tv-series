import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tv_series_app/features/home_feature/routes/home_route.dart';

class PinHandlerWidget extends StatefulWidget {
  const PinHandlerWidget({
    super.key,
    required this.loadingButton,
    required this.isDeviceBiometricSupported,
    required this.isDeviceBiometricAuthAllowed,
    required this.description,
    required this.buttonDescription,
    required this.onTapCheckBiometric,
    required this.onTapButton,
  });

  final bool loadingButton;
  final bool isDeviceBiometricSupported;
  final bool isDeviceBiometricAuthAllowed;
  final String description;
  final String buttonDescription;
  final void Function(bool) onTapCheckBiometric;
  final Future<bool> Function(String, bool) onTapButton;

  @override
  State<PinHandlerWidget> createState() => _PinHandlerWidgetState();
}

class _PinHandlerWidgetState extends State<PinHandlerWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) => ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              widget.description,
              style: const TextStyle(
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
                        onSubmitted: (_) => _onTapButton(
                          controller.text,
                          widget.isDeviceBiometricAuthAllowed,
                        ),
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
                    onPressed: () => _onTapButton(
                      controller.text,
                      widget.isDeviceBiometricAuthAllowed,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF525557),
                    ),
                    child: Text(
                      widget.buttonDescription,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (widget.isDeviceBiometricSupported)
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Checkbox(
                      value: widget.isDeviceBiometricAuthAllowed,
                      onChanged: (value) =>
                          widget.onTapCheckBiometric(value ?? false),
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'Allow biometric auth for next authentication',
                    ),
                  ),
                ],
              ),
            )
        ],
      );

  Future<void> _onTapButton(
    String pin,
    bool isDeviceBiometricAuthAllowed,
  ) async {
    if (widget.loadingButton) return;
    if (pin.length != 4) return;
    FocusScope.of(context).unfocus();
    final result = await widget.onTapButton(pin, isDeviceBiometricAuthAllowed);
    if (result) Modular.to.navigate(HomeNavigation.homeOptions);
  }
}
