class Produit {
  String id;
  String nom;
  String prix;
  String image;
  Produit(this.id, this.nom, this.prix, this.image);
  Produit.sansImage(this.id, this.nom, this.prix);

  Map<String, dynamic> toMap() {
    return {
      'id': (id == 0) ? null : id,
      'nom': nom,
      'prix': prix,
      'image': image,
    };
  }

Map<String, dynamic> toMapsi() {
    return {
      'id': (id == 0) ? null : id,
      'nom': nom,
      'prix': prix,
    };
  }
}

class CProduit {

  String nom,prix;
  String idUser;
  String qte;
  CProduit( this.nom, this.prix, this.idUser, this.qte);

  Map<String, dynamic> toMap() {
    return {
     
      'nom': nom,
      'prix': prix,
      'idUser': idUser,
      'qte': qte,
    };
  }
}


