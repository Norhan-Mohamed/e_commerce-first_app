class Price {
  late Current current;
  late String currency;

  Price({
    required this.currency,
    required this.current,
  });

  Price.fromMap(Map<String, dynamic> map) {
    current = Current.fromMap(map['current']);
    currency = map['currency'];
  }

  Map<String, dynamic> toMap() {
    return {
      "current": current.toMap(),
      "currency": currency,
    };
  }
}

class Current {
  late double value;
  late String text;

  Current({
    required this.value,
    required this.text,
  });

  Current.fromMap(Map<String, dynamic> map) {
    value = (map['value'] as num).toDouble();
    text = map['text'];
  }

  Map<String, dynamic> toMap() {
    return {
      "value": value,
      "text": text,
    };
  }
}
