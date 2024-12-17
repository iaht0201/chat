enum TableData { ACCOUNT }

class TableSupabase {
  static String? getTable(TableData table) {
    switch (table) {
      case TableData.ACCOUNT:
        return "accounts";
      default:
        return "";
    }
  }
}
