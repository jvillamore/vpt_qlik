SET ThousandSep='.';
SET DecimalSep=',';
SET MoneyThousandSep='.';
SET MoneyDecimalSep=',';
SET MoneyFormat='#.##0,00 €;-#.##0,00 €';
SET TimeFormat='h:mm:ss';
SET DateFormat='DD/MM/YYYY';
SET TimestampFormat='DD/MM/YYYY';
SET MonthNames='ene;feb;mar;abr;may;jun;jul;ago;sep;oct;nov;dic';
SET DayNames='lun;mar;mié;jue;vie;sáb;dom';
SET vAnioInicioBI = "2011";
SET vEstadoActivo = "'ACTIVO'";
SET vTipoTramite = "'SOLICITUD AUTORIZACION PROMOCION EMPRESARIAL'";
SET vTipoDesistimientoPE="'SOLICITUD DESISTIMIENTO'";
SET vTipoTramiteSancion="'SANCION EMPRESAS','SANCION PROMOCIONES EMPRESARIALES'";
SET HidePrefix = '_';
SET HideSuffix = '%';
SET vMostrarAdministraticoCC = "1";

// Origen de datos Excel
SET dnf_path = 'D:\AJ\DataSource\DNF\';
SET dnj_path = 'D:\AJ\DataSource\DNJ\';
SET vpt_path = 'D:\AJ\DataSource\VPT\';


OLEDB CONNECT TO [Provider=SQLOLEDB.1;Password=2017Intranet2017;Persist Security Info=True;User ID=uminaj;Data Source=192.168.2.127;Use Procedure for Prepare=1;Auto Translate=True;Packet Size=4096;Use Encryption for Data=False;Tag with column collation when possible=False];
Directory;

// borrar
RegulatoriasDNJ:
  LOAD 
  [OFICINA DR],
  [NRO TRAMITE DR],
  [FECHA REGISTRO DR],
  [DENUNCIANTE],
  [DENUNCIADO],
  [TIPO DR],
  [FECHA EMISION DE RESPUESTA],
  [NUMERO CITE AUTO DR],
  [ESTADO DR],
  [DEPARTAMENTO DR]	,
  [DESCRIPCION DR],
  [OBSERVACIONES DR]
  FROM $(dnj_path)BASE DE DATOS DNJ.xlsx
  (ooxml, embedded labels, header is 1 lines, table is [VPT-DENUNCIA-RECLAMO]);

// borrar
RegulatoriasDNJ:
  LOAD 
  [FECHA REGULATORIA],
  [NRO RESOLUCION REGULATORIA],
  [NOMBRE RESOLUCION REGULATORIA],
  [OBSERVACIONES REGULATORIA]	
  FROM $(dnj_path)BASE DE DATOS DNJ.xlsx
  (ooxml, embedded labels, header is 1 lines, table is [VPT-REGULATORIA]);
   
ResolucionesRSDNJ:
  LOAD 
  [NRO RS],
  [RAZON SOCIAL RS]  ,
  [NIT RS]   ,
  [DEPARTAMENTO RS]  ,
  [RESOLUCION RS]  ,
  [FECHA RESOLUCION RS]  ,
  [MONTO RESOLUCION RS],
  [OBSERVACIONES RS]
  FROM $(dnj_path)BASE DE DATOS DNJ.xlsx
  (ooxml, embedded labels, header is 0 lines, table is [VPT-RS DNAL]);

RecursoJerarquicoPE:
  LOAD
  [RazonSocial] as [RAZON SOCIAL RJ] ,
  [NIT] asd [NIT RJ]   ,
  [Departamento] as [DEPARTAMENTO RJ] , 
  [NumeroProveido] as [PROVEÍDO RJ] , 
  [FechaProveido] as [FECHA PROVEIDO RJ] , 
  [EstadoTramite] as [ESTADO DEL TRAMITE RJ] ,
  [mes] as [PERIODO RJ],
  [anio] as [AÑO RJ],
  [observaciones] as [OBSERVACIONES RJ];
  SQL
  SELECT
    RecursoJerarquicoID,
    RazonSocial,
    NIT,
    Departamento,
    NumeroProveido,
    FechaProveido,
    PosicionRatificada,
    EstadoTramite,
    case
      when month(Periodo) = 1 then 'ene'
      when month(Periodo) = 2 then 'feb'
      when month(Periodo) = 3 then 'mar'
      when month(Periodo) = 4 then 'abr'
      when month(Periodo) = 5 then 'may'
      when month(Periodo) = 6 then 'jun'
      when month(Periodo) = 7 then 'jul'
      when month(Periodo) = 8 then 'ago'
      when month(Periodo) = 9 then 'sep'
      when month(Periodo) = 10 then 'oct'
      when month(Periodo) = 11 then 'nov'
      when month(Periodo) = 12 then 'dic'
      when month(Periodo) is null then 'NA'
    end as mes,
    year(Periodo) as anio,
    'NINGUNA' as observaciones
  FROM
    [ODS.VPTRecursosJerarquicos];
  
RecursoJerarquicoCONFIRMADOS:
  LOAD
  [RazonSocial] as [RAZON SOCIAL RJC],
	[NIT] as [NIT O CI RJC],
	[Departamento] as [DEPARTAMENTO RJC],
	[NumeroResolucion] as [N° RESOLUCION RJC],
	[FechaResolucion] as [FECHA RJC],
	[Resuelve] as [RESUELVE RJC],
	[mes] as [PERIODO RJC],
	[anio] as [AÑO RJC],
	[observacion] as [OBSERVACIONES RJC];   
SQL
SELECT
	RazonSocial, NIT, Departamento, NumeroResolucion, FechaResolucion, Resuelve ,
	case
		when month(Periodo) = 1 then 'ene'
		when month(Periodo) = 2 then 'feb'
		when month(Periodo) = 3 then 'mar'
		when month(Periodo) = 4 then 'abr'
		when month(Periodo) = 5 then 'may'
		when month(Periodo) = 6 then 'jun'
		when month(Periodo) = 7 then 'jul'
		when month(Periodo) = 8 then 'ago'
		when month(Periodo) = 9 then 'sep'
		when month(Periodo) = 10 then 'oct'
		when month(Periodo) = 11 then 'nov'
		when month(Periodo) = 12 then 'dic'
		when month(Periodo) is null then 'NA'
	end as mes,
	year(Periodo) as anio,
	'' as observacion
FROM
	[ODS.VPTRecursosJerarquicosConfirmados]
WHERE
((year(Periodo)<= 2023
		and Resuelve like '%CONFIRM%' COLLATE Latin1_General_CI_AS)
	or (year(Periodo)>= 2024
		and not (Resuelve like 'REVOC_' COLLATE Latin1_General_CI_AS
			or Resuelve like 'REVOCA_' COLLATE Latin1_General_CI_AS
			or Resuelve like 'REVOC_% TOTALMENTE' COLLATE Latin1_General_CI_AS
			)));


RecursoRevocatoriaPE:
  LOAD
  [RAZON SOCIAL RR],
  [NIT O CI RR],
  [DEPARTAMENTO RR],
  [N° PROVEIDO RR],
  [FECHA PROVEIDO RR],
  [ESTADO DEL TRAMITE RR],
  [PERIODO RR],
  [AÑO RR],
  [OBSERVACIONES RR]
  FROM $(dnj_path)BASE DE DATOS DNJ.xlsx
  (ooxml, embedded labels, header is 0 lines, table is [VPT-REVOCATORIAS PE]);

RecursoRevocatoriaCONFIRMADAS:
  LOAD
  [RAZON SOCIAL RRC],
  [NIT O CI RRC],
  [DEPARTAMENTO RRC],
  [N° RESOLUCION RRC],
  [FECHA RRC],
  [FORMA RESOLUCION RRC],
  [PERIODO RRC],
  [AÑO RRC],
  [OBSERVACIONES RRC]
  FROM $(dnj_path)BASE DE DATOS DNJ.xlsx
  (ooxml, embedded labels, header is 0 lines, table is [VPT-REVOCATORIAS CONF]);

solicitudLOVPT:
  LOAD
  [EMPRESA LOVPT],
  [NIT LOVPT],
  [DEPARTAMENTO LOVPT],
  [SALONES DE JUEGO LOVPT],
  [NÚMERO DE MEDIOS DE JUEGOS LOVPT],
  [ACTIVIDAD LOVPT],
  [FECHA DE SOLICITUD ANTERIOR LOVPT],
  [FECHA DE SOLICITUD  ACTUAL LOVPT],
  [ESTADO DEL TRÁMITE LOVPT],
  [FECHA DE EMISIÓN DE LA RAA/RAR LOVPT],
  [PERIODO LOVPT],
  [Año LOVPT],
  [OBSERVACIONES LOVPT]
  FROM $(dnj_path)BASE DE DATOS DNJ.xlsx
  (ooxml, embedded labels, header is 0 lines, table is [VPT-LO]);

ControlesPromociones:
  LOAD 
  [Nombre o Razón Social]        as [Nombre o Razón Social CPE], 
  [Nombre Promoción Empresarial] as [Nombre Promoción Empresarial CPE], 
  [NIT]   						 as [NIT CPE],
  [La Paz]						 as [La Paz CPE],
  [Oruro]						 as [Oruro CPE],
  [Potosi]  					 as [Potosi CPE],
  [Cochabamba]   				 as [Cochabamba CPE],
  [Sucre]   					 as [Sucre CPE],
  [Tarija] 						 as [Tarija CPE],
  [Santa Cruz] 					 as [Santa Cruz CPE],
  [Trinidad]					 as [Trinidad CPE],	
  [Cobija]  					 as [Cobija CPE],
  [Mes] 						 as [Mes CPE],
  [Año]   						 as [Año CPE],
  [Condición PE]  				 as [Condición PE CPE],
  [Tipo Actividad]  			 as [Tipo Actividad CPE],
  [Observaciones CPE]				 as [Observaciones CPE] 
  FROM $(dnf_path)BASE DE DATOS DNF.xlsx
  (ooxml, embedded labels, header is 1 lines, table is [Controles Promociones]);

// Borrar
ControlesOperadores:
  LOAD 
  [Nombre o Razón Social] as [Nombre o Razón Social CO], 
  [NIT]                   as  [NIT CO],
  [La Paz]				  as   [La Paz CO],
  [Oruro]				  as   [Oruro CO],
  [Potosi]  			  as [Potosi CO],
  [Cochabamba]   		  as [Cochabamba CO],
  [Sucre]   			  as [Sucre CO],
  [Tarija]  			  as   [Tarija CO],
  [Santa Cruz]  		  as [Santa Cruz CO],
  [Trinidad]  			  as  [Trinidad CO],	
  [Cobija]  			  as [Cobija CO],
  [Mes] 				  as   [Mes CO],
  [Año]    				  as  [Año CO],
  [Tipo Actividad]   	  as [Tipo Actividad CO],
  [Observaciones CO]		  as [Observaciones CO] 
  FROM $(dnf_path)BASE DE DATOS DNF.xlsx
  (ooxml, embedded labels, header is 1 lines, table is [Controles Operadores]);

// Borrar
FiscalizacionLoteriaAzar:
  LOAD 
  [Nombre o Razón Social]  as [Nombre o Razón Social FLO], 
  [NIT]  				   as [NIT FLO],
  [La Paz]				   as [La Paz FLO],
  [Oruro]				   as [Oruro FLO],
  [Potosi]  			   as [Potosi FLO],
  [Cochabamba]   		   as [Cochabamba FLO],
  [Sucre]   			   as [Sucre FLO],
  [Tarija]  			   as [Tarija FLO],
  [Santa Cruz]  		   as [Santa Cruz FLO],
  [Trinidad]  			   as [Trinidad FLO],	
  [Cobija]  			   as [Cobija FLO],
  [Mes]  				   as [Mes FLO],
  [Año]    				   as [Año FLO],
  [Tipo Actividad]   	   as [Tipo Actividad FLO],
  [Observaciones FLO]	   as [Observaciones FLO]    
  FROM $(dnf_path)BASE DE DATOS DNF.xlsx
  (ooxml, embedded labels, header is 1 lines, table is [Fisca LoteriaAzar]);

// Borrar
IntervencionesJLAS:
  LOAD 
  [Departamento]  				as [Departamento JLAS],
  [Empresa]  					as [Nombre o Razón Social JLAS], 
  [NIT]   						as  [NIT JLAS],
  [Nombre Salon]  				AS [Nombre Salon JLAS],
  [Cantidad Medios de Juego]    AS  [Cantidad Medios de Juego JLAS],
  [Mes] 						as [Mes JLAS],
  [Año] 						as [Año JLAS],
  [NumeroMes] 					as [Numero Mes JLAS],
  [Observaciones JLAS]		  		as [Observaciones JLAS] 
  FROM $(dnf_path)BASE DE DATOS DNF.xlsx
  (ooxml, embedded labels, header is 1 lines, table is [INTERVENCIONES ENE-JUL]);

// Borrar
VisitasPE:
  LOAD 
  [Oficina]   		as [Oficina VI], 
  [La Paz]			as   [La Paz VI],
  [Oruro]			as   [Oruro VI],
  [Potosi]  		as [Potosi VI],
  [Cochabamba]  	as [Cochabamba VI],
  [Sucre]   		as [Sucre VI],
  [Tarija]  		as   [Tarija VI],
  [Santa Cruz]  	as [Santa Cruz VI],
  [Trinidad]  		as  [Trinidad VI],	
  [Cobija]  		as [Cobija VI],
  [Mes]  			as   [Mes VI],
  [Año]    			as  [Año VI],
  [Observaciones VI]	as [Observaciones VI] 
  FROM $(dnf_path)BASE DE DATOS DNF.xlsx
  (ooxml, embedded labels, header is 1 lines, table is [Visitas PE]);

// Borrar
IndicadoresVPT:
  LOAD 
  [Numero] as [Numero VPT],
  [indicador] as [Indicador VPT],
  [explicacion] as [Explicacion VPT],
  [forma calculo] as [Forma Calculo VPT],
  [meta] as [Meta Anual VPT]
  //[PERIODO IND],
  //[AÑO IND]
  FROM $(vpt_path)BASE DE DATOS VPT.xlsx
  (ooxml, embedded labels, header is 0 lines, table is [Indicadores-2016]);

// Borrar
NumeroFiscalizadoresVPT:
  LOAD 
  [NumeroFiscalizadores] as [Numero Fiscalizadores],
  [PeriodoFiscalizadores] as [Periodo Fiscalizadores],
  [AñoFiscalizadores] as [Año Fiscalizadores]
  FROM $(vpt_path)BASE DE DATOS VPT.xlsx
  (ooxml, embedded labels, header is 0 lines, table is [Fiscalizadores]);

// Borrar
PremiosLonabolVPT:
  LOAD   
  [EMPRESA] as	[EmpresaPLVPT],  
  [NIT] as [NitPLVPT],
  [DEPARTAMENTO] as [DepartamentoPLVPT],
  [OFERTADO] as  [OfertadoPLVPT],
  [NO ENTREGADO] as [NoEntregadoPLVPT],
  [PERIODO] as [PeriodoPLVPT],
  [AÑO] as [AnioPLVPT]
  FROM $(dnf_path)BASE DE DATOS DNF.xlsx
  (ooxml, embedded labels, header is 1 lines, table is [VPT-PREMIOS-LONABOL]);
  
  // Borrar
  MultasLonabolVPT:
  LOAD   
  [EMPRESA] as	[EmpresaMLVPT],  
  [NIT] as [NitMLVPT],
  [DEPARTAMENTO] as [DepartamentoMLVPT],
  [RESOLUCION] as  [ResolucionMLVPT],
  [MONTO UFV] as [MontoUfvMLVPT],
  [DIRECCION REGIONAL] as [DireccionRegionalMLVPT],
  [PERIODO] as [PeriodoMLVPT],
  [AÑO] as [AnioMLVPT]
  FROM $(dnj_path)BASE DE DATOS DNJ.xlsx
  (ooxml, embedded labels, header is 1 lines, table is [VPT-SANCIONES-NO-TRANSF-LONABOL]);

// Borrar
SancionadorNacionalINTERNO:
  LOAD   
  [HR] as	[SANNAL_HR],  
  [OFICINA] as [SANNAL_OFICINA],
  [DIRECCION REGIONAL] as [SANNAL_DR],
  [Nº DE ACTA (JLAS)] as  [SANNAL_ACTAJLAS],
  [FECHA DEL ACTA (JLAS)] as [SANNAL_FECHAJLAS],
  [CITE DEL INFORME DE ACTUACION] as [SANNAL_INFORMERELACIONADO],
  [TIPO DE PROCESO] as [SANNAL_TIPOPROCESO],
  [RAZÓN SOCIAL/ NOMBRE Y APELLIDO] as [SANNAL_RAZONSOCIAL],
  [NIT / CEDULA IDENTIDAD] as [SANNAL_NITCI],
  [ENCARGADO] as [SANNAL_ENCARGADO],
  [CEDULA IDENTIDAD] as [SANNAL_CIENCARGADO],
  [DIRECCION] as [SANNAL_DIRECCION],
  [CIUDAD] as [SANNAL_CIUDAD],
  [SANCION EN UFV AAPA] as [SANNAL_SANCIONAAPAUFV],
  [CITE DEL AAPA] as [SANNAL_CITEAAPA],
  [FECHA DE EMISIÓN AAPA] as [SANNAL_FECHAEMISIONAAPA],
  [CITE DE LA R.S.] as [SANNAL_CITERA],
  [FECHA DE EMISIÓN RS] as [SANNAL_FECHARS],
  [SANCION EN UFV RS] as [SANNAL_SANCIONRSUFV],
  [GESTION] as [SANNAL_GESTIONSANCIONRSUFV],
  [OBSERVACIONES] as [SANNAL_OBSERVACIONESSANCIONRSUFV]
  FROM $(dnj_path)BASE DE DATOS DNJ.xlsx
  (ooxml, embedded labels, header is 1 lines, table is [SANCIONADOR-NAL]);

// Borrar
MultasRecaudadoSegunSigepVPT:
  LOAD   
  [CONCEPTO_RECAUDACION_VPT_Sigep],  
  [RECAUDACION_ENBs_VPT_Sigep],
  [MES_VPT_Sigep],
  [AÑO_VPT_Sigep],
  [OBERVACIONES_VPT_Sigep]
  FROM $(dnj_path)BASE DE DATOS DNJ.xlsx
  (ooxml, embedded labels, header is 1 lines, table is [MULTAS-SEGUN-SIGEP]);

// Borrar  
MaquinasDestruidasDonasVPT_Punto19:
  LOAD   
  [DIRECCIÓN] as	[VPT_Punto19_Direccion],  
  [CANTIDAD DE MEDIOS DE JUEGO DECOMISADOS] as [VPT_Punto19_Decomisadas],
  [DESTRUIDOS POR LA AJ] as [VPT_Punto19_Destruidos],
  [VENDIDOS Y DESTRUIDOS] as  [VPT_Punto19_VendidosDestruidos],
  [DONADOS Y ENTREGADOS PARA DESTRUCCIÓN] as [VPT_Punto19_Donadosentregados],
  [TOTAL DESTRUIDOS] as [VPT_Punto19_TotalDestruidos],
  [GESTION] as [VPT_Punto19_Gestion]
  FROM $(dnf_path)BASE DE DATOS DNF.xlsx
  (ooxml, embedded labels, header is 1 lines, table is [MAQUINAS-DESTRUIDAS]);
