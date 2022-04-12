DROP TABLE IF EXISTS art;
DROP TABLE IF EXISTS collector;
DROP TABLE IF EXISTS artist;
DROP TABLE IF EXISTS collection;
DROP TABLE IF EXISTS club;
DROP TABLE IF EXISTS memberOf;
DROP TABLE IF EXISTS partOf;
CREATE TABLE collector(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    name TEXT
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
    collection TEXT,
    FOREIGN KEY(user_id) REFERENCES collector(id)
);
CREATE TABLE artist(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    FOREIGN KEY(name) REFERENCES art(artist)
);
CREATE TABLE club(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    FOREIGN KEY(name) REFERENCES art(collection)
);
CREATE TABLE memberOf(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    club_id INTEGER NOT NULL,
    FOREIGN KEY(user_id) REFERENCES collector(id),
    FOREIGN KEY(club_id) REFERENCES club(id)
);
CREATE TABLE partOf(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    art_id INTEGER NOT NULL,
    collection_id INTEGER NOT NULL,
    FOREIGN KEY(art_id) REFERENCES art(id),
    FOREIGN KEY(collection_id) REFERENCES collection(id)
);
INSERT INTO collector(username, password, name)
VALUES('admin', 'admin', 'admin');
INSERT INTO collector(username, password, name)
VALUES('user', 'user', 'user');
INSERT INTO collection(name, user_id)
VALUES('Modern', 1);
INSERT INTO collection(name, user_id)
VALUES('Art Deco', 1);
INSERT INTO collection(name, user_id)
VALUES('Impressionism', 1);
INSERT INTO collection(name, user_id)
VALUES('Fauvism', 1);
INSERT INTO art(
        name,
        artist,
        year,
        user_id,
        collection
    )
VALUES (
        'The Scream',
        'Edvard Munch',
        '1893',
        1,
        'Impressionism'
    );
INSERT INTO art(
        name,
        artist,
        year,
        user_id,
        collection
    )
VALUES (
        'The Artist''s Garden',
        'Claude Monet',
        '1900',
        2,
        'Impressionism'
    );
INSERT INTO art(
        name,
        artist,
        year,
        user_id,
        collection
    )
VALUES (
        'Luncheon of the Boating Party',
        'Pierre-Auguste Renoir',
        1881,
        1,
        'Impressionism'
    );
INSERT INTO art(
        name,
        artist,
        year,
        user_id,
        collection
    )
VALUES (
        'La Bonheur de Vivre',
        'Henri Matisse',
        '1893',
        1,
        'Fauvism'
    );
INSERT INTO art(
        name,
        artist,
        year,
        user_id,
        collection
    )
VALUES (
        'The Starry Night',
        'Vincent van Gogh',
        '1889',
        1,
        'Modern'
    );
INSERT INTO art(
        name,
        artist,
        year,
        user_id,
        collection
    )
VALUES ('Guernica', 'Pablo Picasso', '1937', 1, 'Modern');
INSERT INTO art(
        name,
        artist,
        year,
        user_id,
        collection
    )
VALUES (
        'Campbell''s Soup Cans',
        'Andy Warhol',
        '1961',
        1,
        'Modern'
    );
INSERT INTO art(
        name,
        artist,
        year,
        user_id,
        collection
    )
VALUES (
        'The Persistence of Memory',
        'Salvador Dali',
        '1952',
        1,
        'Modern'
    );
INSERT INTO art(
        name,
        artist,
        year,
        user_id,
        collection
    )
VALUES (
        'Violin and Palette',
        'Georges Braques',
        '1950',
        1,
        'Modern'
    );
INSERT INTO art(
        name,
        artist,
        year,
        user_id,
        collection
    )
VALUES (
        'Nude with Cala Lillies',
        'Diego Rivera',
        '1952',
        1,
        'Art Deco'
    );
INSERT INTO art(
        name,
        artist,
        year,
        user_id,
        collection
    )
VALUES (
        'Mona Lisa',
        'Leonardo da Vinci',
        '1503',
        1,
        'Renaissance'
    );
INSERT INTO art(
        name,
        artist,
        year,
        user_id,
        collection
    )
VALUES (
        'The Kiss',
        'Edvard Munch',
        '1893',
        1,
        "Impressionism"
    );
INSERT INTO art(
        name,
        artist,
        year,
        user_id,
        collection
    )
VALUES (
        'The Last Supper',
        'Leonardo Da Vinci',
        '1498',
        1,
        'Renaissance'
    );
INSERT INTO club(name)
SELECT name
FROM collection;
INSERT INTO memberOf(user_id, club_id)
SELECT col.id,
    club.id
FROM collector col,
    club club;
INSERT INTO partOf(art_id, collection_id)
SELECT id,
    collection
FROM art;
INSERT INTO artist(name)
SELECT artist
FROM art
GROUP BY artist;