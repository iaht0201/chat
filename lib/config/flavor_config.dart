enum Flavor {
  DEV,
  STG,
  PRODUCTION,
}

class FlavorValues {
  final String baseUrl;

  const FlavorValues({required this.baseUrl});
  // Thêm các giá trị khác nếu cần, ví dụ: databaseName, apiKey, v.v.
}

class FlavorConfig {
  final Flavor flavor;
  final String name;
  final FlavorValues values;

  static FlavorConfig? _instance;

  // Factory constructor để đảm bảo chỉ tạo một instance duy nhất (Singleton)
  factory FlavorConfig({
    required Flavor flavor,
    required String name,
    required FlavorValues values,
  }) {
    _instance ??= FlavorConfig._internal(flavor, name, values);
    return _instance!;
  }

  FlavorConfig._internal(this.flavor, this.name, this.values);

  static FlavorConfig get instance {
    if (_instance == null) {
      throw Exception('FlavorConfig has not been initialized');
    }
    return _instance!;
  }

  // Các hàm tiện ích kiểm tra loại môi trường hiện tại
  static bool isProduction() => _instance?.flavor == Flavor.PRODUCTION;
  static bool isDevelopment() => _instance?.flavor == Flavor.DEV;
  static bool isStaging() => _instance?.flavor == Flavor.STG;

  @override
  String toString() {
    return 'Flavor: $flavor, Name: $name, Base URL: ${values.baseUrl}';
  }
}

// Hàm khởi tạo FlavorConfig theo từng môi trường
void setFlavor(Flavor flavor) {
  switch (flavor) {
    case Flavor.DEV:
      FlavorConfig(
        flavor: Flavor.DEV,
        name: "DemoFlavor-Dev",
        values: FlavorValues(baseUrl: "http://xxxxxDEV.yx/api/"),
      );
      break;
    case Flavor.STG:
      FlavorConfig(
        flavor: Flavor.STG,
        name: "DemoFlavor-Stg",
        values: FlavorValues(baseUrl: "http://xxxxxSTG.yx/api/"),
      );
      break;
    case Flavor.PRODUCTION:
      FlavorConfig(
        flavor: Flavor.PRODUCTION,
        name: "DemoFlavor-Production",
        values: FlavorValues(baseUrl: "http://xxxxxPRODUCTION.yx/api/"),
      );
      break;
  }
}
