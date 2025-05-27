import 'package:flutter/material.dart';
import 'package:my_rhymer/ui/ui.dart';

class SearchRhymesBottomSheet extends StatelessWidget {
  const SearchRhymesBottomSheet({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BaseBottomSheet(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.hintColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: 'Введите слово...',
                        hintStyle: TextStyle(
                          color: theme.hintColor.withValues(alpha: 0.5),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => _onTapSearch(context),
                  child: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.search, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.separated(
              itemBuilder:
                  (context, index) =>
                      const ListTile(title: Text('Слово из автокомплита')),
              separatorBuilder: (context, _) => const Divider(),
              itemCount: 10,
            ),
          ),
        ],
      ),
    );
  }

  void _onTapSearch(BuildContext context) {
    Navigator.of(context).pop(controller.text);
  }
}
