-- Basic table profile
CREATE TABLE IF NOT EXISTS profile (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    display_name TEXT NOT NULL,
    username TEXT NOT NULL UNIQUE,
    profile_picture_path TEXT
);

-- Basic table chat (contains target profile)
CREATE TABLE IF NOT EXISTS chat (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    profile_id INTEGER NOT NULL,
    name TEXT NOT NULL,
    profile_picture_path TEXT,
    mqtt_server_link TEXT NOT NULL,
    crypto_key TEXT NOT NULL,
    FOREIGN KEY (profile_id) REFERENCES profile(id) ON DELETE CASCADE
);

-- Basic table message (stores various encrypted messages linked to sender and chat id)
CREATE TABLE IF NOT EXISTS message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    chat_id INTEGER NOT NULL,
    sender INTEGER NOT NULL,
    content TEXT NOT NULL,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (chat_id) REFERENCES chat (id) ON DELETE CASCADE,
    FOREIGN KEY (sender) REFERENCES profile(id) ON DELETE CASCADE
);


-- Insertion
INSERT INTO profile(display_name, username) VALUES ('Hayukitwo', 'hayukitwo');
INSERT INTO chat(profile_id, name, mqtt_server_link, crypto_key) VALUES (1, 'Hayukitwo Chat', 'redot/examplechatroom', 'temp_key');
INSERT INTO message(chat_id, sender, content) VALUES (1, 1, 'Hello, this is a test message.');