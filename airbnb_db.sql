-- =====================================================
-- SCRIPT: Creación y configuración de la base de datos airbnb_db
-- Autor: Juan Sebastian Ortiz 230202011
-- =====================================================

-- Crear el usuario se le asignan permisos
-- Verifica si el usuario ya existe antes de crearlo
BEGIN
   EXECUTE IMMEDIATE 'CREATE USER airbnb_db IDENTIFIED BY 12345678';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE = -01920 THEN
         DBMS_OUTPUT.PUT_LINE('Usuario airbnb_db ya existe, omitiendo creación.');
      ELSE
         RAISE;
      END IF;
END;
/

-- Se le dan permisos básicos al usuario
GRANT CONNECT, RESOURCE TO airbnb_db;
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE SEQUENCE, CREATE SYNONYM TO airbnb_db;

-- =====================================================
-- Cambio al esquema de airbnb_db
-- =====================================================
ALTER SESSION SET CURRENT_SCHEMA = airbnb_db;

-- =====================================================
-- Creación de Tablas (Sin claves foráneas)
-- =====================================================

-- Tabla Usuario (User)
CREATE TABLE User (
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
ALTER TABLE Place ADD CONSTRAINT fk_place_user FOREIGN KEY (user_id) REFERENCES User(id);
ALTER TABLE Place ADD CONSTRAINT fk_place_city FOREIGN KEY (city_id) REFERENCES City(id);
ALTER TABLE City ADD CONSTRAINT fk_city_state FOREIGN KEY (state_id) REFERENCES State(id);
ALTER TABLE Review ADD CONSTRAINT fk_review_user FOREIGN KEY (user_id) REFERENCES User(id);
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
-- Fin del Script
-- =====================================================
PROMPT Base de datos y tablas creadas exitosamente.


=======
-- =====================================================
-- SCRIPT: Creación y configuración de la base de datos AIRBNB_DB
-- Autor: Juan Sebastian Ortiz 230202011
-- =====================================================

-- Crear el usuario se le asignan permisos
-- Verifica si el usuario ya existe antes de crearlo
BEGIN
   EXECUTE IMMEDIATE 'CREATE USER AIRBNB_DB IDENTIFIED BY 12345678';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE = -01920 THEN
         DBMS_OUTPUT.PUT_LINE('Usuario AIRBNB_DB ya existe, omitiendo creación.');
      ELSE
         RAISE;
      END IF;
END;
/

-- Se le dan permisos básicos al usuario
GRANT CONNECT, RESOURCE TO AIRBNB_DB;
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE SEQUENCE, CREATE SYNONYM TO AIRBNB_DB;

-- =====================================================
-- Cambio al esquema de AIRBNB_DB
-- =====================================================
ALTER SESSION SET CURRENT_SCHEMA = AIRBNB_DB;

-- =====================================================
-- Creación de Tablas (Sin claves foráneas)
-- =====================================================

-- Tabla Usuario (User)
CREATE TABLE User (
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
ALTER TABLE Place ADD CONSTRAINT fk_place_user FOREIGN KEY (user_id) REFERENCES User(id);
ALTER TABLE Place ADD CONSTRAINT fk_place_city FOREIGN KEY (city_id) REFERENCES City(id);
ALTER TABLE City ADD CONSTRAINT fk_city_state FOREIGN KEY (state_id) REFERENCES State(id);
ALTER TABLE Review ADD CONSTRAINT fk_review_user FOREIGN KEY (user_id) REFERENCES User(id);
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
-- Fin del Script
-- =====================================================
PROMPT Base de datos y tablas creadas exitosamente.


