CREATE TABLE Bodega(
    noBodega INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    ubicacion VARCHAR(50) NOT NULL,
    PRIMARY KEY (noBodega)
);

CREATE TABLE Parte(
    codigo INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    color VARCHAR(50) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    ID_Padre INT,
    PRIMARY KEY (codigo),
    FOREIGN KEY (ID_Padre) REFERENCES Parte(codigo)
);

CREATE TABLE Proveedor(
    ID_Proveedor INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    telefono VARCHAR(25) NOT NULL,
    empresa VARCHAR(50) NOT NULL,
    pais VARCHAR(25) NOT NULL,
    PRIMARY KEY (ID_Proveedor)
);

CREATE TABLE Factura(
    ID_Factura INT NOT NULL,
    fecha DATETIME NOT NULL,
    ID_Proveedor INT NOT NULL,
    PRIMARY KEY (ID_Factura),
    FOREIGN KEY (ID_Proveedor) REFERENCES Proveedor(ID_Proveedor) 
);

CREATE TABLE Adquisicion(
    ID_Factura INT NOT NULL,
    ID_Proveedor INT NOT NULL,
    codigo INT NOT NULL,
    PRIMARY KEY (ID_Proveedor, codigo),
    FOREIGN KEY (ID_Factura) REFERENCES Factura(ID_Factura),
    FOREIGN KEY (ID_Proveedor) REFERENCES Proveedor(ID_Proveedor),
    FOREIGN KEY (codigo) REFERENCES Parte(codigo)
);

CREATE TABLE Etapa(
    ID_Etapa INT NOT NULL AUTO_INCREMENT,
    costo DECIMAL(10, 2) NOT NULL,
    etapa VARCHAR(20) NOT NULL,
    codigo INT NOT NULL,
    PRIMARY KEY (ID_Etapa),
    FOREIGN KEY (codigo) REFERENCES Parte(codigo)
);

CREATE TABLE NoTerminado(
    ID_NoTerminado INT NOT NULL AUTO_INCREMENT,
    ID_Etapa INT NOT NULL,
    PRIMARY KEY (ID_NoTerminado),
    FOREIGN KEY (ID_Etapa) REFERENCES Etapa(ID_Etapa)
);

CREATE TABLE Empleado(
    codigoEm INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    telefono VARCHAR(10) NOT NULL,
    correo VARCHAR(50) NOT NULL,
    ID_Superior INT,
    PRIMARY KEY (codigoEm),
    FOREIGN KEY (ID_Superior) REFERENCES Empleado(codigoEm)
);

CREATE TABLE LineaEnsamblaje(
    ID_LineaEnsamblaje INT NOT NULL AUTO_INCREMENT,
    tipo VARCHAR(50) NOT NULL,
    codigoEm INT NOT NULL,
    PRIMARY KEY (ID_LineaEnsamblaje),
    FOREIGN KEY (codigoEm) REFERENCES Empleado(codigoEm)
);

CREATE TABLE Puesto(
    ID_Puesto INT NOT NULL AUTO_INCREMENT,
    ID_LineaEnsamblaje INT NOT NULL,
    PRIMARY KEY (ID_Puesto),
    FOREIGN KEY (ID_LineaEnsamblaje) REFERENCES LineaEnsamblaje(ID_LineaEnsamblaje)
);

CREATE TABLE AsginacionPuesto(
    ID_Puesto INT NOT NULL,
    codigoEm INT NOT NULL,
    PRIMARY KEY (ID_Puesto, codigoEm),
    FOREIGN KEY (ID_Puesto) REFERENCES Puesto(ID_Puesto),
    FOREIGN KEY (codigoEm) REFERENCES Empleado(codigoEm)
);

CREATE TABLE Control(
    ID_Control INT NOT NULL AUTO_INCREMENT,
    inicio DATETIME NOT NULL,
    fin DATETIME,
    ID_Puesto INT,
    codigoEm INT NOT NULL,
    PRIMARY KEY (ID_Control),
    FOREIGN KEY (ID_Puesto) REFERENCES Puesto(ID_Puesto),
    FOREIGN KEY (codigoEm) REFERENCES Empleado(codigoEm)
);

CREATE TABLE Terminado(
    codigoTer INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    finalizacion DATETIME NOT NULL,
    costo DECIMAL(10, 2) NOT NULL,
    ID_Puesto INT NOT NULL,
    codigoEm INT NOT NULL,
    PRIMARY KEY (codigoTer),
    FOREIGN KEY (ID_Puesto) REFERENCES Puesto(ID_Puesto),
    FOREIGN KEY (codigoEm) REFERENCES Empleado(codigoEm)
);

CREATE TABLE Cliente(
    ID_Cliente INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    PRIMARY KEY (ID_Cliente)
);

CREATE TABLE FacturaCli(
    ID_FacturaCli INT NOT NULL AUTO_INCREMENT,
    fecha DATETIME NOT NULL,
    PRIMARY KEY (ID_FacturaCli)
);

CREATE TABLE DetalleFactura(
    ID_DetalleFactura INT NOT NULL AUTO_INCREMENT,
    cantidad INT NOT NULL,
    ID_FacturaCli INT NOT NULL,
    codigoTer INT NOT NULL,
    PRIMARY KEY (ID_DetalleFactura),
    FOREIGN KEY (ID_FacturaCli) REFERENCES FacturaCli(ID_FacturaCli),
    FOREIGN KEY (codigoTer) REFERENCES Terminado(codigoTer)
);

CREATE TABLE Devolucion(
    ID_Devolucion INT NOT NULL AUTO_INCREMENT,
    fecha DATETIME NOT NULL,
    ID_Cliente INT NOT NULL,
    PRIMARY KEY (ID_Devolucion),
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente)
);

CREATE TABLE Devueltos(
    ID_Devuelto INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    codigoPro INT NOT NULL,
    ID_Devolucion INT NOT NULL,
    PRIMARY KEY (ID_Devuelto),
    FOREIGN KEY (ID_Devolucion) REFERENCES Devolucion(ID_Devolucion)
);

CREATE TABLE DetalleBodega(
    ID_Detalle INT NOT NULL AUTO_INCREMENT,
    cantidad INT NOT NULL,
    noBodega INT NOT NULL,
    codigo INT,
    ID_NoTerminado INT,
    codigoTer INT,
    ID_Devuelto INT,
    PRIMARY KEY (ID_Detalle),
    FOREIGN KEY (noBodega) REFERENCES Bodega(noBodega),
    FOREIGN KEY (codigo) REFERENCES Parte(codigo),
    FOREIGN KEY (ID_NoTerminado) REFERENCES NoTerminado(ID_NoTerminado),
    FOREIGN KEY (codigoTer) REFERENCES Terminado(codigoTer),
    FOREIGN KEY (ID_Devuelto) REFERENCES Devueltos(ID_Devuelto)
);