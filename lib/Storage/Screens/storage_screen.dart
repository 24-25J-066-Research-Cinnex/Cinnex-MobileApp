import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../Shared/Widget/curved_appbar.dart';

class FileStoragePage extends StatelessWidget {
  const FileStoragePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: Stack(
        children: [
          // Curved AppBar Background
          CurvedAppBar(
            title: AppLocalizations.of(context)!.storage,
            trailingIcon: Icons.notifications,
            onTrailingIconPressed: null, // Add action if needed
          ),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 150),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                      ),
                      children: [
                        _buildFolderTile(
                          context,
                          AppLocalizations.of(context)!
                              .cinnamon_grades, // Use localization
                          Icons.folder,
                          colorScheme.primary,
                          'grades',
                        ),
                        _buildFolderTile(
                          context,
                          AppLocalizations.of(context)!.cinnamon_diseases,
                          Icons.folder,
                          colorScheme.primary,
                          'diseases',
                        ),
                        _buildFolderTile(
                          context,
                          AppLocalizations.of(context)!.cinnamon_species,
                          Icons.folder,
                          colorScheme.primary,
                          'leaves',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFolderTile(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    String folderName,
  ) {
    return GestureDetector(
      onTap: () {
        // Navigate to folder-specific screen or file upload
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FileUploadPage(folderName: folderName),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class FileUploadPage extends StatelessWidget {
  final String folderName;

  const FileUploadPage({required this.folderName, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload to $folderName'),
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () {
            // File upload logic
          },
          icon: const Icon(Icons.upload_file),
          label: const Text('Upload File'),
        ),
      ),
    );
  }
}
