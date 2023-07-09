class Quote {
  late final String quote;

  Quote.formJson(Map<String, dynamic> json) {
    quote = json['quote'];
  }
}
