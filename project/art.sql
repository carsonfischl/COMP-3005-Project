DROP TABLE IF EXISTS art;
DROP TABLE IF EXISTS collector;
DROP TABLE IF EXISTS artist;
DROP TABLE IF EXISTS collection;
CREATE TABLE collector(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    name TEXT,
    number_of_pieces INTEGER
);
CREATE TABLE collection(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    name TEXT NOT NULL,
    genre TEXT,
    FOREIGN KEY(user_id) REFERENCES collector(id)
);
CREATE TABLE art(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    artist TEXT NOT NULL,
    year INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    collection_id INTEGER NOT NULL,
    image TEXT,
    price INTEGER,
    location TEXT,
    FOREIGN KEY(user_id) REFERENCES collector(id),
    FOREIGN KEY(collection_id) REFERENCES collection(id)
);
CREATE TABLE artist(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    FOREIGN KEY(name) REFERENCES art(artist)
);
INSERT INTO collection(user_id, name, genre)
VALUES(1, 'Modern', 'Modern');
INSERT INTO collection(user_id, name, genre)
VALUES(1, 'Abstract', 'Abstract');
INSERT INTO collection(user_id, name, genre)
VALUES(1, 'Pop', 'Pop');
INSERT INTO art(
        name,
        artist,
        year,
        user_id,
        collection_id,
        image,
        price,
        location
    )
VALUES(
        'The Scream',
        'Edvard Munch',
        '1893',
        1,
        1,
        'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/The_Scream_%28Edvard_Munch%29.jpg/220px-The_Scream_%28Edvard_Munch%29.jpg',
        '$100',
        'Museum'
    );
INSERT INTO art(
        name,
        artist,
        year,
        user_id,
        collection_id,
        image,
        price,
        location
    )
VALUES(
        'The Starry Night',
        'Vincent van Gogh',
        '1889',
        1,
        1,
        'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e6/Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg/220px-Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg',
        '$100',
        'Museum'
    );
INSERT INTO art(
        name,
        artist,
        year,
        user_id,
        collection_id,
        image,
        price,
        location
    )
VALUES(
        'Au Lapin Agile',
        'Pablo Picasso',
        '1905',
        1,
        3,
        'https://upload.wikimedia.org/wikipedia/en/thumb/8/8d/Pablo_Picasso%2C_1905%2C_Au_Lapin_Agile_%28At_the_Lapin_Agile%29%2C_oil_on_canvas%2C_99.1_x_100.3_cm%2C_Metropolitan_Museum_of_Art.jpg/1024px-Pablo_Picasso%2C_1905%2C_Au_Lapin_Agile_%28At_the_Lapin_Agile%29%2C_oil_on_canvas%2C_99.1_x_100.3_cm%2C_Metropolitan_Museum_of_Art.jpg',
        '$100',
        'Museum'
    );