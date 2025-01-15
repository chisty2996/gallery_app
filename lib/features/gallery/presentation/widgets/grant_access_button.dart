import 'package:flutter/material.dart';

class GrantAccessButton extends StatelessWidget {
  final Function()? onTap;
  const GrantAccessButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 72),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(31),
            color: Theme.of(context).colorScheme.secondary,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: Text(
                "Grant Access",
                style: Theme.of(context).primaryTextTheme.labelMedium,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
