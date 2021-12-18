import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:cool_linter/src/config/analysis_settings.dart';
import 'package:cool_linter/src/rules/always_specify_types_rule/always_specify_types_result.dart';
import 'package:cool_linter/src/rules/always_specify_types_rule/always_specify_types_rule.dart';
import 'package:cool_linter/src/rules/rule.dart';
import 'package:cool_linter/src/rules/rule_message.dart';
import 'package:cool_linter/src/utils/analyse_utils.dart';
import 'package:cool_linter/src/utils/resolved_unit_util.dart';
import 'package:test/test.dart';

const String _kTestDataPath = 'test/always_specify_types/test_data.dart';

void main() {
  late ResolvedUnitResult resolvedUnitResult;

  group('regexp find lines by patterns', () {
    setUp(() async {
      resolvedUnitResult = await getResolvedUnitResult(_kTestDataPath);
    });

    final Rule specifyTypesRule = AlwaysSpecifyTypesRule();

    test('specify types', () async {
      final AnalysisSettings analysisSettings = AnalysisSettings.fromJson(
        AnalysisSettingsUtil.convertYamlToMap(
          r'''
          cool_linter:
            always_specify_types:
              #- typed_literal
              #- declared_identifier # OK
              - set_or_map_literal
              #- simple_formal_parameter # OK
              #- type_name # partially OK
              #- variable_declaration_list # OK
        ''',
        ),
      );

      expect(analysisSettings.useAlwaysSpecifyTypes, isTrue);

      final List<RuleMessage> list = specifyTypesRule.check(
        parseResult: resolvedUnitResult,
        analysisSettings: analysisSettings,
      );

      // ==================
      // final Iterable<RuleMessage> typedLiteralList =
      for (final RuleMessage message in list) {
        // ignore: unused_local_variable
        final String? typeStr =
            kOptionNameOfResultType[ResultType.typedLiteral];
        final Location loc = message.location;

        final String part1 = 'corr: ${message.correction} ';
        final String part2 = 'offset = ${loc.offset}';
        final String part3 = 'line: [${loc.startLine}] '; //:${loc.endLine}] ';
        final String part4 = 'column: [${loc.startColumn}:${loc.endColumn}] ';

        print(
            '$part1 $part2 $part3 $part4 ${loc.file}:${loc.endLine}:${loc.endColumn}');

        // print(
        //   'corr: ${e.correction} offset: ${e.location.offset} startline: ${e.location.startLine} column: [${e.location.startColumn}:${e.location.endColumn}]',
        // );
      }
      // expect(typedLiteralList, hasLength(3));
      // ==================

      // typedLiteral
      // final Iterable<RuleMessage> typedLiteralList = list.where((RuleMessage e) {
      //   return e.code == kOptionNameOfResultType[ResultType.typedLiteral];
      // });
      // expect(typedLiteralList, hasLength(3));

      // // typeName
      // final Iterable<RuleMessage> typeNameList = list.where((RuleMessage e) {
      //   return e.code == kOptionNameOfResultType[ResultType.typeName];
      // });
      // expect(typeNameList, hasLength(4));

      // // variableDeclarationList
      // final Iterable<RuleMessage> varDecList = list.where((RuleMessage e) {
      //   return e.code == kOptionNameOfResultType[ResultType.variableDeclarationList];
      // });
      // expect(varDecList, hasLength(10));

      // // simpleFormalParameter
      // final Iterable<RuleMessage> simpleFParList = list.where((RuleMessage e) {
      //   return e.code == kOptionNameOfResultType[ResultType.simpleFormalParameter];
      // });
      // expect(simpleFParList, hasLength(5));

      // expect(list, hasLength(24));
    });
  });
}
