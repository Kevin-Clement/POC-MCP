import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'recipes_record.g.dart';

abstract class RecipesRecord
    implements Built<RecipesRecord, RecipesRecordBuilder> {
  static Serializer<RecipesRecord> get serializer => _$recipesRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'display_name')
  String get displayName;

  @nullable
  String get comment;

  @nullable
  @BuiltValueField(wireName: 'photo_url')
  String get photoUrl;

  @nullable
  bool get card;

  @nullable
  bool get internal;

  @nullable
  int get portion;

  @nullable
  String get time;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(RecipesRecordBuilder builder) => builder
    ..displayName = ''
    ..comment = ''
    ..photoUrl = ''
    ..card = false
    ..internal = false
    ..portion = 0
    ..time = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('recipes');

  static Stream<RecipesRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  RecipesRecord._();
  factory RecipesRecord([void Function(RecipesRecordBuilder) updates]) =
      _$RecipesRecord;

  static RecipesRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createRecipesRecordData({
  String displayName,
  String comment,
  String photoUrl,
  bool card,
  bool internal,
  int portion,
  String time,
}) =>
    serializers.toFirestore(
        RecipesRecord.serializer,
        RecipesRecord((r) => r
          ..displayName = displayName
          ..comment = comment
          ..photoUrl = photoUrl
          ..card = card
          ..internal = internal
          ..portion = portion
          ..time = time));
