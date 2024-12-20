import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:text_to_speech/config/table_data.dart';

abstract class SupbaseService {
  Future<void> initSupabase(String url, String apiKey);
  Future<void> createData({required TableData tableData, required Map<String, dynamic> data});
  Future<dynamic> fetchData(String id);
  Future<void> updateDataById(
      {required TableData tableData, required int id, required Map<String, dynamic> data});
  Future<void> deleteDataById(
      {required TableData tableData, required int id, required Map<String, dynamic> data});

  Future<dynamic> upsertData({required TableData tableData, required Map<String, dynamic> data});
}

class SupbaseConfig extends SupbaseService {
  static SupabaseClient? client;
  @override
  Future<void> initSupabase(String url, String apiKey) async {
    await Supabase.initialize(
      url: url,
      anonKey: apiKey,
    );
    client = Supabase.instance.client;
    // print("Supabase initialized successfully!");
  }

  @override
  Future<void> createData(
      {required TableData tableData, required Map<String, dynamic> data}) async {
    //  insert data
    await client?.from(TableSupabase.getTable(tableData).toString()).insert(data);
  }

  @override
  Future<void> deleteDataById(
      {required TableData tableData, required int id, required Map<String, dynamic> data}) async {
    await client?.from(TableSupabase.getTable(tableData).toString()).update(data).eq('id', 1);
  }

  @override
  Future fetchData(String id) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateDataById(
      {required TableData tableData, required int id, required Map<String, dynamic> data}) async {
    await client?.from(TableSupabase.getTable(tableData).toString()).update(data).eq('id', 1);
  }

  // @override
  // Future<void> updateData(
  //     {required TableData tableData, required int id, required Map<String, dynamic> data}) {
  //   throw UnimplementedError();
  // }

  @override
  Future<dynamic> upsertData(
      {required TableData tableData, required Map<String, dynamic> data}) async {
    await client?.from(TableSupabase.getTable(tableData).toString()).upsert(data).select();
  }
}
