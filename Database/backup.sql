-- vpt.vpt_autorizacion_promo_empresarial definition

-- Drop table

-- DROP TABLE vpt.vpt_autorizacion_promo_empresarial;

CREATE TABLE vpt.vpt_autorizacion_promo_empresarial (
	sec int4 NOT NULL,
	nro int4 NOT NULL,
	empresa varchar(500) NULL,
	nit varchar(50) NOT NULL,
	nombre_promo varchar(500) NULL,
	depto varchar(50) NOT NULL,
	actividad varchar(50) NOT NULL,
	fecha_mes_anterior date NULL,
	fecha_mes_actual date NULL,
	estado_tramite varchar(50) NOT NULL,
	cite varchar(30) NOT NULL,
	fecha_emision date NOT NULL,
	periodo date NOT NULL,
	CONSTRAINT aut_pe_pk PRIMARY KEY (nro, nit, fecha_emision),
	CONSTRAINT aut_pe_uq UNIQUE (sec)
);

-- vpt.vpt_cant_aapa definition

-- Drop table

-- DROP TABLE vpt.vpt_cant_aapa;

CREATE TABLE vpt.vpt_cant_aapa (
	sec int4 NOT NULL,
	nro int4 NOT NULL,
	empresa varchar(500) NULL,
	nit varchar(50) NOT NULL,
	depto varchar(50) NOT NULL,
	auto varchar(50) NOT NULL,
	fecha date NOT NULL,
	direccion varchar(50) NOT NULL,
	CONSTRAINT cant_aapa_pk PRIMARY KEY (nro, nit, fecha),
	CONSTRAINT cant_aapa_uq UNIQUE (sec)
);

-- vpt.vpt_controles_jlas definition

-- Drop table

-- DROP TABLE vpt.vpt_controles_jlas;

CREATE TABLE vpt.vpt_controles_jlas (
	controljlasid int8 NOT NULL,
	tipoactividad varchar(50) NOT NULL,
	empresa varchar(100) NOT NULL,
	nit varchar(50) NOT NULL,
	totalcontroles int4 NOT NULL,
	periodo date NOT NULL,
	CONSTRAINT pk_vpt_controlesjlas PRIMARY KEY (controljlasid)
);

-- vpt.vpt_controles_pe definition

-- Drop table

-- DROP TABLE vpt.vpt_controles_pe;

CREATE TABLE vpt.vpt_controles_pe (
	controlpe int8 NOT NULL,
	oficina varchar(10) NULL,
	tipoactividad varchar(50) NOT NULL,
	empresa varchar(250) NOT NULL,
	promocionempresarial varchar(500) NOT NULL,
	nit varchar(50) NOT NULL,
	totalcontroles int4 NOT NULL,
	periodo date NOT NULL
);
-- vpt.vpt_fiscalizacion_jlas definition

-- Drop table

-- DROP TABLE vpt.vpt_fiscalizacion_jlas;

CREATE TABLE vpt.vpt_fiscalizacion_jlas (
	fiscalizacionjlasid int8 NOT NULL,
	operadorautorizado varchar(100) NOT NULL,
	nit varchar(50) NOT NULL,
	totalfiscalizaciones int4 NOT NULL,
	periodo date NOT NULL
);
-- vpt.vpt_fiscalizaciones_pe definition

-- Drop table

-- DROP TABLE vpt.vpt_fiscalizaciones_pe;

CREATE TABLE vpt.vpt_fiscalizaciones_pe (
	fiscalizacionpe int8 NOT NULL,
	empresa varchar(500) NOT NULL,
	nombrepromocion varchar(500) NOT NULL,
	nit varchar(50) NOT NULL,
	totalfiscalizaciones int4 NOT NULL,
	periodo date NOT NULL
);
-- vpt.vpt_indicador definition

-- Drop table

-- DROP TABLE vpt.vpt_indicador;

CREATE TABLE vpt.vpt_indicador (
	id int8 NOT NULL,
	descripcion varchar(500) NOT NULL,
	temporalidad varchar(100) NOT NULL,
	porcentaje numeric(5, 2) NULL,
	CONSTRAINT vpt_indicador_id_pk PRIMARY KEY (id)
);
-- vpt.vpt_indicador_gestion definition

-- Drop table

-- DROP TABLE vpt.vpt_indicador_gestion;

CREATE TABLE vpt.vpt_indicador_gestion (
	id int4 NOT NULL,
	descripcion varchar(500) NULL,
	acciones_propuestas varchar(500) NULL,
	indicador varchar(500) NULL,
	ponderacion numeric(5, 2) NULL,
	meta_gestion varchar(100) NULL,
	CONSTRAINT vpt_indicador_pk PRIMARY KEY (id)
);
-- vpt.vpt_intervenciones definition

-- Drop table

-- DROP TABLE vpt.vpt_intervenciones;

CREATE TABLE vpt.vpt_intervenciones (
	intervencionid int8 NOT NULL,
	departamento varchar(50) NOT NULL,
	razonsocial varchar(100) NOT NULL,
	nit varchar(50) NOT NULL,
	nombresalon varchar(100) NOT NULL,
	cantidadintervenciones int4 NOT NULL,
	cantidadmediosjuego int4 NOT NULL,
	periodo date NOT NULL
);
-- vpt.vpt_licencia_operacion definition

-- Drop table

-- DROP TABLE vpt.vpt_licencia_operacion;

CREATE TABLE vpt.vpt_licencia_operacion (
	licenciaoperacionid int8 NOT NULL,
	empresa varchar(500) NOT NULL,
	nit varchar(50) NOT NULL,
	departamento varchar(50) NOT NULL,
	salonesjuego varchar(500) NOT NULL,
	numeromediosjuego int4 NULL,
	actividad varchar(50) NOT NULL,
	fechasolicitudanterior timestamp NULL,
	fechasolicitudactual timestamp NULL,
	estadotramite varchar(50) NOT NULL,
	fechaemisionresolucion timestamp NULL,
	periodo timestamp NOT NULL
);
-- vpt.vpt_recurso_jerarquico definition

-- Drop table

-- DROP TABLE vpt.vpt_recurso_jerarquico;

CREATE TABLE vpt.vpt_recurso_jerarquico (
	recursojerarquicoid int8 NOT NULL,
	razonsocial varchar(100) NOT NULL,
	nit varchar(50) NOT NULL,
	departamento varchar(50) NOT NULL,
	numeroproveido varchar(50) NOT NULL,
	fechaproveido date NOT NULL,
	posicionratificada varchar(2) NOT NULL,
	estadotramite varchar(20) NOT NULL,
	periodo date NOT NULL
);
-- vpt.vpt_recurso_jerarquico_confirmado definition

-- Drop table

-- DROP TABLE vpt.vpt_recurso_jerarquico_confirmado;

CREATE TABLE vpt.vpt_recurso_jerarquico_confirmado (
	recursojerarquicoconfirmadoid int8 NOT NULL,
	razonsocial varchar(100) NOT NULL,
	nit varchar(50) NOT NULL,
	departamento varchar(50) NOT NULL,
	numeroresolucion varchar(50) NOT NULL,
	fecharesolucion date NOT NULL,
	resuelve varchar(50) NOT NULL,
	periodo date NOT NULL
);
-- vpt.vpt_recurso_revocatoria definition

-- Drop table

-- DROP TABLE vpt.vpt_recurso_revocatoria;

CREATE TABLE vpt.vpt_recurso_revocatoria (
	recursorevocatoriaid int8 NOT NULL,
	razonsocial varchar(200) NOT NULL,
	nit varchar(100) NOT NULL,
	departamento varchar(50) NOT NULL,
	numeroproveido varchar(30) NOT NULL,
	fechaproveido date NOT NULL,
	estadotramite varchar(30) NOT NULL,
	periodo date NOT NULL
);
-- vpt.vpt_recurso_revocatoria_confirmado definition

-- Drop table

-- DROP TABLE vpt.vpt_recurso_revocatoria_confirmado;

CREATE TABLE vpt.vpt_recurso_revocatoria_confirmado (
	recursorevocatoriaconfirmadoid int8 NOT NULL,
	razonsocial varchar(500) NULL,
	nit varchar(500) NOT NULL,
	departamento varchar(50) NOT NULL,
	numeroresolucion varchar(30) NOT NULL,
	fecharesolucion date NOT NULL,
	formaresolucion varchar(30) NOT NULL,
	periodo date NOT NULL
);
-- vpt.vpt_resolucion definition

-- Drop table

-- DROP TABLE vpt.vpt_resolucion;

CREATE TABLE vpt.vpt_resolucion (
	id_resolucion int4 NOT NULL,
	fecha timestamp NOT NULL,
	numero varchar(100) NOT NULL,
	nombre varchar(500) NOT NULL,
	objeto varchar(750) NOT NULL,
	CONSTRAINT resolucion_pk PRIMARY KEY (id_resolucion)
);
-- vpt.vpt_resolucion_sancionatoria_monto_impuesto definition

-- Drop table

-- DROP TABLE vpt.vpt_resolucion_sancionatoria_monto_impuesto;

CREATE TABLE vpt.vpt_resolucion_sancionatoria_monto_impuesto (
	resolucionmontoimpuestoid int8 NOT NULL,
	empresa varchar(150) NOT NULL,
	documentoidentidad varchar(50) NOT NULL,
	departamento varchar(20) NOT NULL,
	codigocite varchar(20) NOT NULL,
	montosancionufv numeric(15, 2) NOT NULL,
	direccion varchar(5) NOT NULL,
	estadors varchar(50) NOT NULL,
	periodo date NOT NULL
);