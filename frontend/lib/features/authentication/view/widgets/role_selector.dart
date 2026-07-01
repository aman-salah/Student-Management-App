import 'package:flutter/material.dart';

class RoleSelector extends StatelessWidget {
  final String selectedRole;
  final ValueChanged<String> onChanged;

  const RoleSelector({
    super.key,
    required this.selectedRole,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
      selected: {selectedRole},
      onSelectionChanged: (Set<String> selection) {
        onChanged(selection.first);
      },
      segments: const [
        ButtonSegment<String>(
          value: "student",
          label: Text("Student"),
          icon: Icon(Icons.school),
        ),
        ButtonSegment<String>(
          value: "mentor",
          icon: Icon(Icons.person_outline),
          label: Text("Mentor"),
        ),
      ],
    );
  }
}
