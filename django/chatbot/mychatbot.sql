SHOW DATABASES;
CREATE DATABASE mychatbot;
USE mychatbot;
DROP TABLE chatbot_train_data;
CREATE TABLE chatbot_train_data (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
intent VARCHAR(45),
ner VARCHAR(45),
query TEXT,
answer TEXT NOT NULL,
answer_image VARCHAR(2048)
);
SELECT * FROM chatbot_train_data;