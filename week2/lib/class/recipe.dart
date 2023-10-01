  class Recipe {
  int id;
  String name;
  String photo;
  String desc;
  Recipe(
      {required this.id,
      required this.name,
      required this.photo,
      required this.desc});
}

  var recipes = <Recipe>[
  Recipe(
        id: 1,
        name: 'Sate Sapi Manis',
        photo:
            'https://assets.unileversolutions.com/recipes-v3/244819-default.png',
        desc:
            'Sate atau satay juga merupakan salah satu makanan khas Indonesia yang sangat populer di kancah internasional. Resep Sate Sapi Manis ini adalah salah satu variasi dari hidangan tradisional sate khas Indonesia yang gurih dan manis pada saat bersamaan.'),

    Recipe(
        id: 2,
        name: 'Semur Solo',
        photo:
            'https://assets.unileversolutions.com/recipes-v3/242463-default.jpg',
        desc:
            'Semur Solo rasanya mirip bistik dan sering juga disebut bistik ala Solo. Pilih daging sapi has dalam yang empuk dan teksturnya tidak berotot sehingga daging mudah empuk dan bumbu perendam mudah meresap cepat. Nikmati dengan sepiring selada Selat Solo dan emping goreng.'),

    Recipe(
        id: 3,
        name: 'Sengkel Asam Buncis',
        photo:
            'https://assets.unileversolutions.com/recipes-v3/242609-default.jpg',
        desc:
            'Sengkel atau bagian depan atas kaki sapi ini cocok digunakan sebagai bahan dasar sop. Apalagi ditambahkan potongan tomat hijau dan belimbing wuluh yang menyegarkan.'),
];