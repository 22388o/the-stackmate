@TestOn('vm')

import 'dart:io';

import 'package:hive/hive.dart';
import 'package:hive/src/adapters/date_time_adapter.dart';
import 'package:hive/src/hive_impl.dart';
import 'package:test/test.dart';
import 'hive_common.dart';

void main() {
  Future<HiveImpl> initHive() async {
    var tempDir = await getTempDir();
    var hive = HiveImpl();
    hive.init(tempDir.path);
    return hive;
  }

  test('returns false if no box was created', () async {
    var hive = await initHive();
    var box = await hive.openBox('testBox');
    await box.put('key', 'value');
    expect(box.get('key'), 'value');
    await hive.close();
  });
}
