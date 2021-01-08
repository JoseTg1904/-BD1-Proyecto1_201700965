CREATE TABLE Avion(
    ID_Avion INT NOT NULL,
    modelo VARCHAR(20) NOT NULL,
    matricula VARCHAR(20) NOT NULL,
    asientoPrim INT NOT NULL,
    asientoEco INT NOT NULL,
    asientoEjec INT NOT NULL,
    ultimoMan DATE,
    proxMan DATE NOT NULL,
    ultimoAterrizaje DATETIME NOT NULL,
    ultimoDespegue DATETIME NOT NULL,
    tanque INT NOT NULL,
    distancia DECIMAL(10, 2) NOT NULL,
    alturaMax DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (ID_Avion)
);

CREATE TABLE Mantenimiento(
    ID_Mantenimiento INT NOT NULL AUTO_INCREMENT,
    fechaYHora DATETIME NOT NULL,
    tipoMan BOOLEAN NOT NULL,
    ID_Avion INT NOT NULL,
    PRIMARY KEY (ID_Mantenimiento),
    FOREIGN KEY (ID_Avion) REFERENCES Avion(ID_Avion)
);

CREATE TABLE Observacion(
    ID_Observacion INT NOT NULL AUTO_INCREMENT,
    contenido TEXT NOT NULL,
    titulo VARCHAR(20) NOT NULL,
    ID_Mantenimiento INT NOT NULL,
    PRIMARY KEY (ID_Observacion),
    FOREIGN KEY (ID_Mantenimiento) REFERENCES Mantenimiento(ID_Mantenimiento)
);

CREATE TABLE Problema(
    ID_Problema INT NOT NULL AUTO_INCREMENT,
    contenido TEXT NOT NULL,
    titulo VARCHAR(20) NOT NULL,
    ID_Mantenimiento INT NOT NULL,
    PRIMARY KEY (ID_Problema),
    FOREIGN KEY (ID_Mantenimiento) REFERENCES Mantenimiento(ID_Mantenimiento)
);

CREATE TABLE Baja(
    ID_Baja INT NOT NULL AUTO_INCREMENT,
    fecha DATE NOT NULL,
    motivo TEXT NOT NULL,
    tipo BOOLEAN NOT NULL,
    PRIMARY KEY (ID_Baja)
);

CREATE TABLE Jornada(
    ID_Jornada INT NOT NULL AUTO_INCREMENT,
    jornada VARCHAR(20) NOT NULL,
    PRIMARY KEY (ID_Jornada)
);

CREATE TABLE TipoEmpleado(
    ID_TipoEmpleado INT NOT NULL AUTO_INCREMENT,
    tipoEmpleado VARCHAR(20) NOT NULL,
    PRIMARY KEY (ID_TipoEmpleado)
);

CREATE TABLE Idioma(
	ID_Idioma INT NOT NULL AUTO_INCREMENT,
    idioma VARCHAR(100) NOT NULL,
    PRIMARY KEY(ID_Idioma)
);

CREATE TABLE Empleado(
    cui INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    edad INT NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    fechaContrato DATE NOT NULL,
    fechaNac DATE NOT NULL,
    correo VARCHAR(50) NOT NULL,
    telefono VARCHAR(50) NOT NULL,
    inicioTurno TIME NOT NULL,
    finTurno TIME NOT NULL,
    ID_Idioma INT NOT NULL,
    ID_TipoEmpleado INT NOT NULL,
    ID_Jornada INT NOT NULL,
    ID_Baja INT,
    PRIMARY KEY (cui),
    FOREIGN KEY (ID_Idioma) REFERENCES Idioma(ID_Idioma),
    FOREIGN KEY (ID_TipoEmpleado) REFERENCES TipoEmpleado(ID_TipoEmpleado),
    FOREIGN KEY (ID_Jornada) REFERENCES Jornada(ID_Jornada),
    FOREIGN KEY (ID_Baja) REFERENCES Baja(ID_Baja)
);

CREATE TABLE Pais(
    ID_Pais INT NOT NULL AUTO_INCREMENT,
    pais VARCHAR(25) NOT NULL,
    PRIMARY KEY (ID_Pais)
);

CREATE TABLE Ciudad(
    ID_Ciudad INT NOT NULL AUTO_INCREMENT,
    ciudad VARCHAR(25) NOT NULL,
    ID_Pais INT NOT NULL,
    PRIMARY KEY (ID_Ciudad),
    FOREIGN KEY (ID_Pais) REFERENCES Pais(ID_Pais)
);

CREATE TABLE Viaje(
    ID_Viaje INT NOT NULL AUTO_INCREMENT,
    noPasajero INT NOT NULL,
    fechaDespegue DATETIME NOT NULL,
    fechaAterrizaje DATETIME NOT NULL,
    ID_CiudadOrigen INT NOT NULL,
    ID_CiudadDestino INT NOT NULL,
    PRIMARY KEY (ID_Viaje),
    FOREIGN KEY (ID_CiudadOrigen) REFERENCES Ciudad(ID_Ciudad),
    FOREIGN KEY (ID_CiudadDestino) REFERENCES Ciudad(ID_Ciudad)
);

CREATE TABLE AsignacionVuelo(
    ID_Viaje INT NOT NULL,
    ID_Avion INT NOT NULL,
    PRIMARY KEY (ID_Viaje, ID_Avion),
    FOREIGN KEY (ID_Viaje) REFERENCES Viaje(ID_Viaje),
    FOREIGN KEY (ID_Avion) REFERENCES Avion(ID_Avion)
);

CREATE TABLE AsignacionEmpleado(
    ID_Viaje INT NOT NULL,
    cui INT NOT NULL,
    PRIMARY KEY (ID_Viaje, cui),
    FOREIGN KEY (ID_Viaje) REFERENCES Viaje(ID_Viaje),
    FOREIGN KEY (cui) REFERENCES Empleado(cui)
);

CREATE TABLE CodigoPostal(
    ID_CodigoPostal INT NOT NULL AUTO_INCREMENT,
    codigoPostal INT NOT NULL,
    PRIMARY KEY (ID_CodigoPostal)
);

CREATE TABLE Cliente(
    cuiC INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    edad INT NOT NULL,
    fechaNac DATE NOT NULL,
    correo VARCHAR(100) NOT NULL,
    telefono VARCHAR(10) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    noPasaporte INT NOT NULL,
    ID_CodigoPostal INT NOT NULL,
    PRIMARY KEY (cuiC),
    FOREIGN KEY (ID_CodigoPostal) REFERENCES CodigoPostal(ID_CodigoPostal)
);

CREATE TABLE Boleto(
    ID_Boleto INT NOT NULL AUTO_INCREMENT,
    origen VARCHAR(50) NOT NULL,
    destino VARCHAR(50) NOT NULL,
    escala BOOLEAN NOT NULL,
    fechaSalida DATETIME NOT NULL,
    fechaRegreso DATETIME NOT NULL,
    pesoEquipaje DECIMAL (8, 2) DEFAULT 50.0,
    ID_Cliente INT NOT NULL,
    ID_Viaje INT NOT NULL,
    PRIMARY KEY (ID_Boleto),
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(cuiC),
    FOREIGN KEY (ID_Viaje) REFERENCES Viaje(ID_Viaje)
);

CREATE TABLE MetodoPago(
    ID_MetodoPago INT NOT NULL AUTO_INCREMENT,
    metodoPago VARCHAR(20) NOT NULL,
    PRIMARY KEY (ID_MetodoPago)
);

CREATE TABLE Pago(
    ID_Pago INT NOT NULL AUTO_INCREMENT,
    noTarjeta INT,
    monto DECIMAL(10, 2) NOT NULL,
    ID_MetodoPago INT NOT NULL,
    ID_Boleto INT NOT NULL,
    PRIMARY KEY (ID_Pago),
    FOREIGN KEY (ID_MetodoPago) REFERENCES MetodoPago(ID_MetodoPago),
    FOREIGN KEY (ID_Boleto) REFERENCES Boleto(ID_Boleto)
);