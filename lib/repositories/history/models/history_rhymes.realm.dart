// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_rhymes.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
class HistoryRhymes extends _HistoryRhymes
    with RealmEntity, RealmObjectBase, RealmObject {
  HistoryRhymes(String id, String word, {Iterable<String> rhymes = const []}) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'word', word);
    RealmObjectBase.set<RealmList<String>>(
      this,
      'rhymes',
      RealmList<String>(rhymes),
    );
  }

  HistoryRhymes._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get word => RealmObjectBase.get<String>(this, 'word') as String;
  @override
  set word(String value) => RealmObjectBase.set(this, 'word', value);

  @override
  RealmList<String> get rhymes =>
      RealmObjectBase.get<String>(this, 'rhymes') as RealmList<String>;
  @override
  set rhymes(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<HistoryRhymes>> get changes =>
      RealmObjectBase.getChanges<HistoryRhymes>(this);

  @override
  Stream<RealmObjectChanges<HistoryRhymes>> changesFor([
    List<String>? keyPaths,
  ]) => RealmObjectBase.getChangesFor<HistoryRhymes>(this, keyPaths);

  @override
  HistoryRhymes freeze() => RealmObjectBase.freezeObject<HistoryRhymes>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'word': word.toEJson(),
      'rhymes': rhymes.toEJson(),
    };
  }

  static EJsonValue _toEJson(HistoryRhymes value) => value.toEJson();
  static HistoryRhymes _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {'id': EJsonValue id, 'word': EJsonValue word} => HistoryRhymes(
        fromEJson(id),
        fromEJson(word),
        rhymes: fromEJson(ejson['rhymes']),
      ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(HistoryRhymes._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
      ObjectType.realmObject,
      HistoryRhymes,
      'HistoryRhymes',
      [
        SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
        SchemaProperty('word', RealmPropertyType.string),
        SchemaProperty(
          'rhymes',
          RealmPropertyType.string,
          collectionType: RealmCollectionType.list,
        ),
      ],
    );
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
