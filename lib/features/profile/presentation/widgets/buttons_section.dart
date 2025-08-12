import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hangangramyeon/core/constants/app_sizes.dart';
import 'package:hangangramyeon/core/utils/extensions.dart';
import 'package:hangangramyeon/core/widgets/app_button.dart';
import 'package:hangangramyeon/features/auth/blocs/authentication/authentication_cubit.dart';

class ButtonsSection extends StatelessWidget {
  final VoidCallback onSaveChanges;

  const ButtonsSection({
    super.key,
    required this.onSaveChanges,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Save button
        AppButton(
          color: context.theme.primaryColor,
          width: double.infinity,
          title: 'Save Changes',
          onClick: onSaveChanges,
        ),

        AppSizes.gapH16,

        // Logout button
        AppButton(
          color: Colors.red,
          width: double.infinity,
          title: 'Logout',
          onClick: () {
            context.read<AuthenticationCubit>().signOut();
            // Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
