-- TABLA ALUMNO
CREATE TABLE Alumno (
    ID_Alumno SERIAL PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Telefono INT NOT NULL,
    Fecha_Registro DATE DEFAULT CURRENT_DATE
);

-- TABLA BOOTCAMP
CREATE TABLE Bootcamp (
    ID_Bootcamp SERIAL PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion TEXT
);

-- TABLA MÓDULO
CREATE TABLE Modulo (
    ID_Modulo SERIAL PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion TEXT,
    Duracion INT NOT NULL
);

-- TABLA PROFESOR
CREATE TABLE Profesor (
    ID_Profesor SERIAL PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Especialidad VARCHAR(100) NOT NULL
);

-- TABLA INSCRIPCIÓN
CREATE TABLE Inscripcion (
    ID_Inscripcion SERIAL PRIMARY KEY,
    ID_Alumno INT NOT NULL,
    ID_Bootcamp INT NOT NULL,
    Fecha_Inscripcion DATE DEFAULT CURRENT_DATE,
    Cuenta_Bancaria VARCHAR(20) NOT NULL,
    Estado VARCHAR(20) CHECK (Estado IN ('Activo', 'Finalizado', 'Cancelado')) NOT NULL,
    Fecha_Baja DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (ID_Alumno) REFERENCES Alumno(ID_Alumno) ON DELETE CASCADE,
    FOREIGN KEY (ID_Bootcamp) REFERENCES Bootcamp(ID_Bootcamp) ON DELETE CASCADE
);

-- TABLA BOOTCAMP_MODULO
CREATE TABLE BootcampModulo (
    ID_Bootcamp INT NOT NULL,
    ID_Modulo INT NOT NULL,
    PRIMARY KEY (ID_Bootcamp, ID_Modulo),
    FOREIGN KEY (ID_Bootcamp) REFERENCES Bootcamp(ID_Bootcamp) ON DELETE CASCADE,
    FOREIGN KEY (ID_Modulo) REFERENCES Modulo(ID_Modulo) ON DELETE CASCADE
);

-- TABLA ASIGNACIÓN
CREATE TABLE Asignacion (
    ID_Profesor INT NOT NULL,
    ID_Modulo INT NOT NULL,
    PRIMARY KEY (ID_Profesor, ID_Modulo),
    FOREIGN KEY (ID_Profesor) REFERENCES Profesor(ID_Profesor) ON DELETE CASCADE,
    FOREIGN KEY (ID_Modulo) REFERENCES Modulo(ID_Modulo) ON DELETE CASCADE
);

