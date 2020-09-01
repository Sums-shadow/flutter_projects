class AdminModel {
  String id;
  String nom;
  String image;

  AdminModel({this.id, this.nom, this.image});

  AdminModel.fromMap(Map snap, String id)
      : id = id ?? '',
        nom = snap['nom'] ?? '',
        image = snap['image'] ?? '';

  toJson() {
    return {"nom": nom, "image": image};
  }
}
