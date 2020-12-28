

class cellObject {

  String title;
  int qty;

  cellObject(
      this.title,
      this.qty);

  @override
  String toString() {
    return '{ "title": "${this.title}","qty": "${this.qty}"}';
  }
}