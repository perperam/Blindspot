Map<String, dynamic> renameImageData(
    Map<String, dynamic> imageData, String newName) {
  imageData['name'] = newName;
  return imageData;
}
