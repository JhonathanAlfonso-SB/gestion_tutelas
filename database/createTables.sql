-- tables


-- Table: XAD_TIPODOCUMENTO
CREATE TABLE "XAD_TIPODOCUMENTO" (
  "idTipoDocumento" NUMBER(7,0) NOT NULL,
  "nombreTipoDocumento" VARCHAR2(20) NOT NULL,
  CONSTRAINT "PK_TIPODOC" PRIMARY KEY ("idTipoDocumento")
);


--Table: XAD_ACCIONANTE
CREATE TABLE "XAD_ACCIONANTE" (
    "idAccionante" NUMBER(7,0) NOT NULL,
    "nombreAccionante" VARCHAR2(40) NOT NULL,
    "apellidoAccionante" VARCHAR2(40) NOT NULL,
    "documentoAccionante" VARCHAR2(20) NOT NULL,
    "idTipoDocumento" NUMBER(7,0) NOT NULL,
    CONSTRAINT "UK_ACCIONANTE_01" UNIQUE ("documentoAccionante"),
    CONSTRAINT "PK_ACCIONANTE" PRIMARY KEY ("idAccionante")
);


-- Table: XAD_ROL
CREATE TABLE "XAD_ROL" (
    "idRol" NUMBER(3,0),
    "nombreRol" VARCHAR2(20),
    CONSTRAINT "PK_ROL" PRIMARY KEY ("idRol")
);


-- Table: XAD_USUARIO
CREATE TABLE "XAD_USUARIO" (
    "idUsuario" NUMBER(7,0) NOT NULL,
    "nombreUsuario" VARCHAR2(40) NOT NULL,
    "apellidousuario" VARCHAR2(40) NOT NULL,
    "emailUsuario" NVARCHAR2(70) NOT NULL,
    "passwordUsuario" NVARCHAR2(100) NOT NULL,
    "idRol" NUMBER(3,0),
    CONSTRAINT "PK_USUARIO" PRIMARY KEY ("idUsuario")
);


-- Table: XAD_TIPOCONTESTACION
CREATE TABLE "XAD_TIPOCONTESTACION" (
    "idTipoContestacion" NUMBER(3,0),
    "nombreTipoContestacion" VARCHAR2(20) NOT NULL,
    CONSTRAINT "PK_TIPOCONTESTACION" PRIMARY KEY ("idTipoContestacion")
);


-- Table: XAD_CONTESTACION
CREATE TABLE XAD_CONTESTACION (
    "idContestacion" NUMBER(10,0) NOT NULL,
    "idTutela" NUMBER(10,0) NOT NULL,
    "idTipoContestacion" NUMBER(3,0),
    "fundamentosDerechoContestacion" NCLOB,
    "peticionesContestacion" NCLOB,
    "urlAnexoContestacion" NVARCHAR2(200),
    "idUsuarioCreacionContestacion" NUMBER(7,0) NOT NULL,
    "fechaCreacionContestacion" DATE NOT NULL,
    CONSTRAINT "PK_CONTESTACION" PRIMARY KEY ("idContestacion")
);


-- Table: XAD_ESTADO
CREATE TABLE "XAD_ESTADO" (
    "idEstado" NUMBER(3,0),
    "nombreEstado" VARCHAR2(20),
    CONSTRAINT "PK_ESTADO" PRIMARY KEY ("idEstado")
);


-- Table: XAD_APROBACION
CREATE TABLE "XAD_APROBACION" (
    "idAprobacion" NUMBER(10,0),
    "idContestacion" NUMBER(10,0) NOT NULL,
    "idEstado" NUMBER(3,0) NOT NULL,
    "idUsuarioCreacionAprobacion" NUMBER(7,0) NOT NULL,
    "fechaCreacionAprobacion" DATE NOT NULL,
    CONSTRAINT "PK_APROBACION" PRIMARY KEY ("idAprobacion")
);


-- Table: XAD_ETAPA
CREATE TABLE "XAD_ETAPA" (
    "idEtapa" NUMBER(3,0),
    "nombreEtapa" VARCHAR2(30),
    CONSTRAINT "PK_ETAPA" PRIMARY KEY ("idEtapa")
);


-- Table: XAD_COMPANIA
CREATE TABLE "XAD_COMPANIA" (
    "idCompania" NUMBER(10,0),
    "nombreCompania" NVARCHAR2(10) NOT NULL,
    CONSTRAINT "PK_COMPANIA" PRIMARY KEY ("idCompania")
);


-- Table: XAD_TUTELA
CREATE TABLE "XAD_TUTELA" (
    "idTutela" NUMBER(10,0),
    "idCompania" NUMBER(10,0) NOT NULL,
    "idAccionante" NUMBER(7,0) NOT NULL,
    "tipoTutela" VARCHAR2(10) NOT NULL,
    "resumenTutela" NVARCHAR2(200) NOT NULL,
    "urlTutela" NVARCHAR2(200) NOT NULL,
    "urlAnexosTutela" NVARCHAR2(200) NOT NULL,
    "idEtapa" NUMBER(3,0) NOT NULL,
    "idUsuarioCreacionTutela" NUMBER(7,0) NOT NULL,
    "fechaVencimientoTutela" DATE NOT NULL,
    "fechaCreacionTutela" DATE NOT NULL,
    "fechaActualizacionTutela" DATE,
    CONSTRAINT "PK_TUTELA" PRIMARY KEY ("idTutela")
);


-- foreing keys
-- Reference: FK_ACCIONANTE_TIPODOCUMENTO (table: XAD_ACCIONANTE)
ALTER TABLE "XAD_ACCIONANTE" ADD CONSTRAINT "FK_ACCIONANTE_TIPODOCUMENTO"
    FOREIGN KEY ("idTipoDocumento")
    REFERENCES "XAD_TIPODOCUMENTO" ("idTipoDocumento");
    
    
-- Reference: FK_USUARIO_ROL (table: XAD_USUARIO)
ALTER TABLE "XAD_USUARIO" ADD CONSTRAINT "FK_USUARIO_ROL"
    FOREIGN KEY ("idRol")
    REFERENCES "XAD_ROL" ("idRol");
    
    
-- Reference: FK_CONTESTACION_TUTELA (table: XAD_CONTESTACION)    
ALTER TABLE "XAD_CONTESTACION" ADD CONSTRAINT "FK_CONTESTACION_TUTELA"
    FOREIGN KEY ("idTutela")
    REFERENCES "XAD_TUTELA" ("idTutela");    
    
    
-- Reference: FK_CONTESTACION_TIPOCONTESTACION (table: XAD_CONTESTACION)
ALTER TABLE "XAD_CONTESTACION" ADD CONSTRAINT "FK_CONTES_TIPOCONTES"
    FOREIGN KEY ("idTipoContestacion")
    REFERENCES "XAD_TIPOCONTESTACION" ("idTipoContestacion");
    
    
-- Reference: FK_CONTESTACION_USUARIOCREADOR (table: XAD_CONTESTACION)
ALTER TABLE "XAD_CONTESTACION" ADD CONSTRAINT "FK_CONTES_USUARIOCREADOR"
    FOREIGN KEY ("idUsuarioCreacionContestacion")
    REFERENCES "XAD_USUARIO" ("idUsuario");
    
    
-- Reference: FK_APROBACION_CONTESTACION (table: XAD_APROBACION)
ALTER TABLE "XAD_APROBACION" ADD CONSTRAINT "FK_APROBA_CONTESTACION"
    FOREIGN KEY ("idContestacion")
    REFERENCES "XAD_CONTESTACION" ("idContestacion");


-- Reference: FK_APROBACION_ESTADO (table: XAD_APROBACION)
ALTER TABLE "XAD_APROBACION" ADD CONSTRAINT "FK_APROBA_ESTADO"
    FOREIGN KEY ("idEstado")
    REFERENCES "XAD_ESTADO" ("idEstado");
    
    
-- Reference: FK_APROBACION_USUARIOCREADOR (table: XAD_APROBACION)
ALTER TABLE "XAD_APROBACION" ADD CONSTRAINT "FK_APROBA_USUARIOCREADOR"
    FOREIGN KEY ("idUsuarioCreacionAprobacion")
    REFERENCES "XAD_USUARIO" ("idUsuario");
    
        
-- Reference: FK_TUTELA_COMPANIA (table: XAD_TUTELA)
ALTER TABLE "XAD_TUTELA" ADD CONSTRAINT "FK_TUTELA_COMPANIA"
    FOREIGN KEY ("idCompania")
    REFERENCES "XAD_COMPANIA" ("idCompania");
    
    
-- Reference: FK_TUTELA_ACCIONANTE (table: XAD_TUTELA)
ALTER TABLE "XAD_TUTELA" ADD CONSTRAINT "FK_TUTELA_ACCIONANTE"
    FOREIGN KEY ("idAccionante")
    REFERENCES "XAD_ACCIONANTE" ("idAccionante");
    
    
-- Reference: FK_TUTELA_ETAPA (table: XAD_TUTELA)
ALTER TABLE "XAD_TUTELA" ADD CONSTRAINT "FK_TUTELA_ETAPA"
    FOREIGN KEY ("idEtapa")
    REFERENCES "XAD_ETAPA" ("idEtapa");
    
    
-- Reference: FK_TUTELA_USUARIOCREADOR (table: XAD_TUTELA)
ALTER TABLE "XAD_TUTELA" ADD CONSTRAINT "FK_TUTELA_USUARIOCREADOR"
    FOREIGN KEY ("idUsuarioCreacionTutela")
    REFERENCES "XAD_USUARIO" ("idUsuario");
    
-- End of file.