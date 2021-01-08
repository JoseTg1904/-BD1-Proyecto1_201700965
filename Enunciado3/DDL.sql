CREATE TABLE Denunciante(
    cui INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    edad INT NOT NULL,
    fechaNac DATE NOT NULL,
    lugarNacimiento VARCHAR(100) NOT NULL,
    lugarActual VARCHAR(100) NOT NULL,
    telefono VARCHAR(10) NOT NULL,
    PRIMARY KEY (cui)
);

CREATE TABLE SinReconocer(
    ID_SinReconocer INT NOT NULL AUTO_INCREMENT,
    adn VARCHAR(25) NOT NULL,
    altura INT NOT NULL,
    edad INT NOT NULL,
    ubicacion VARCHAR(100) NOT NULL,
    PRIMARY KEY (ID_SinReconocer)
);

CREATE TABLE Posesion(
    ID_Posesion INT NOT NULL AUTO_INCREMENT,
    titulo VARCHAR(25) NOT NULL, 
    descripcion TEXT NOT NULL,
    ID_SinReconocer INT NOT NULL,
    PRIMARY KEY (ID_Posesion),
    FOREIGN KEY (ID_SinReconocer) REFERENCES SinReconocer(ID_SinReconocer)
);

CREATE TABLE Desaparecido(
    ID_Desaparecido INT NOT NULL AUTO_INCREMENT,
    piel VARCHAR(25) NOT NULL,
    cabello VARCHAR(25) NOT NULL,
    profesion VARCHAR(50) NOT NULL,
    edad INT NOT NULL,
    altura INT NOT NULL,
    etnia VARCHAR(50) NOT NULL,
    ID_SinReconocer INT,
    PRIMARY KEY (ID_Desaparecido),
    FOREIGN KEY (ID_SinReconocer) REFERENCES SinReconocer(ID_SinReconocer)
);

CREATE TABLE Denuncia(
    ID_Denuncia INT NOT NULL AUTO_INCREMENT,
    fechaDen DATE NOT NULL,
    fechaDes DATE NOT NULL,
    adn VARCHAR(25) NOT NULL,
    cui INT NOT NULL,
    ID_Desaparecido INT NOT NULL,
    PRIMARY KEY (ID_Denuncia),
    FOREIGN KEY (cui) REFERENCES Denunciante(cui),
    FOREIGN KEY (ID_Desaparecido) REFERENCES Desaparecido(ID_Desaparecido)
);