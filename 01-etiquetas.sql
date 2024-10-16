
SolicitudesPromociones:
LOAD * INLINE
[ _dimensionSPE,  				_etiquetaSPE,	_rotuloSPE
  Número Trámite, 					A,			Número Trámite  
  Tipo Proceso,						B,			Tipo Proceso
  Departamento Fiscal,                		C,			Departamento Fiscal
  Tipo Actividad económica, 			D,			Tipo Actividad económica
  Dirección Trámite,					E,			Oficina
  Fecha Recepción Secretaria, 			F,			Recepción Trámite
  Fecha Inicio Trámite, 				G,			Fecha Inicio Trámite
  Fecha Fin Trámite, 					H,			Fecha Fin Trámite
  Hoja Ruta, 							I,			Hoja Ruta
  Nombre/Empresa, 					J,			Empresa
  Documento Identidad, 				K,			Documento Identidad
  Promoción Empresarial,  				L,			Promoción Empresarial
  Fecha Inicio Promoción, 				M,			Fecha Inicio Promoción
  Fecha Fin Promoción, 				N,			Fecha Fin Promoción
  Fecha Inicio Ampliación,				O,			Fecha Inicio Ampliación
  Fecha Fin Ampliación, 				P,			Fecha Fin Ampliación
  Cite Autorización Rechazo,			Q,			Resolución Autorización/Rechazo
  Código Cite Autorización Rechazo, 	R,			Código Resolución
  Fecha Autorizacion Rechazo, 			S, 			Fecha Autorizacion/Rechazo
  Estado Modalidad Acceso Premio, 	T, 			Estado Modalidad
  Estado Trámite Proceso,				U,			Estado Trámite Proceso
  Usuario Autorizacion Rechazo,		V,			Usuario Autorizacion Rechazo
  Modalidad Premiacion,				W, 			Tipo Modalidad Premiación
  Modalidad Acceso Premio, 			X, 			Modalidad Acceso al Premio
   
  Cadena Cite, 						Y,			Documento Asociado
  Codigo Cite,  						Z,			Codigo Cite Asociado
  Fecha Documento, 					Z1, 			Fecha Documento
  Estado Cite, 						Z2,			Estado Asociado
  Usuario,							Z3,			Usuario Asociado
  Sigla Departamento,					Z4,			Departamento del Usuario
  Sigla Dirección,						Z5,			Dirección
  Sigla Tipo Documento,				Z6,			Tipo Documento
  Estado Autorización, 				Z7,			Estado Autorización 
  Anio, 				Z8,			Gestión
 ];

MedidasPromociones:
LOAD * Inline
[_medidaMPE, _etiquetaMPE  
   Cantidad Documentos Asociados,  B
  Cantidad Resoluciones,   C
  Valor Comercial,			D
  
];


ProcesoSancionatorios:
LOAD * INLINE
[ _dimensionPS, 			_etiquetaPS, 	_rotuloPS
  Tipo Proceso Sanción, 				A, 		Tipo Proceso
  Hoja Ruta Sanción,  					B, 		Hoja Ruta 
  Fecha Recepcion Secretaria Sanción,	C, 		Recepcion Trámite
  Cite Autorización Sanción, 			D, 		Cite Autorización
  Fecha Autorización Sanción,			E, 		Fecha Autorización
  Nombre/Empresa Sanción , 			F, 		Empresa 
  Documento Identidad Sanción,  		G, 		Documento Identidad 
  Promoción Empresarial Sanción, 		H, 		Promoción Empresarial
  Fecha Informe Detección, 			I, 		Fecha Informe Detección
  Estado Cite AAPA, 					J, 		Estado AAPA
  Estado Cite RS,						K, 		Estado RS
  Cite Informe Detección,  				L, 		Informe Detección
  Fiscalizador Detección, 				M, 		Fiscalizador Detección
  Fecha AAPA,  						N, 		Fecha AAPA
  Cite AAPA,  							O, 		AAPA
  Código Cite AAPA, 					P, 		Código AAPA
  Fecha Cite RS, 						R, 		Fecha RS
  Código Cite RS, 						S, 		Código RS
  Cite RS , 							T, 		Resolución Sancionatoria
  Estado RS,							U, 		Estado Determinado en la RS
 Fecha Cite AFA, 						V, 		Fecha AFA
  Cite AFA, 							W,		AFA
  Código Cite AFA, 						X, 		Código AFA
  Estado Sancion,						Y, 		Estado Trámite
  Número Trámite,					Z,		Número Trámite

  Cadena Cite, 						Z1,		Documento Asociado
  Codigo Cite,  						Z2,		Codigo Cite Asociado
  Fecha Documento, 					Z3, 		Fecha Documento
  Estado Cite, 						Z4,		Estado Cite Asociado
  Usuario,							Z5,		Usuario Cite Asociado
  Sigla Departamento,					Z6,		Departamento del Usuario
  Sigla Dirección,						Z7,		Dirección
  Sigla Tipo Documento,				Z8,		Tipo Documento
  Dirección Sanción,					Z9,		Oficina
  
];


MedidasSancionatrorioPE:
LOAD * INLINE
[ _medidaPSPE,                      _etiquetaSPPE ,  _rotuloSPPE
  MontoUFV AAPA,  			A, 		Monto AAPA
  MontoUFV RS, 				B, 		Monto RS
  CantidadAAPA,                    C,		Cantidad AAPA
  CantidadCitesAsociado,		D,		Cantidad Cites Asociados   
  CantidadRS,                    E,		Cantidad RS
];


EProcesosFiscalizaciones:
LOAD * INLINE
[  _dimensionPFI, _etiquetaPFI, _rotuloPFI
   Número Trámite, A, Número Trámite
  Cite RAA Fisca, B, Cite RAA
   Dirección Fiscalizacion,C, Dirección
   Nombre Empresa Fisca, D, Empresa
   Nombre Promocion Fisca, E, Promoción	
		Orden Fiscalizacion, F, Orden Fiscalización
	   Fecha Orden Fiscalizacion, G, Fecha Orden Fiscalización
	   CiteNotaOrdenFisca, H, Cite Nota Orden Fiscalización
	   Usuario Asignador,  I, Usuario Asignador
	  Fiscalizador Asignado , J,Fiscalizador Asignado  
	   Cite Memo Asignacion, K,Cite Memo Asignacion
	  Fecha Memo Asignacion, L,Fecha Memo Asignacion
	 Fecha Notificacion Orden Fiscalizacion, M,  Fecha Notificacion 
       Notificador Orden Fiscalizacion, N , Notificador
       Tipo Notificacion Orden Fiscalizacion, O, Tipo Notificacion
 	Fecha Informe Fiscalizacion,  P, Fecha Informe Fiscalizacion
	Cite Informe Fiscalizacion , Q, Cite Informe Fiscalizacion 
	 Departamento Fiscalizacion, R, Departamento Empresa
	  Auto Conclusion, S,  Cite Auto Conclusion
	  Archivo/Juridica, T, Archivo/Juridica
	   Estado Fiscalizacion,U,Estado Fiscalizacion
];

/****  para filtro de Fechas Pago *************/

FechaPago:
LOAD * INLINE
[ _FechasPago,        _etiquetaFP 
  1,  			Fecha de Pago	
  2, 			Fecha Presentación Boleta
];

FechaFiscalizacion:
LOAD * INLINE
[ _FechasFiscalizacion,        _etiquetaFFisca
  1,  			Fecha de OFPE
  2, 			Fecha de Informe
];
