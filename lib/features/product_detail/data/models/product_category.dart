enum ProductCategory {
  all('전체'),
  device('기기'),
  liquid('액상'),
  accessory('코일/팟/기타');

  final String label;
  const ProductCategory(this.label);
}