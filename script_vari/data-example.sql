/*
 * Righe di sql di esempio importate nei database dei microservizi. L'alter table nella seconda riga è dovuta a 
 * un problema di chiavi nell'applicazione sviluppata.
 * Vi sono prevalentemente insert into per popolare i db.
*/
--inserimento di un utente admin
insert into user (email, name, password, registration_date, role, surname) values ('prova@prova.com', 'prova', '$2y$10$DFkcq/YOMCBGwcLS7eRm2uPoe2qI4ntoKzMaf0YIypGH9bMCZQ4XC', '1000-01-01 00:00:00', 3, 'prova');
--alter table per droppare l'index che dava errore
ALTER TABLE allowed_types DROP INDEX UK_kpjmvfusqoorsltcd7w6wb4qv;
--tabella template
INSERT INTO `template` (template_id, name, min_questions, max_questions, min_question_time, max_question_time, min_question_score, max_question_score, threshold, last_update)
VALUES
(1,'Template sviluppo backend (junior)',10,12,300,900,5,10,55,'2022-11-22 16:23:09'),
(2,'Template sviluppo backend (middle)',12,15,200,900,2,10,60,'2022-11-22 16:33:47'),
(3,'Template sviluppo backend (senior)',15,20,60,1000,1,20,70,'2022-11-22 16:25:49'),
(5,'Template sicurezza (junior)',10,12,300,900,5,10,55,'2022-11-22 16:37:00'),
(6,'Template sicurezza (middle)',12,15,200,900,12,10,60,'2022-11-22 16:38:20'),
(7,'Template sicurezza (senior)',15,20,60,1000,1,20,70,'2022-11-22 17:26:38'),
(15,'Template Demo',12,15,120,600,1,10,60,'2023-01-26 18:29:22');

--tabella completes
INSERT INTO `completes` (completes_id, quiz_id, date, note, step) VALUES
(1,1,'2022-12-19 17:16:51','Nota per la fase di bozza',0),
(2,1,'2022-12-19 18:07:37','Il quiz va bene, confermo',1),
(3,1,'2022-12-19 18:07:55','Attivo il quiz per Mario Rossi',2),
(4,1,'2022-12-19 18:09:41','Quiz consegnato dall\' utente',3),
(6,1,'2023-01-02 16:19:41','Il quiz è stato valutato',4);

--tabella topic
INSERT INTO `topic` (topic_id, name) VALUES (1,'Sviluppo cloud'),
(2,'Sicurezza informatica'),(3,'Algoritmi e strutture dati'),
(4,'Intelligenza artificiale'),(5,'Basi di dati'),(7,'Metodologia DevOps'),
(9,'Matematica');
