class CategoryTages {
  static final all = <TagesData>[
    TagesData(label: 'left foot', image: ''),
    TagesData(label: 'right foot', image: ''),
    TagesData(label: 'african', image: ''),
    TagesData(label: 'north african', image: ''),
    TagesData(label: 'less 25 y-old', image: ''),
    TagesData(label: 'less 30 y-old', image: ''),
  ];
}

class TagesData {
  late final String label;
  late final String image;
  TagesData({required this.label, required this.image});
}
