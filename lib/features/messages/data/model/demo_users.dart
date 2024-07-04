import 'package:flutter/material.dart';

const users = [
  userGordon,
  userSalvatore,
  userSacha,
  userDeven,
  userSahil,
  userReuben,
  userNash,
];

const userGordon = DemoUser(
  id: 'gordon',
  name: 'Gordon Hayes',
  image: 'https://i.pravatar.cc/150?img=1',
);

const userSalvatore = DemoUser(
  id: 'salvatore',
  name: 'Salvatore Giordano',
  image: 'https://i.pravatar.cc/150?img=2',
);

const userSacha = DemoUser(
  id: 'sacha',
  name: 'Sacha Arbonel',
  image: 'https://i.pravatar.cc/150?img=3',
);

const userDeven = DemoUser(
  id: 'deven',
  name: 'Deven Joshi',
  image: 'https://i.pravatar.cc/150?img=4',
);

const userSahil = DemoUser(
  id: 'sahil',
  name: 'Sahil Kumar',
  image: 'https://i.pravatar.cc/150?img=5',
);

const userReuben = DemoUser(
  id: 'reuben',
  name: 'Reuben Turner',
  image: 'https://i.pravatar.cc/150?img=6',
);

const userNash = DemoUser(
  id: 'nash',
  name: 'Nash Ramdial',
  image: 'https://i.pravatar.cc/150?img=7',
);

@immutable
class DemoUser {
  final String id;
  final String name;
  final String image;

  const DemoUser({
    required this.id,
    required this.name,
    required this.image,
  });
}
