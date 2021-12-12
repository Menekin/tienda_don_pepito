enum BusinessType { abarrotes, drogueria, video_juegos, carnes }

class Store {
  final String id,
      nombre,
      direccion,
      telefono_fijo,
      telefono_celular,
      email,
      pagina_web,
      logo;
  final double latitud, longitud;
  final BusinessType tipo;

  Store(
    this.id,
    this.nombre,
    this.direccion,
    this.latitud,
    this.longitud,
    this.telefono_fijo,
    this.telefono_celular,
    this.email,
    this.pagina_web,
    this.tipo,
    this.logo,
  );

  Store.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        nombre = json['nombre'],
        direccion = json['direccion'],
        latitud = double.parse(json['latitud'].toString()),
        longitud = double.parse(json['longitud'].toString()),
        telefono_fijo = json['telefono_fijo'].toString(),
        telefono_celular = json['telefono_celular'].toString(),
        email = json['email'],
        pagina_web = json['pagina_web'],
        tipo = BusinessType.values.firstWhere(
            (element) => element.toString() == json['tipo'].toString()),
        logo = json['logo'];

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "direccion": direccion,
        "latitud": latitud,
        "longitud": longitud,
        "telefono_fijo": telefono_fijo,
        "telefono_celular": telefono_celular,
        "email": email,
        "pagina_web": pagina_web,
        "tipo": tipo.toString(),
        "logo": logo,
      };
}
