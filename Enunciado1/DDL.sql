CREATE TABLE Area(
    ID_Area INT NOT NULL AUTO_INCREMENT,
    tituloArea VARCHAR(50) NOT NULL,
    PRIMARY KEY (ID_Area)
) TYPE = INNODB;

CREATE TABLE Cliente(
    ID_Cliente INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    cui INT NOT NULL,
    fechaNac DATE NOT NULL,
    telefono VARCHAR(10) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    PRIMARY KEY (ID_Cliente)
) TYPE = INNODB;

CREATE TABLE Departamento(
    ID_Departamento INT NOT NULL AUTO_INCREMENT,
    tituloDepa VARCHAR(50) NOT NULL,
    ID_Area INT NOT NULL,
    PRIMARY KEY (ID_Departamento),
    FOREIGN KEY (ID_Area) REFERENCES Area(ID_Area) 
) TYPE = INNODB;

CREATE TABLE Funcion(
    ID_Funcion INT NOT NULL AUTO_INCREMENT,
    titulo VARCHAR(50) NOT NULL,
    contenido VARCHAR(50) NOT NULL,
    ID_Departamento INT NOT NULL,
    PRIMARY KEY (ID_Funcion),
    FOREIGN KEY (ID_Departamento) REFERENCES Departamento(ID_Departamento)
) TYPE = INNODB;

CREATE TABLE TipoPuesto(
    ID_TipoPuesto INT NOT NULL AUTO_INCREMENT,
    tipoPuesto VARCHAR(20) NOT NULL,
    PRIMARY KEY (ID_TipoPuesto)
) TYPE = INNODB;

CREATE TABLE Empleado(
    ID_Empleado INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    cui INT NOT NULL,
    fechaNac DATE NOT NULL,
    fechaInicio DATE NOT NULL,
    edad INT NOT NULL,
    telefono VARCHAR(10) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    salario DECIMAL(8, 2) NOT NULL,
    ID_TipoPuesto INT NOT NULL,
    ID_Departamento INT NOT NULL,
    PRIMARY KEY (ID_Empleado),
    FOREIGN KEY (ID_TipoPuesto) REFERENCES TipoPuesto(ID_TipoPuesto),
    FOREIGN KEY (ID_Departamento) REFERENCES Departamento(ID_Departamento)
) TYPE = INNODB;

CREATE TABLE TipoSeguro(
    ID_TipoSeguro INT NOT NULL AUTO_INCREMENT,
    tipoSeguro VARCHAR(20) NOT NULL,
    PRIMARY KEY (ID_TipoSeguro)
) TYPE = INNODB;

CREATE TABLE HistorialLlamada(
    ID_HistorialLlamada INT NOT NULL AUTO_INCREMENT,
    nombreCandidato VARCHAR(100) NOT NULL,
    telefonoCandidato VARCHAR(10) NOT NULL,
    fechaYHora DATETIME NOT NULL,
    duracion TIME NOT NULL,
    ID_TipoSeguro INT NOT NULL,
    ID_Empleado INT NOT NULL,
    PRIMARY KEY (ID_HistorialLlamada),
    FOREIGN KEY (ID_TipoSeguro) REFERENCES TipoSeguro(ID_TipoSeguro),
    FOREIGN KEY (ID_Empleado) REFERENCES Empleado(ID_Empleado)
) TYPE = INNODB; 

CREATE TABLE TiempoPago(
    ID_TiempoPago INT NOT NULL AUTO_INCREMENT,
    tiempoPago VARCHAR(20) NOT NULL,
    PRIMARY KEY (ID_TiempoPago)
) TYPE = INNODB;

CREATE TABLE Seguro(
    ID_Seguro INT NOT NULL AUTO_INCREMENT,
    fechaInicio DATE NOT NULL,
    fechaFin DATE NOT NULL,
    monto DECIMAL(10, 2) NOT NULL,
    ID_Empleado INT NOT NULL,
    ID_TipoSeguro INT NOT NULL,
    ID_TiempoPago INT NOT NULL,
    ID_Cliente INT NOT NULL,
    PRIMARY KEY (ID_Seguro),
    FOREIGN KEY (ID_Empleado) REFERENCES Empleado(ID_Empleado),
    FOREIGN KEY (ID_TipoSeguro) REFERENCES TipoSeguro(ID_TipoSeguro),
    FOREIGN KEY (ID_TiempoPago) REFERENCES TiempoPago(ID_TiempoPago),
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente)
) TYPE = INNODB;

ALTER TABLE Seguro AUTO_INCREMENT = 10000;

CREATE TABLE FormaPago(
    ID_FormaPago INT NOT NULL AUTO_INCREMENT,
    formaPago VARCHAR(20) NOT NULL,
    PRIMARY KEY (ID_FormaPago)
) TYPE = INNODB;

CREATE TABLE Pago(
    ID_Pago INT NOT NULL AUTO_INCREMENT,
    monto DECIMAL(8, 2) NOT NULL,
    mora DECIMAL(8, 2),
    fechaPago DATE NOT NULL,
    ID_Empleado INT NOT NULL,
    ID_FormaPago INT NOT NULL,
    ID_Seguro INT NOT NULL,
    PRIMARY KEY (ID_Pago),
    FOREIGN KEY (ID_Empleado) REFERENCES Empleado(ID_Empleado),
    FOREIGN KEY (ID_FormaPago) REFERENCES FormaPago(ID_FormaPago),
    FOREIGN KEY (ID_Seguro) REFERENCES Seguro(ID_Seguro)
) TYPE = INNODB;