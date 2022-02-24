part of 'services.dart';

class FlutixTransactionServices {
  static CollectionReference transactionCollection =
      Firestore.instance.collection('transactions');

  static Future<void> saveTransaction(
      FlutixTransaction flutixTransaction) async {
    await transactionCollection.document().setData({
      'userID': flutixTransaction.userID,
      'title': flutixTransaction.title,
      'subtitle': flutixTransaction.subtitle,
      'time': flutixTransaction.time.millisecondsSinceEpoch,
      'amount': flutixTransaction.amount,
      'picture': flutixTransaction.picture
    });
  }

  static Future<List<FlutixTransaction>> getTransaction(String userID) async {
    QuerySnapshot snapshot = await transactionCollection.getDocuments();
    var documents = snapshot.documents
        .where((document) => document.data['userID'] == userID);
    print(documents);
    return documents
        .map(
          (document) => FlutixTransaction(
              userID: document.data['userID'],
              title: document.data['title'],
              subtitle: document.data['subtitle'],
              time: DateTime.fromMillisecondsSinceEpoch(document.data['time']),
              amount: document.data['amount'],
              picture: document.data['picture']),
        )
        .toList();
  }
}
