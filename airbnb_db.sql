-- =====================================================
-- SCRIPT: Creación y configuración de la base de datos AIRBNB_DB
-- Autor: Juan Sebastian Ortiz 230202011
-- =====================================================

-- Verificar si el usuario AIRBNB_DB existe antes de crearlo
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM all_users WHERE username = 'AIRBNB_DB';
    IF v_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE USER AIRBNB_DB IDENTIFIED BY 12345678';
        DBMS_OUTPUT.PUT_LINE('Usuario AIRBNB_DB creado exitosamente.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Usuario AIRBNB_DB ya existe, omitiendo creación.');
    END IF;
END;
/

-- Se le dan permisos básicos al usuario
GRANT CONNECT, RESOURCE TO AIRBNB_DB;
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE SEQUENCE, CREATE SYNONYM TO AIRBNB_DB;
ALTER USER AIRBNB_DB QUOTA UNLIMITED ON USERS;


-- =====================================================
-- Cambio al esquema de AIRBNB_DB
-- =====================================================
ALTER SESSION SET CURRENT_SCHEMA = AIRBNB_DB;

-- =====================================================
-- Verificar y eliminar tablas si existen
-- =====================================================

DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM all_tables WHERE table_name = 'PLACEAMENITY' AND owner = 'AIRBNB_DB';
    IF v_count > 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE PlaceAmenity CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Tabla PlaceAmenity eliminada.');
    END IF;
END;
/

DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM all_tables WHERE table_name = 'AMENITY' AND owner = 'AIRBNB_DB';
    IF v_count > 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE Amenity CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Tabla Amenity eliminada.');
    END IF;
END;
/

DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM all_tables WHERE table_name = 'REVIEW' AND owner = 'AIRBNB_DB';
    IF v_count > 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE Review CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Tabla Review eliminada.');
    END IF;
END;
/

DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM all_tables WHERE table_name = 'STATE' AND owner = 'AIRBNB_DB';
    IF v_count > 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE State CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Tabla State eliminada.');
    END IF;
END;
/

DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM all_tables WHERE table_name = 'CITY' AND owner = 'AIRBNB_DB';
    IF v_count > 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE City CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Tabla City eliminada.');
    END IF;
END;
/

DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM all_tables WHERE table_name = 'PLACE' AND owner = 'AIRBNB_DB';
    IF v_count > 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE Place CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Tabla Place eliminada.');
    END IF;
END;
/

DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM all_tables WHERE table_name = 'USERS' AND owner = 'AIRBNB_DB';
    IF v_count > 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE Users CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Tabla Users eliminada.');
    END IF;
END;
/

-- =====================================================
-- Verificar y eliminar secuencias si existen
-- =====================================================

DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM all_sequences WHERE sequence_name = 'USER_SEQ' AND sequence_owner = 'AIRBNB_DB';
    IF v_count > 0 THEN
        EXECUTE IMMEDIATE 'DROP SEQUENCE user_seq';
        DBMS_OUTPUT.PUT_LINE('Secuencia user_seq eliminada.');
    END IF;
END;
/

DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM all_sequences WHERE sequence_name = 'PLACE_SEQ' AND sequence_owner = 'AIRBNB_DB';
    IF v_count > 0 THEN
        EXECUTE IMMEDIATE 'DROP SEQUENCE place_seq';
        DBMS_OUTPUT.PUT_LINE('Secuencia place_seq eliminada.');
    END IF;
END;
/

DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM all_sequences WHERE sequence_name = 'CITY_SEQ' AND sequence_owner = 'AIRBNB_DB';
    IF v_count > 0 THEN
        EXECUTE IMMEDIATE 'DROP SEQUENCE city_seq';
        DBMS_OUTPUT.PUT_LINE('Secuencia city_seq eliminada.');
    END IF;
END;
/

DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM all_sequences WHERE sequence_name = 'STATE_SEQ' AND sequence_owner = 'AIRBNB_DB';
    IF v_count > 0 THEN
        EXECUTE IMMEDIATE 'DROP SEQUENCE state_seq';
        DBMS_OUTPUT.PUT_LINE('Secuencia state_seq eliminada.');
    END IF;
END;
/

DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM all_sequences WHERE sequence_name = 'REVIEW_SEQ' AND sequence_owner = 'AIRBNB_DB';
    IF v_count > 0 THEN
        EXECUTE IMMEDIATE 'DROP SEQUENCE review_seq';
        DBMS_OUTPUT.PUT_LINE('Secuencia review_seq eliminada.');
    END IF;
END;
/

DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM all_sequences WHERE sequence_name = 'AMENITY_SEQ' AND sequence_owner = 'AIRBNB_DB';
    IF v_count > 0 THEN
        EXECUTE IMMEDIATE 'DROP SEQUENCE amenity_seq';
        DBMS_OUTPUT.PUT_LINE('Secuencia amenity_seq eliminada.');
    END IF;
END;
/

-- =====================================================
-- Creación de Tablas (Sin claves foráneas)
-- =====================================================

-- Tabla Usuario (Users)
CREATE TABLE Users (
    id VARCHAR2(50) PRIMARY KEY,
    updated_at DATE,
    created_at DATE,
    email VARCHAR2(100) UNIQUE NOT NULL,
    password VARCHAR2(100) NOT NULL,
    first_name VARCHAR2(50), -- Nombre del usuario
    last_name VARCHAR2(50) -- Apellido del usuario
);

-- Tabla Lugar (Place)
CREATE TABLE Place (
    id VARCHAR2(50) PRIMARY KEY,
    updated_at DATE,
    created_at DATE,
    user_id VARCHAR2(50),
    city_id VARCHAR2(50),
    name VARCHAR2(100) NOT NULL, -- Nombre del lugar
    description VARCHAR2(255), -- Descripción del lugar
    number_rooms INTEGER DEFAULT 0, -- Número de habitaciones
    number_bathrooms INTEGER DEFAULT 0, -- Número de baños
    max_guest INTEGER DEFAULT 0, -- Máximo de huéspedes permitidos
    price_by_night INTEGER, -- Precio por noche
    latitude FLOAT, -- Latitud del lugar
    longitude FLOAT -- Longitud del lugar
);

-- Tabla Ciudad (City)
CREATE TABLE City (
    id VARCHAR2(50) PRIMARY KEY,
    updated_at DATE,
    created_at DATE,
    state_id VARCHAR2(50),
    name VARCHAR2(100) NOT NULL -- Nombre de la ciudad
);

-- Tabla Estado (State)
CREATE TABLE State (
    id VARCHAR2(50) PRIMARY KEY,
    updated_at DATE,
    created_at DATE,
    name VARCHAR2(100) NOT NULL -- Nombre del estado o región
);

-- Tabla Reseña (Review)
CREATE TABLE Review (
    id VARCHAR2(50) PRIMARY KEY,
    updated_at DATE,
    created_at DATE,
    user_id VARCHAR2(50),
    place_id VARCHAR2(50),
    text VARCHAR2(255) NOT NULL -- Texto de la reseña
);

-- Tabla Amenidad (Amenity)
CREATE TABLE Amenity (
    id VARCHAR2(50) PRIMARY KEY,
    updated_at DATE,
    created_at DATE,
    name VARCHAR2(100) NOT NULL -- Nombre de la amenidad (ejemplo: WiFi, Piscina, etc.)
);

-- Tabla Relación Lugar-Amenidad (PlaceAmenity)
CREATE TABLE PlaceAmenity (
    amenity_id VARCHAR2(50),
    place_id VARCHAR2(50),
    PRIMARY KEY (amenity_id, place_id)
);

-- =====================================================
-- Creación de Secuencias para IDs
-- =====================================================

CREATE SEQUENCE user_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE place_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE city_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE state_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE review_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE amenity_seq START WITH 1 INCREMENT BY 1;

-- =====================================================
-- Agregar restricciones con ALTER TABLE
-- =====================================================

-- Relaciones de clave foránea
ALTER TABLE Place ADD CONSTRAINT fk_place_user FOREIGN KEY (user_id) REFERENCES Users(id);
ALTER TABLE Place ADD CONSTRAINT fk_place_city FOREIGN KEY (city_id) REFERENCES City(id);
ALTER TABLE City ADD CONSTRAINT fk_city_state FOREIGN KEY (state_id) REFERENCES State(id);
ALTER TABLE Review ADD CONSTRAINT fk_review_user FOREIGN KEY (user_id) REFERENCES Users(id);
ALTER TABLE Review ADD CONSTRAINT fk_review_place FOREIGN KEY (place_id) REFERENCES Place(id);
ALTER TABLE PlaceAmenity ADD CONSTRAINT fk_placeamenity_amenity FOREIGN KEY (amenity_id) REFERENCES Amenity(id);
ALTER TABLE PlaceAmenity ADD CONSTRAINT fk_placeamenity_place FOREIGN KEY (place_id) REFERENCES Place(id);

-- =====================================================
-- Creación de Índices para Optimización
-- =====================================================

CREATE INDEX idx_place_user ON Place(user_id);
CREATE INDEX idx_place_city ON Place(city_id);
CREATE INDEX idx_city_state ON City(state_id);
CREATE INDEX idx_review_user ON Review(user_id);
CREATE INDEX idx_review_place ON Review(place_id);
CREATE INDEX idx_placeamenity_amenity ON PlaceAmenity(amenity_id);
CREATE INDEX idx_placeamenity_place ON PlaceAmenity(place_id);


-- =====================================================
-- Insertar datos en la tabla State
-- =====================================================
INSERT INTO State (id, updated_at, created_at, name) VALUES ('S1', SYSDATE, SYSDATE, 'Antioquia');
INSERT INTO State (id, updated_at, created_at, name) VALUES ('S2', SYSDATE, SYSDATE, 'Cundinamarca');

-- =====================================================
-- Insertar datos en la tabla City
-- =====================================================
INSERT INTO City (id, updated_at, created_at, state_id, name) VALUES ('C1', SYSDATE, SYSDATE, 'S1', 'Medellín');
INSERT INTO City (id, updated_at, created_at, state_id, name) VALUES ('C2', SYSDATE, SYSDATE, 'S2', 'Bogotá');

-- =====================================================
-- Insertar datos en la tabla Users
-- =====================================================
INSERT INTO Users (id, updated_at, created_at, email, password, first_name, last_name) 
VALUES ('U1', SYSDATE, SYSDATE, 'user1@example.com', 'pass123', 'Juan', 'Pérez');

INSERT INTO Users (id, updated_at, created_at, email, password, first_name, last_name) 
VALUES ('U2', SYSDATE, SYSDATE, 'user2@example.com', 'pass456', 'Maria', 'González');

-- =====================================================
-- Insertar datos en la tabla Place
-- =====================================================
INSERT INTO Place (id, updated_at, created_at, user_id, city_id, name, description, number_rooms, number_bathrooms, max_guest, price_by_night, latitude, longitude)
VALUES ('P1', SYSDATE, SYSDATE, 'U1', 'C1', 'Apartamento Medellín', 'Un lugar acogedor', 2, 1, 4, 100000, 6.2442, -75.5812);

INSERT INTO Place (id, updated_at, created_at, user_id, city_id, name, description, number_rooms, number_bathrooms, max_guest, price_by_night, latitude, longitude)
VALUES ('P2', SYSDATE, SYSDATE, 'U2', 'C2', 'Casa en Bogotá', 'Hermosa casa en la capital', 3, 2, 6, 200000, 4.7110, -74.0721);

-- =====================================================
-- Insertar datos en la tabla Review
-- =====================================================
INSERT INTO Review (id, updated_at, created_at, user_id, place_id, text) 
VALUES ('R1', SYSDATE, SYSDATE, 'U2', 'P1', 'Gran lugar, muy limpio y bien ubicado.');

INSERT INTO Review (id, updated_at, created_at, user_id, place_id, text) 
VALUES ('R2', SYSDATE, SYSDATE, 'U1', 'P2', 'Hermosa casa, volveré sin duda.');

-- =====================================================
-- Insertar datos en la tabla Amenity
-- =====================================================
INSERT INTO Amenity (id, updated_at, created_at, name) 
VALUES ('A1', SYSDATE, SYSDATE, 'WiFi');

INSERT INTO Amenity (id, updated_at, created_at, name) 
VALUES ('A2', SYSDATE, SYSDATE, 'Piscina');

-- =====================================================
-- Insertar datos en la tabla PlaceAmenity
-- =====================================================
INSERT INTO PlaceAmenity (amenity_id, place_id) VALUES ('A1', 'P1');
INSERT INTO PlaceAmenity (amenity_id, place_id) VALUES ('A2', 'P2');

-- =====================================================
-- Confirmación de Inserciones
-- =====================================================
COMMIT;

-- =====================================================
-- Fin del Script
-- =====================================================
PROMPT Base de datos y tablas creadas exitosamente.