CREATE TABLE Proveedor(
    ID_Proveedor INT NOT NULL AUTO_INCREMENT,
    nombreCompleto VARCHAR(100) NOT NULL,
    telefono VARCHAR(10) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    correo VARCHAR(50) NOT NULL,
    empresa VARCHAR(50) NOT NULL,
    PRIMARY KEY (ID_Proveedor)
);

CREATE TABLE Departamento(
    ID_Departamento INT NOT NULL AUTO_INCREMENT,
    departamento VARCHAR(50) NOT NULL,
    PRIMARY KEY (ID_Departamento)
);

CREATE TABLE Municipio(
    ID_Municipio INT NOT NULL AUTO_INCREMENT,
    municipio VARCHAR(50) NOT NULL,
    ID_Departamento INT NOT NULL,
    PRIMARY KEY (ID_Municipio),
    FOREIGN KEY (ID_Departamento) REFERENCES Departamento(ID_Departamento)
);

CREATE TABLE Sucursal(
    ID_Sucursal INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    direccion VARCHAR(50) NOT NULL,
    telefono VARCHAR(10) NOT NULL,
    sitio VARCHAR(50) NOT NULL,
    ID_Municipio INT NOT NULL,
    PRIMARY KEY (ID_Sucursal),
    FOREIGN KEY (ID_Municipio) REFERENCES Municipio(ID_Municipio)
);

CREATE TABLE Vehiculo(
    placa VARCHAR(7) NOT NULL,
    color VARCHAR(20) NOT NULL,
    marca VARCHAR(20) NOT NULL,
    modelo VARCHAR(20) NOT NULL,
    kilometraje INT NOT NULL,
    anyo INT NOT NULL,
    transmision BOOLEAN NOT NULL,
    noPuerta INT NOT NULL,
    condicion BOOLEAN NOT NULL,
    disponibilidad BOOLEAN NOT NULL,
    ID_Proveedor INT NOT NULL,
    ID_Sucursal INT NOT NULL,
    PRIMARY KEY (placa),
    FOREIGN KEY (ID_Proveedor) REFERENCES Proveedor(ID_Proveedor),
    FOREIGN KEY (ID_Sucursal) REFERENCES Sucursal(ID_Sucursal)
);

CREATE TABLE Empleado(
    cui INT NOT NULL,
    nombreCompleto VARCHAR(100) NOT NULL,
    nit INT NOT NULL,
    telefono VARCHAR(10) NOT NULL,
    sueldo INT NOT NULL DEFAULT 2300,
    ID_Sucursal INT NOT NULL,
    PRIMARY KEY (cui),
    FOREIGN KEY (ID_Sucursal) REFERENCES Sucursal(ID_Sucursal)
);

CREATE TABLE Movimiento(
    ID_Movimiento INT NOT NULL AUTO_INCREMENT,
    sucursal VARCHAR(50) NOT NULL,
    inicio DATE NOT NULL,
    fin DATE,
    cui INT NOT NULL,
    PRIMARY KEY (ID_Movimiento),
    FOREIGN KEY (cui) REFERENCES Empleado(cui)
);

CREATE TABLE Cliente(
    cuiC INT NOT NULL,
    nit INT NOT NULL,
    nombreCompleto VARCHAR(100) NOT NULL,
    telefono VARCHAR(10) NOT NULL,
    correo VARCHAR(50) NOT NULL,
    direccion VARCHAR(100),
    telCasa VARCHAR(10),
    PRIMARY KEY (cuiC)
);

CREATE TABLE Tarjeta(
    noTarjeta INT NOT NULL,
    banco VARCHAR(50) NOT NULL,
    cuiC INT NOT NULL,
    PRIMARY KEY (noTarjeta),
    FOREIGN KEY (cuiC) REFERENCES Cliente(cuiC)
);

CREATE TABLE Descuento(
    ID_Descuento INT NOT NULL AUTO_INCREMENT,
    motivo TEXT NOT NULL,
    PRIMARY KEY (ID_Descuento)
);

CREATE TABLE Credito(
    ID_Credito INT NOT NULL AUTO_INCREMENT,
    banco VARCHAR(50) NOT NULL,
    noTarjeta INT NOT NULL,
    monto DECIMAL(10, 2) NOT NULL,
    fecha DATE NOT NULL,
    PRIMARY KEY (ID_Credito)
);

CREATE TABLE Contado(
    ID_Contado INT NOT NULL AUTO_INCREMENT,
    monto DECIMAL(10, 2) NOT NULL,
    fecha DATE NOT NULL,
    PRIMARY KEY (ID_Contado)
);

CREATE TABLE Transaccion(
    ID_Transaccion INT NOT NULL AUTO_INCREMENT,
    tipo BOOLEAN NOT NULL,
    ID_Contado INT,
    ID_Credito INT,
    ID_Descuento INT,
    cuiC INT,
    cui INT,
    ID_Sucursal INT NOT NULL,
    placa VARCHAR(7) NOT NULL,
    PRIMARY KEY (ID_Transaccion),
    FOREIGN KEY (ID_Contado) REFERENCES Contado(ID_Contado),
    FOREIGN KEY (ID_Credito) REFERENCES Credito(ID_Credito),
    FOREIGN KEY (ID_Descuento) REFERENCES Descuento(ID_Descuento),
    FOREIGN KEY (cuiC) REFERENCES Cliente(cuiC),
    FOREIGN KEY (cui) REFERENCES Empleado(cui),
    FOREIGN KEY (ID_Sucursal) REFERENCES Sucursal(ID_Sucursal),
    FOREIGN KEY (placa) REFERENCES Vehiculo(placa)
);