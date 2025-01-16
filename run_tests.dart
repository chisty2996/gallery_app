import 'dart:io';

void main() async {

  final testDir = Directory('test');
  if (!testDir.existsSync()) {
    print('Test directory not found.');
    return;
  }

  print('Test directory found at: ${testDir.path}');

  final testFiles = testDir
      .listSync(recursive: true)
      .whereType<File>()
      .where((file) =>
  file.path.endsWith('.dart') &&
      !file.path.endsWith('widget_test.dart') && !file.path.endsWith('gallery_data_sources_test.mocks.dart'))
      .toList();

  if (testFiles.isEmpty) {
    print('No test files found.');
    return;
  }

  print('Test files to execute:');
  for (final file in testFiles) {
    print('  - ${file.path}');
  }

  // Execute each test file
  for (final testFile in testFiles) {
    print('Running tests in ${testFile.path}');
    final result = await Process.run(
      'flutter',
      ['test', testFile.path],
      runInShell: true,
    );

    print(result.stdout);

    if (result.exitCode != 0) {
      print('Test failed for ${testFile.path}');
      print(result.stderr);
      exit(result.exitCode);
    }
  }

  print('All tests completed successfully.');
}
