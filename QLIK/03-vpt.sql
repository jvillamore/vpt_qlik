// Consultas específicas para los reportes del Convenio con el Viceministerio de Politica Tributaria (VPT)
//1) Total de Solicitudes de Licencias de Operaciones para Juegos de Loteria, Azar y Sorteos, detallados por empresa, NIT, ciudad, Salones de Juego, Medio de juego y estado del trámite
/*VPTPregunta1:
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
[Año LOVPT]
resident solicitudLOVPT;*/

// 2) Total de Solicitudes de Autorizaciones para Promociones Empresariakes y Sorteos con Fines Benéficos, detallados por Departamento, empresa, NIT y Estado del Trámite
VPTPregunta2:
LOAD
     [EmpresaVPT] as [EmpresaVPT], 
     [NITVPT] as [NITVPT], 
     [PromocionVPT]   as [PromocionVPT] , 
     [OficinaVPT]  as [OficinaVPT], 
     [TipoProcesoVPT]   as   [TipoProcesoVPT],
     [Fecha Emisión RAA VPT]    as   [Fecha Emisión RAA VPT],
     [EstadoAutorizacionVPT]    as   [EstadoAutorizacionVPT],
     [CiteResolucionVPT]    as   [CiteResolucionVPT], 
     [TramiteID]   as  [Número Trámite],  
     [Fecha Inicio Proceso VPT]    as   [Fecha Inicio Proceso VPT], 
     [FechaComodin VPT]    as   [FechaComodin VPT],
     [EstadoAutorizacionActualVPT]  as [EstadoAutorizacionActualVPT];
SQL
select EmpresaVPT,NITVPT,PromocionVPT,OficinaVPT,TipoProcesoVPT,[Fecha Emisión RAA VPT],
	EstadoAutorizacionVPT,CiteResolucionVPT,TramiteID,[Fecha Inicio Proceso VPT],[FechaComodin VPT],EstadoAutorizacionActualVPT
from vpt.ViewSolicitAutoriz

// 12) Cantidad de Autos de Apertura de Procesos Administrativ os emitidos por departamento, empresa y NIT


/*
VPTPregunta2:
LOAD
     [EmpresaVPT] as [EmpresaVPT], 
     [NITVPT] as [NITVPT], 
     [PromocionVPT]   as [PromocionVPT] , 
     [OficinaVPT]  as [OficinaVPT], 
     [TipoProcesoVPT]   as   [TipoProcesoVPT],
     [Fecha Emisión RAA VPT]    as   [Fecha Emisión RAA VPT],
     [EstadoAutorizacionVPT]    as   [EstadoAutorizacionVPT],
     [CiteResolucionVPT]    as   [CiteResolucionVPT], 
     [TramiteID]   as  [Número Trámite],  
     [Fecha Inicio Proceso VPT]    as   [Fecha Inicio Proceso VPT], 
     [FechaComodin VPT]    as   [FechaComodin VPT],
     [EstadoAutorizacionActualVPT]  as [EstadoAutorizacionActualVPT];
SQL
select pe.NombreEmpresa								'EmpresaVPT', 
       pe.DocumentoIdentidad						'NITVPT', 
	   pe.NombrePromocion							'PromocionVPT', 
       case
         when pe.Oficina='DIRECCION NACIONAL'            then 'DNAL'
         when pe.Oficina='DIRECCION REGIONAL COCHABAMBA' then 'DRCB'
	     when pe.Oficina='DIRECCION REGIONAL SANTA CRUZ' then 'DRSC'
    	 when pe.Oficina='DIRECCION REGIONAL LA PAZ'     then 'DRLP'
	     end										'OficinaVPT', 
	   pe.TipoProceso								'TipoProcesoVPT', 
	   pe.FechaAutorizacionRechazo					'Fecha Emisión RAA VPT',
	   pe.EstadoAutorizacionMensual					'EstadoAutorizacionVPT', 
	   pe.CiteAutorizacionRechazo					'CiteResolucionVPT', 
	   pe.TramiteID,  
	   convert (date ,pe.FechaInicioProceso)		'Fecha Inicio Proceso VPT', 
	   convert (date ,pe.FechaInicioProceso)		'FechaComodin VPT',
	   pe.EstadoAutorizacion                        'EstadoAutorizacionActualVPT'
  from [AlmacenCorporativo.PromocionesEmpresariales] pe
 where pe.EstadoAutorizacionMensual =  'EN PROCESO' 
   and pe.EstadoAutorizacion        in ('AUTORIZADA','RECHAZADA')
   and pe.EstadoPromocion           =  'ACTIVO'
 union
select pe.NombreEmpresa								'EmpresaVPT', 
	   pe.DocumentoIdentidad						'NITVPT', 
	   pe.NombrePromocion							'PromocionVPT', 
       case
         when pe.Oficina='DIRECCION NACIONAL'             then 'DNAL'
         when pe.Oficina='DIRECCION REGIONAL COCHABAMBA'  then 'DRCB'
	     when pe.Oficina='DIRECCION REGIONAL SANTA CRUZ'  then 'DRSC'
    	 when pe.Oficina='DIRECCION REGIONAL LA PAZ'      then 'DRLP'
	     end 										'OficinaVPT', 
	   pe.TipoProceso								'TipoProcesoVPT', 
	   pe.FechaAutorizacionRechazo					'Fecha Emisión RAA VPT',
	   pe.EstadoAutorizacionMensual					'EstadoAutorizacionVPT', 
	   pe.CiteAutorizacionRechazo					'CiteResolucionVPT', 
	   pe.TramiteID ,  
	   convert (date ,pe.FechaInicioProceso)		'Fecha Inicio Proceso VPT', 
	   convert (date ,pe.FechaInicioProceso)		'FechaComodin VPT',
	   pe.EstadoAutorizacion                        'EstadoAutorizacionActualVPT'
  from [AlmacenCorporativo.PromocionesEmpresariales] pe
 where pe.EstadoAutorizacionMensual	= 'EN PROCESO' 
   and pe.EstadoAutorizacion		= 'EN PROCESO' 
   and pe.EstadoPromocion			= 'ACTIVO'
 union
select pe.NombreEmpresa, 
       pe.DocumentoIdentidad, 
	   pe.NombrePromocion,   
	   case
         when pe.Oficina='DIRECCION NACIONAL'             then 'DNAL'
         when pe.Oficina='DIRECCION REGIONAL COCHABAMBA'  then 'DRCB'
	     when pe.Oficina='DIRECCION REGIONAL SANTA CRUZ'  then 'DRSC'
    	 when pe.Oficina='DIRECCION REGIONAL LA PAZ'      then 'DRLP'
	   end 	, 
	   pe.TipoProceso								'TipoProcesoVPT', 
	   tra.FechaRecepcionSecretaria					'Fecha Emisión RAA',
	   pe.EstadoAutorizacionMensual, 
	   pe.CiteAutorizacionRechazo, 
	   pe.TramiteID,  
	   convert (date ,pe.FechaInicioProceso)		'Fecha Inicio Proceso',
	   convert (date ,pe.FechaInicioProceso)		'FechaComodin',
	   pe.EstadoAutorizacion                        'EstadoAutorizacionActualVPT'
  from [AlmacenCorporativo.PromocionesEmpresariales] pe,
       [AlmacenCorporativo.Tramites] tra
 where pe.EstadoAutorizacionMensual = 'EN PROCESO' 
   and pe.EstadoAutorizacion		= 'DESISTIDA'
   and pe.EstadoPromocion			= 'ACTIVO'
   and tra.TipoEstadoTramite		= 'ACEPTADO'
   and tra.TramiteAsociadoID		= pe.TramiteID
 union
select pe.NombreEmpresa, 
       pe.DocumentoIdentidad, 
	   pe.NombrePromocion,   
	   case
         when pe.Oficina='DIRECCION NACIONAL'             then 'DNAL'
         when pe.Oficina='DIRECCION REGIONAL COCHABAMBA'  then 'DRCB'
	     when pe.Oficina='DIRECCION REGIONAL SANTA CRUZ'  then 'DRSC'
    	 when pe.Oficina='DIRECCION REGIONAL LA PAZ'      then 'DRLP'
	   end 	, 
	   pe.TipoProceso, 
	   pe.FechaAutorizacionRechazo'Fecha Emisión RAA',
	   pe.EstadoAutorizacion, 
	   pe.CiteAutorizacionRechazo, 
	   pe.TramiteID, 
	   convert (date ,pe.FechaInicioProceso) 'Fecha Inicio Proceso', 
	   convert (date ,pe.FechaAutorizacionRechazo) 'FechaComodin',
	   pe.EstadoAutorizacion                        'EstadoAutorizacionActualVPT'
  from [AlmacenCorporativo.PromocionesEmpresariales] pe
 where pe.EstadoAutorizacion  in ('AUTORIZADA', 'RECHAZADA')
   and pe.EstadoPromocion     =  'ACTIVO'
 union
select pe.NombreEmpresa, 
       pe.DocumentoIdentidad, 
	   pe.NombrePromocion,   
	   case
         when pe.Oficina='DIRECCION NACIONAL'             then 'DNAL'
         when pe.Oficina='DIRECCION REGIONAL COCHABAMBA'  then 'DRCB'
	     when pe.Oficina='DIRECCION REGIONAL SANTA CRUZ'  then 'DRSC'
    	 when pe.Oficina='DIRECCION REGIONAL LA PAZ'      then 'DRLP'
	   end 	, 
	   pe.TipoProceso, 
	   tra.FechaEfectivizacionTramite 'Fecha Emisión RAA',
	   pe.EstadoAutorizacion, 
	   pe.CiteAutorizacionRechazo, 
	   pe.TramiteID,   
	   convert (date ,pe.FechaInicioProceso) 'Fecha Inicio Proceso',
	   convert (date ,tra.FechaEfectivizacionTramite) 'FechaComodin',
	   pe.EstadoAutorizacion                        'EstadoAutorizacionActualVPT'
  from [AlmacenCorporativo.PromocionesEmpresariales] pe,
       [AlmacenCorporativo.Tramites] tra
 where pe.EstadoAutorizacion	= 'DESISTIDA'
   and pe.EstadoPromocion		= 'ACTIVO'
   and tra.TipoEstadoTramite IN ('ACEPTADO','DESISTIDA') //Agregado Para DESISTIDA 20220406
   and tra.TramiteAsociadoID	= pe.TramiteID
   and pe.CiteAutorizacionRechazo = '' //agregado 20171012
*/

//agregado 20171012
/*union
select pe.NombreEmpresa, 
       pe.DocumentoIdentidad, 
	   pe.NombrePromocion,   
	   case
         when pe.Oficina='DIRECCION NACIONAL'             then 'DNAL'
         when pe.Oficina='DIRECCION REGIONAL COCHABAMBA'  then 'DRCB'
	     when pe.Oficina='DIRECCION REGIONAL SANTA CRUZ'  then 'DRSC'
    	 when pe.Oficina='DIRECCION REGIONAL LA PAZ'      then 'DRLP'
	   end 	, 
	   pe.TipoProceso, 
	   tra.FechaEfectivizacionTramite 'Fecha Emisión RAA',
	   'AUTORIZADA' 'EstadoAutorizacion', 
	   pe.CiteAutorizacionRechazo, 
	   pe.TramiteID,   
	   convert (date ,pe.FechaInicioProceso) 'Fecha Inicio Proceso',
	   convert (date ,tra.FechaEfectivizacionTramite) 'FechaComodin',
	   'AUTORIZADA'                        'EstadoAutorizacionActualVPT'
  from [AlmacenCorporativo.PromocionesEmpresariales] pe,
       [AlmacenCorporativo.Tramites] tra
 where pe.EstadoAutorizacion	= 'DESISTIDA'
   and pe.EstadoPromocion		= 'ACTIVO'
   and tra.TipoEstadoTramite	= 'ACEPTADO'
   and tra.TramiteAsociadoID	= pe.TramiteID
   and pe.CiteAutorizacionRechazo like '%/RAA/%'
union
select pe.NombreEmpresa, 
       pe.DocumentoIdentidad, 
	   pe.NombrePromocion,   
	   case
         when pe.Oficina='DIRECCION NACIONAL'             then 'DNAL'
         when pe.Oficina='DIRECCION REGIONAL COCHABAMBA'  then 'DRCB'
	     when pe.Oficina='DIRECCION REGIONAL SANTA CRUZ'  then 'DRSC'
    	 when pe.Oficina='DIRECCION REGIONAL LA PAZ'      then 'DRLP'
	   end 	, 
	   pe.TipoProceso, 
	   tra.FechaEfectivizacionTramite 'Fecha Emisión RAA',
	   'RECHAZADA' 'EstadoAutorizacion', 
	   pe.CiteAutorizacionRechazo, 
	   pe.TramiteID,   
	   convert (date ,pe.FechaInicioProceso) 'Fecha Inicio Proceso',
	   convert (date ,tra.FechaEfectivizacionTramite) 'FechaComodin',
	   'RECHAZADA'                        'EstadoAutorizacionActualVPT'
  from [AlmacenCorporativo.PromocionesEmpresariales] pe,
       [AlmacenCorporativo.Tramites] tra
 where pe.EstadoAutorizacion	= 'DESISTIDA'
   and pe.EstadoPromocion		= 'ACTIVO'
   and tra.TipoEstadoTramite	= 'ACEPTADO'
   and tra.TramiteAsociadoID	= pe.TramiteID
   and pe.CiteAutorizacionRechazo like '%/RAR/%'*/;
   
// 3) Número de Fiscalizaciones Concluidas Realizadas a las actividades de Juegos de Loteria, Azar y Sorteos autorizados por departamento, empresa y NIT
/*
FiscalizacionesLoteriaAzarSorteos:
LOAD
 [OrdenFiscalizacion]  as  [OrdenFiscalizacion VPT],
       [NombreEmpresa]   as  [Empresa VPTJL],
	   [DocumentoIdentidad]   as  [DocumentoIdentidad VPTJL],
	   [DirecciónEmpresa]   as [Dirección Empresa VPTJL] ,
	   [ResolucionAutorizacion]  as [RALO]  ,
       [Alcance]  as  [Alcance VPTJL] ,
       [PeriodoInicio]  as  [Periodo Inicio VPTJL],
[PeriodoFin]  as  [Periodo Fin VPTJL] ,
[EquipoAsignado]  as [Equipo Asignado VPTJL] ,
[FechaAsignación]  as [Fecha Asignación VPTJL] ,
[MemorandumAsignacion]  as  [Memorandum Asignacion VPTJL],
[EquipoReasignado]  as [Equipo Reasignado VPTJL] ,
[FechaGeneracionEmision]  as [Fecha Generacion Emision VPTJL] ,
[FechaNotificacion]  as  [Fecha Notificacion VPTJL],
[InformeFiscalizacion]  as  [Informe Fiscalizacion VPTJL],
[FechaInformeFiscalizacion]  as  [Fecha Informe Fiscalizacion VPTJL],
[Recomendacion]  as [Recomendacion VPTJL] ,
[SancionImpuesta]  as [Sancion Impuesta VPTJL] ,
[Departamento]  as  [Departamento VPTJL],
[FechaResolucion]  as  [Fecha RALO],
[MesConclusion]  as [Mes Conclusion VPTJL] ,
[Estado]  as [Estado Fiscalizacion VPTJL] ,
[Gestion]  as  [Gestión VPTJL];
sql
select [OrdenFiscalizacion],
       [NombreEmpresa] ,
	   [DocumentoIdentidad] ,
	   [DirecciónEmpresa] ,
	   [ResolucionAutorizacion],
       [Alcance],
       [PeriodoInicio],
[PeriodoFin],
[EquipoAsignado],
[FechaAsignación],
[MemorandumAsignacion],
[EquipoReasignado],
[FechaGeneracionEmision],
[FechaNotificacion],
[InformeFiscalizacion],
[FechaInformeFiscalizacion],
[Recomendacion],
[SancionImpuesta],
[Departamento],
[FechaResolucion],
[MesConclusion],
[Estado],
[Gestion]
  FROM [MINAJPRODUCCION].[dbo].[ODS.FiscalizacionJuegosLoteriaAzarSorteoTemp];
  */
  // 4) Número de Fiscalizaciones concluidas realizadas a las actividades de Promociones Empresariales y Sorteos con Fines Benéficos autorizados, por departamento, empresa y NIT
  //  Información que se extrae de la tabla Qlikview "ProcesoFiscalizacion"
  
  // 5) Número de Controles realizados a las actividades de Juegos de Lotería, Azar y Sorteos autorizados por departamento, empresa y NIT
  //
  
  // 6) Número de controles realizados a las actividades de promociones empresariales y Sorteos con Fines Benéficos autorizados y no autorizados por departamento,m empresa y NIT
  //
  
  // 7) Número de Intervenciones a salones de juego y Lugares de Juego por departamento, empresa y NIT
  // 8) Número de máquinas de juego y/o medios de juego decomisados  por intervención, departamento, empresa y NIT
  // la información para las preguntas 7) y 8) se extrae de la tabla Qlikview "IntervencionesSalasDeJuego"
  
  // 9) Cantidad de Resoluciones Sancionatorias emitidas por departamento, empresa y NIT
  // 10) Montos de Sanciones impuestas a las actividades de Juego de Lotería, Azar y Sorteos por Departamento, empresa y NIT
  // 11) Montos de Sanciones impuestas a Promociones empresariales y Sorteos con Fines Beneficos por Departamento, empresa y NIT
  VPTPregunta9_10_11:
  LOAD
  'DNAL'  as [OFICINA DNJ],
   [RAZON SOCIAL RS]  as [RAZÓN SOCIAL/ NOMBRE COMPLETO DNJ],
   [NIT RS]   AS   [NIT DNJ],
   [DEPARTAMENTO RS]   AS   [DEPARTAMENTO DNJ]  ,
   [RESOLUCION RS]  AS   [CODIGO RS DNJ],
   [FECHA RESOLUCION RS]  AS   [FECHA EMISION RS DNJ],
    [MONTO RESOLUCION RS]  AS   [MONTOUFV RS DNJ],
   'JUEGOS DE AZAR Y SORTEOS'   as [ACTIVIDAD DNJ],
   [OBSERVACIONES RS]  AS   [OBSERVACIONES RS DNJ] 
  resident ResolucionesRSDNJ;
  Concatenate (VPTPregunta9_10_11)
  LOAD 
  [Dirección Sanción]  as [OFICINA DNJ],
  [Nombre/Empresa Sanción] as [RAZÓN SOCIAL/ NOMBRE COMPLETO DNJ],
  [Documento Identidad Sanción]  as  [NIT DNJ],
  [Departamento Sanción] as  [DEPARTAMENTO DNJ],
  Text( [Código Cite RS])  as  [CODIGO RS DNJ],
 // [Cite RS]  as  [CITE RS DNJ],
  [Fecha Cite RS]  as   [FECHA EMISION RS DNJ],
  [MontoUFV RS]  as   [MONTOUFV RS DNJ],
//   [Estado Cite RS]   as  [ESTADO RS DNJ],
   'PE-SFB'  as  [ACTIVIDAD DNJ] 
    resident DetalleProcesoSancionador
    where  [Estado Cite RS]='ACTIVO';
    
  // 12) Monto de Sanciones efectivamente cobradas
   // Información que se extrae de la tabla Qlikview "DetallePagoSanciones"
  
  // 13) Cantidad de Recursos de Revocatoria por departamento, empresa, NIT y estado de trámite
     // Información que se extrae de la tabla Qlikview "RecursoRevocatoriaPE"[NRO RS], 
  VPTPregunta13:
  load  
[RAZON SOCIAL RR],
[NIT O CI RR],
[DEPARTAMENTO RR],
[N° PROVEIDO RR],
[FECHA PROVEIDO RR],
[ESTADO DEL TRAMITE RR]
    resident RecursoRevocatoriaPE;
  // 14) Cantidad de Recursos Jerárquicos  por departamento, empresa, NIT y estado de trámite
  
VPTPregunta15_2:
load  
[RAZON SOCIAL RRC],
[NIT O CI RRC],
[DEPARTAMENTO RRC],
[N° RESOLUCION RRC],
[FECHA RRC],
[FORMA RESOLUCION RRC]
resident RecursoRevocatoriaCONFIRMADAS;  
  
 VPTPregunta14:
  load  
  [RAZON SOCIAL RJ] ,
  [NIT RJ]   ,
  [DEPARTAMENTO RJ] , 
  [PROVEÍDO RJ] , 
  [FECHA PROVEIDO RJ] , 
  [ESTADO DEL TRAMITE RJ] 
  resident RecursoJerarquicoPE  ;

VPTPregunta16_2:
load  
[RAZON SOCIAL RJC],
[NIT O CI RJC],
[DEPARTAMENTO RJC],
[N° RESOLUCION RJC],
[FECHA RJC],
[RESUELVE RJC]
resident RecursoJerarquicoCONFIRMADOS; 

  // 15) Valor de Premios ofertados en Promociones Empresariales autorizados por dirección regional, empresa y NIT.
  // Información que se extrae de la tabla Qlikview "DetallePromociones"

VPTIndicadoresGestion:
LOAD
	[Ejecutado] as [Ejecutado],
	[NumeroIndicador] as [NumeroIndicadorVPT],
	[MetaAnualValor] as [MetaAnualVPT],
	[Numerador] as [NumeradorVPT],//
	[Denominador] as [DenominadorVPT],
	[CantidadFiscalizadores] as [CantidadFiscalizadoresVPT],
	[NumeroMes] as [NumeroMesVPT],
	[Mes] as [MesVPT],
	[Gestion] as [GestionVPT];
SQL
select 
	(
		case 
		when NumeroIndicador = 1
			then (
		select
			count(*)
		from
			[ODS.VPTResolucionesRegulatorias] as rr
		where
            -- Se agrega la condición para quitar la normativa sin resolución
			rr.NumeroResolucion !='' and
            Gestion = YEAR(rr.fecharesolucion)
			and NumeroMes >= MONTH(rr.fecharesolucion))
		when NumeroIndicador = 2
			then (
		select
			count(*)
		from
			[ODS.VPTLicenciasOperaciones] as lo
		where
			Gestion = YEAR(lo.Periodo)
				and NumeroMes >= MONTH(lo.Periodo))
		when NumeroIndicador = 3
		and Gestion >= 2024
			then ( Numerador)
		when NumeroIndicador = 3
		and Gestion <= 2023
			then
		--(select count(*) from vpt.pregunta3 as lo where Gestion = YEAR(lo.[FechaComodin VPT]) and NumeroMes>= MONTH(lo.[FechaComodin VPT]))
		   case
			when Gestion = 2023 then
				(
			select
				sum(tra.CantidadDesistidoConfirmado)+ sum(tra.CantidadAutorizado)+ sum(tra.CantidadRechazado)
			from
				dbo.[Datawarehouse.THPromociones] tra
			join dbo.[Datawarehouse.DimTiempo] ti on
				ti.DimTiempoID = tra.DimTiempoID
			where
				year(ti.FechaIngles)= Gestion
					and month(ti.FechaIngles)<= NumeroMes)
			else			
			(
			select
				( 
				(
				select
					count(*)
				from
					[AlmacenCorporativo.PromocionesEmpresariales] pe
				where
					pe.EstadoAutorizacion in ('AUTORIZADA', 'RECHAZADA', 'DESISTIDA')
						and pe.EstadoPromocion = 'ACTIVO'
						and 
					year(pe.FechaAutorizacionRechazo) = Gestion
							and NumeroMes >= month(pe.FechaAutorizacionRechazo)
								and pe.CiteAutorizacionRechazo <> '') + 
					(
						CASE
							WHEN Gestion = 2017
							THEN
								(
					select
						count(*)
					from
						[AlmacenCorporativo.PromocionesEmpresariales] pe,
						[AlmacenCorporativo.Tramites] tra
					where
						pe.EstadoAutorizacion = 'DESISTIDA'
						and pe.EstadoPromocion = 'ACTIVO'
						and tra.TipoEstadoTramite = 'ACEPTADO'
						and tra.TramiteAsociadoID = pe.TramiteID
						and pe.CiteAutorizacionRechazo <> ''
						and year(tra.FechaEfectivizacionTramite) = Gestion
							and NumeroMes >= month(tra.FechaEfectivizacionTramite))
					WHEN Gestion = 2018
							THEN
								(
					select
						count(*)
					from
						[AlmacenCorporativo.PromocionesEmpresariales] pe,
						[AlmacenCorporativo.Tramites] tra
					where
						pe.EstadoAutorizacion = 'DESISTIDA'
						and pe.EstadoPromocion = 'ACTIVO'
						and tra.TipoEstadoTramite = 'ACEPTADO'
						and tra.TramiteAsociadoID = pe.TramiteID
						and pe.CiteAutorizacionRechazo = ''
						and year(tra.FechaEfectivizacionTramite) = Gestion
							and NumeroMes >= month(tra.FechaEfectivizacionTramite))
					WHEN Gestion >= 2019
							THEN
								(
					select
						count(*)
					from
						[AlmacenCorporativo.PromocionesEmpresariales] pe,
						[AlmacenCorporativo.Tramites] tra
					where
						pe.EstadoPromocion = 'ACTIVO'
						and tra.TipoEstadoTramite = 'ACEPTADO'
						and tra.TramiteAsociadoID = pe.TramiteID
						and year(tra.FechaEfectivizacionTramite) = Gestion
							and NumeroMes >= month(tra.FechaEfectivizacionTramite))
					ELSE 0
				END
					)
				)
			)
		end
		when NumeroIndicador = 4
			then (
		select
			sum(TotalFiscalizaciones)
		from
			[ODS.VPTFiscalizacionesJLAS] as jlas
		where
			Gestion = YEAR(jlas.Periodo)
				and NumeroMes >= MONTH(jlas.Periodo))
		when NumeroIndicador = 5
		and Gestion <= 2023
			then (
		select
			sum(TotalFiscalizaciones)
		from
			[ODS.VPTFiscalizacionesPE] as pe
		where
			Gestion = YEAR(pe.Periodo)
				and NumeroMes >= MONTH(pe.Periodo))
		when NumeroIndicador = 5
		and Gestion >= 2024
			then (
		SELECT
			sum(TotalFiscalizaciones)
		FROM
			vpt.fiscalizaciones_pe
		where
			year(Periodo)= Gestion
				and month(Periodo)<= NumeroMes)
		when NumeroIndicador = 6
			then (
		select
			sum(TotalControles)
		from
			[ODS.VPTControlesJLAS] as jlas
		where
			Gestion = YEAR(jlas.Periodo)
				and NumeroMes >= MONTH(jlas.Periodo))
		when NumeroIndicador = 7
		and Gestion <= 2023
			then (
		select
			sum(TotalControles)
		from
			[ODS.VPTControlesPE] as pe
		where
			pe.TipoActividad = 'PROMOCIONES EMPRESARIALES'
			and Gestion = YEAR(pe.Periodo)
				and NumeroMes >= MONTH(pe.Periodo))
		when NumeroIndicador = 7
		and Gestion >= 2024			
			then (
		select
			sum(isnull(lpz, 0)+ isnull(oru, 0)+ isnull(pot, 0) + isnull(cbba, 0) + isnull(chq, 0) + isnull(tja, 0) + isnull(scz, 0) + isnull(ben, 0) + isnull(pan, 0))
		from
			vpt.controles_pe cp
		where
			anio = Gestion
			and [vpt].fnMesNumerico(cp.mes)<= NumeroMes)
		when NumeroIndicador = 8
		and Gestion <= 2023
			then
			 CASE
				WHEN Gestion <= 2023 then (
			select
				sum(CantidadIntervenciones)
			from
				[ODS.VPTIntervenciones] as inte
			where
				Gestion = YEAR(inte.Periodo)
					and NumeroMes >= MONTH(inte.Periodo))
			ELSE (
			SELECT
				sum(TotalControles)
			from
				[ODS.VPTControlesPE] ovp
			where
				year(ovp.Periodo)= Gestion
					and month(Periodo)<= NumeroMes
						and upper(ltrim(rtrim(TipoActividad))) like '%VISITA%')
		END
		when NumeroIndicador = 8
		and Gestion >= 2024			
			then (
		select
			sum(isnull(lpz, 0)+ isnull(oru, 0)+ isnull(pot, 0) + isnull(cbba, 0)+ isnull(chq, 0) + isnull(tja, 0)+ isnull(scz, 0)+ isnull(tri, 0)+ isnull(cob, 0))
		from
			vpt.visitas_pe
		where
			anio = Gestion
			and [vpt].fnMesNumerico(mes)<= NumeroMes)
		when NumeroIndicador = 9
		then
		  case
			when Gestion <= 2023 then
		   case
				when Gestion >= 2023 then (
				select
					count(*)
				from
					[ODS.VPTResolucionesSancionatoriasMontosImpuestos] as rs
				where
					Gestion = YEAR(rs.Periodo)
						and NumeroMes >= MONTH(rs.Periodo))
				else
			(
				(
				select
					count(*)
				from
					[ODS.VPTResolucionesSancionatoriasMontos] as rs
				where
					Gestion = YEAR(rs.Periodo)
						and NumeroMes >= MONTH(rs.Periodo)
							and rs.montoufv <> 0) +
				(
				select
					count(*)
				from
					[ODS.VPTResolucionesSancionatoriasMontosImpuestos] as rs
				where
					Gestion = YEAR(rs.Periodo)
						and NumeroMes >= MONTH(rs.Periodo)
							and rs.MontoSancionUFV <> 0) +
				(
					CASE
						WHEN Gestion = 2016
							THEN -75
					----//ajuste por AAPAS generadas el 2015
					----//WHEN Gestion=2017
					----//THEN -2 --//ajuste por AAPAS generadas el 2016
					ELSE 0
				END
				)
			)
			end
			else
		    (
			select
				sum(CantidadIntervenciones)
			from
				[ODS.VPTIntervenciones] as inte
			where
				Gestion = YEAR(inte.Periodo)
					and NumeroMes >= MONTH(inte.Periodo))
		end
		when NumeroIndicador = 10
		and Gestion <= 2023
			then 
			  case
			when Gestion <= 2023 then
			   case
				when Gestion >= 2023 then (
				select
					numerador
				from
					[ODS.VPTIndica_10_11]
				where
					gestion_vpt = Gestion
					and indicador = 10)
				else			
				(
						case
							when Gestion < 2018
								then (
					select
						count(*)
					from
						[ODS.VPTRecursosRevocatorias] as rr
					where
						Gestion = YEAR(rr.Periodo)
							and NumeroMes >= MONTH(rr.Periodo)
								and rr.estadotramite <> 'OBSERVADO')
					else
								(
					select
						count(*)
					from
						[ODS.VPTRecursosRevocatoriasConfirmados] as rrc
					where
						Gestion = YEAR(rrc.Periodo)
							and NumeroMes >= MONTH(rrc.Periodo)
								and rrc.FormaResolucion = 'CONFIRMAR')
				end
					)
			end
			else
				(
			select
				count(*)
			from
				[ODS.VPTResolucionesSancionatoriasMontosImpuestos] as rs
			where
				Gestion = YEAR(rs.Periodo)
					and NumeroMes >= MONTH(rs.Periodo))
		end
		when NumeroIndicador = 10
		and Gestion >= 2024			
			then (
		select
			count(*)
		from
			vpt.ViewMontosSanciones
		where
			year(FechaRS)= Gestion
				and month(FechaRS)<= NumeroMes)
		when NumeroIndicador = 11
		and Gestion <= 2023
		 then 
		 case
			when Gestion <= 2023 then
		   case
				when Gestion = 2023 then (
				select
					numerador
				from
					[ODS.VPTIndica_10_11]
				where
					gestion_vpt = Gestion
					and indicador = 11)
				else				
			(
					case
						when Gestion < 2018
							then (
					select
						count(*)
					from
						[ODS.VPTRecursosJerarquicos] as rj
					where
						Gestion = YEAR(rj.Periodo)
							and NumeroMes >= MONTH(rj.Periodo)
								and rj.estadotramite = 'REMITIDO'
								and RJ.posicionRatificada = 'SI')
					else
							(
					select
						count(*)
					from
						[ODS.VPTRecursosJerarquicosConfirmados] as rjc
					where
						Gestion = YEAR(rjc.Periodo)
							and NumeroMes >= MONTH(rjc.Periodo)
								and rjc.Resuelve = 'CONFIRMAR')
				end
				)
			end
			else
			(
			select
				numerador
			from
				[ODS.VPTIndica_10_11]
			where
				gestion_vpt = Gestion
				and indicador = 10)
		end
		when NumeroIndicador = 11
		and Gestion >= 2024			
			then (
				select
							count(*)
				from
							[ODS.VPTRecursosRevocatoriasConfirmados]
				where
					( (year(Periodo)<= 2023
						and FormaResolucion like '%CONFIRM%' COLLATE Latin1_General_CI_AS)
					or (year(Periodo)>= 2024
						and FormaResolucion not in('REVOCA', 'REVOCA TOTALMENTE', 'REVOCAR', 'REVOCAR TOTALMENTE')) )
					and year(Periodo)= Gestion
					and month(Periodo)<= NumeroMes
				)
		when NumeroIndicador = 12
		and Gestion <= 2023
		 then 
		 case
			when Gestion <= 2023 then
			(
				case
				----//Anterior condicion
				----//when Gestion < 2021
					when Gestion <= 2022
				----//modificacion 26/04/2022
					then
						(
				select
					count(*)
				from
					[ODS.VPTDenunciasReclamos] as dr
				where
					Gestion = YEAR(dr.Periodo)
						and NumeroMes >= MONTH(dr.Periodo)
							and dr.estado <> 'EN PROCESO')
				else
				----//(select sum(TotalFiscalizaciones) from [ODS.VPTFiscalizacionesJLAS] as jlas where Gestion = YEAR(jlas.Periodo) and NumeroMes>= MONTH(jlas.Periodo)) --//+
						(
				select
					sum(TotalFiscalizaciones)
				from
					[ODS.VPTFiscalizacionesPE] as pe
				where
					Gestion = YEAR(pe.Periodo)
						and NumeroMes >= MONTH(pe.Periodo))
			end	
			)
			else
			(
			select
				count(*)
			from
				[ODS.VPTRecursosJerarquicosConfirmados] as rjc
			where
				Gestion = YEAR(rjc.Periodo)
					and NumeroMes >= MONTH(rjc.Periodo)
						and rjc.Resuelve = 'CONFIRMAR')
		end
        -- Registros de la tabla [ODS.VPTIndicadoresGestion]
        when NumeroIndicador = 12
		and Gestion >= 2024
            then (Numerador)
         ------   
		when NumeroIndicador = 13
		and Gestion <= 2023
		  then
		----//case when Gestion=2023 then 1378
		----//else (select sum(TotalControles) from [ODS.VPTControlesPE] as pe where pe.TipoActividad='PROMOCIONES EMPRESARIALES' and Gestion = YEAR(pe.Periodo) and NumeroMes>= MONTH(pe.Periodo))
			(
				case
			------//Anterior condicion
			--//when Gestion < 2021
					when Gestion <= 2022
			--//modificacion 26/04/2022
					then
						(
			select
				sum(TotalFiscalizaciones)
			from
				[ODS.VPTFiscalizacionesJLAS] as jlas
			where
				Gestion = YEAR(jlas.Periodo)
					and NumeroMes >= MONTH(jlas.Periodo)) +
						(
			select
				sum(TotalFiscalizaciones)
			from
				[ODS.VPTFiscalizacionesPE] as pe
			where
				Gestion = YEAR(pe.Periodo)
					and NumeroMes >= MONTH(pe.Periodo)) +
						(
			select
				sum(TotalControles)
			from
				[ODS.VPTControlesJLAS] as jlas
			where
				Gestion = YEAR(jlas.Periodo)
					and NumeroMes >= MONTH(jlas.Periodo)) + 
						(
			select
				sum(TotalControles)
			from
				[ODS.VPTControlesPE] as pe
			where
				Gestion = YEAR(pe.Periodo)
					and NumeroMes >= MONTH(pe.Periodo))+
						(
			select
				sum(CantidadIntervenciones)
			from
				[ODS.VPTIntervenciones] as inte
			where
				Gestion = YEAR(inte.Periodo)
					and NumeroMes >= MONTH(inte.Periodo))
			else
			--//(select sum(TotalControles) from [ODS.VPTControlesJLAS] as jlas where Gestion = YEAR(jlas.Periodo) and NumeroMes>= MONTH(jlas.Periodo)) + 
						(
			select
				sum(TotalControles)
			from
				[ODS.VPTControlesPE] as pe
			where
				Gestion = YEAR(pe.Periodo)
					and NumeroMes >= MONTH(pe.Periodo))
		end
			)
		when NumeroIndicador = 13
		and Gestion >= 2024
			then (
		select
			count(*)
		from
			vpt.fiscalizaciones_pe
		where
			year(Periodo)= Gestion
				and month(Periodo)<= NumeroMes )
		when NumeroIndicador = 14
		and Gestion >= 2024
			then (
		select
			sum(isnull(lpz, 0)+ isnull(oru, 0)+ isnull(pot, 0) + isnull(cbba, 0) + isnull(chq, 0) + isnull(tja, 0) + isnull(scz, 0) + isnull(ben, 0) + isnull(pan, 0))
		from
			vpt.controles_pe cp
		where
			anio = Gestion
			and [vpt].fnMesNumerico(cp.mes)<= NumeroMes) + (
		select
			sum(isnull(lpz, 0)+ isnull(oru, 0)+ isnull(pot, 0) + isnull(cbba, 0)+ isnull(chq, 0) + isnull(tja, 0)+ isnull(scz, 0)+ isnull(tri, 0)+ isnull(cob, 0))
		from
			vpt.visitas_pe
		where
			anio = Gestion
			and [vpt].fnMesNumerico(mes)<= NumeroMes)
		--//  end
	end
	) as Ejecutado,
	NumeroIndicador,
	MetaAnualValor,
	Numerador,
	--//CALCULO DE DENOMINADOR INDICADORES 3,9,10, 11,12,13
	case 
		when NumeroIndicador = 3
		and Gestion >= 2024
			then ( Denominador)
		when NumeroIndicador = 3
		and Gestion <= 2023
		then 
		   case
			when Gestion >= 2023 then 
				(
			select
				sum(tra.CantidadDesistidoConfirmado)+ sum(tra.CantidadAutorizado)+ sum(tra.CantidadRechazado)
			from
				dbo.[Datawarehouse.THPromociones] tra
			join dbo.[Datawarehouse.DimTiempo] ti on
				ti.DimTiempoID = tra.DimTiempoID
			where
				year(ti.FechaIngles)= Gestion
					and month(ti.FechaIngles)<= NumeroMes)
			else		
			(
			select 
				(
					(
				select
					count(*)
				from
					[AlmacenCorporativo.PromocionesEmpresariales] pe
				where
					pe.EstadoAutorizacionMensual = 'EN PROCESO'
					and pe.EstadoAutorizacion in ('AUTORIZADA', 'RECHAZADA')
						and pe.EstadoPromocion = 'ACTIVO'
						and year(pe.FechaInicioProceso) = Gestion
							and NumeroMes >= month(pe.FechaInicioProceso))+
					(
				select
					count(*)
				from
					[AlmacenCorporativo.PromocionesEmpresariales] pe,
					[AlmacenCorporativo.Tramites] tra
				where
					pe.EstadoAutorizacionMensual = 'EN PROCESO'
					and pe.EstadoAutorizacion = 'DESISTIDA'
					and pe.EstadoPromocion = 'ACTIVO'
					and tra.TipoEstadoTramite = 'ACEPTADO'
					and tra.TramiteAsociadoID = pe.TramiteID
					and year(pe.FechaInicioProceso) = Gestion
						and NumeroMes >= month(pe.FechaInicioProceso)) +
				--//(select count(*) from [AlmacenCorporativo.PromocionesEmpresariales] pe 
				--//where pe.EstadoAutorizacion  in ('AUTORIZADA', 'RECHAZADA') and pe.EstadoPromocion = 'ACTIVO' and year(pe.FechaAutorizacionRechazo) = Gestion and NumeroMes>= month(pe.FechaAutorizacionRechazo)) +
					(
				select
					count(*)
				from 
					(
					select
						distinct PromocionEmpresarialID,
						TramiteID,
						PersonaID,
						Oficina,
						TipoProceso,
						HojaRuta,
						NombreEmpresa,
						DocumentoIdentidad,
						NombrePromocion,
						CiteAutorizacionRechazo,
						CodigoCiteAutorizacionRechazo
					from
						[AlmacenCorporativo.PromocionesEmpresariales] pe
					where
						pe.EstadoAutorizacion in ('AUTORIZADA', 'RECHAZADA')
							and pe.EstadoPromocion = 'ACTIVO'
							and year(pe.FechaAutorizacionRechazo) = Gestion
								and NumeroMes >= month(pe.FechaAutorizacionRechazo)) t ) +
					(
				select
					count(*)
				from
					[AlmacenCorporativo.PromocionesEmpresariales] pe,
					[AlmacenCorporativo.Tramites] tra
				where
					pe.EstadoAutorizacion = 'DESISTIDA'
					and pe.EstadoPromocion = 'ACTIVO'
					and tra.TipoEstadoTramite = 'ACEPTADO'
					and tra.TramiteAsociadoID = pe.TramiteID
					and year(tra.FechaEfectivizacionTramite) = Gestion
						and NumeroMes >= month(tra.FechaEfectivizacionTramite))
				)
			)
		end
		when NumeroIndicador = 9
			then 
				case
			when Gestion >= 2023 then (
			select
				count(*)
			from
				[ODS.VPTResolucionesSancionatoriasMontosImpuestos] as rs
			where
				Gestion = YEAR(rs.Periodo)
					and NumeroMes >= MONTH(rs.Periodo))
			else
					((
			select
				count(*)
			from
				[ODS.VPTResolucionesSancionatorias] as rs
			where
				Gestion = YEAR(rs.Periodo)
					and NumeroMes >= MONTH(rs.Periodo)) +
						(
							CASE
								WHEN Gestion = 2016
									THEN -78
				--//ajuste por AAPAS generadas el 2015
				ELSE 0
			END
						)
					)
		end
		when NumeroIndicador = 10
		--//then (select count(*) from [ODS.VPTRecursosRevocatorias] as rr where Gestion = YEAR(rr.Periodo) and NumeroMes>= MONTH(rr.Periodo) and rr.estadotramite = 'PRESENTACION') mcs 11.01.2024
		  then 
		   case
			when Gestion <= 2023 then (
			select
				denominador
			from
				[ODS.VPTIndica_10_11]
			where
				gestion_vpt = Gestion
				and indicador = 10)
			else				
			(
			select
				count(*)
			from
				vpt.cant_aapa as rr
			where
				Gestion = YEAR(fecha)
					and NumeroMes >= month(fecha) )
		end
		when NumeroIndicador = 11
		and Gestion <= 2023
			then 
		   case
			when Gestion = 2023 then 47
			when Gestion >= 2024 then 888
			else				
			(
					case
						when Gestion < 2018
							then (
				select
					count(*)
				from
					[ODS.VPTRecursosJerarquicos] as rj
				where
					Gestion = YEAR(rj.Periodo)
						and NumeroMes >= MONTH(rj.Periodo)
							and rj.estadotramite = 'REMITIDO')
				else
				--//(select count(*) from [ODS.VPTRecursosJerarquicos] as rj where Gestion = YEAR(rj.Periodo) and NumeroMes>= MONTH(rj.Periodo) and rj.estadotramite = 'REMITIDO')  mcs 11.01.2024
							(
				select
					count(*)
				from
					vpt.jerarquicos_pe as rr
				where
					Gestion = rr.anio
					and NumeroMes >= rr.mes )
			end
				)
		end
		when NumeroIndicador = 11
		and Gestion >= 2024			
			then (
		select
			count(*)
		from
			dbo.[ODS.VPTRecursosRevocatorias]
		where
			year(Periodo)= Gestion
				and month(Periodo)<= NumeroMes)
		--//when NumeroIndicador=12
		--//	then (select count(*) from [ODS.VPTDenunciasReclamos] as dr where Gestion = YEAR(dr.Periodo) and NumeroMes>= MONTH(dr.Periodo))
		when NumeroIndicador = 12
		and Gestion <= 2023 then CantidadFiscalizadores
                -- Ajuste 
        when NumeroIndicador = 12
		and Gestion >= 2024
        	then ( Denominador)		
		when NumeroIndicador = 13
			then CantidadFiscalizadores
		else Denominador
	end as Denominador,
	CantidadFiscalizadores,
	NumeroMes,
	Mes,
	Gestion
from 
	[ODS.VPTIndicadoresGestion];

VPTMontosAlquileres:
LOAD
[Regional] as [VPTMontoAlquiRegional],
[Departamento] as [VPTMontoAlquiDepartamento],
[Deposito] as [VPTMontoAlquiDeposito],
[MontoBS] as [VPTMontoAlquiMonto],
[Periodo] as [VPTMontoAlquiPeriodo];

SQL
SELECT
	Regional,
    Departamento,
    Deposito,
    MontoBS,
    Periodo
FROM 
	[ODS.VPTMontosAlquileres];


VPTcant_aapa:
LOAD
     [empresa_cant_aapa] as [empresa_cant_aapa], 
     [nit_cant_aapa] as [nit_cant_aapa], 
     [depto_cant_aapa]   as [depto_cant_aapa] , 
     [auto_cant_aapa]  as [auto_cant_aapa], 
     [fecha_cant_aapa]   as   [fecha_cant_aapa],
     [direc_cant_aapa]    as   [direc_cant_aapa],
     [periodo_cant_aapa]    as   [periodo_cant_aapa];
     
SQL     
select empresa empresa_cant_aapa ,nit nit_cant_aapa,depto depto_cant_aapa,auto auto_cant_aapa,fecha fecha_cant_aapa,
case 
	when direccion LIKE '%NACIONAL%' then 'DNAL'
	when direccion LIKE '%LA PAZ%' then 'DRLP'
	when direccion LIKE '%COCHA%' then 'DRCB'
	when direccion LIKE '%SANTA%' then 'DRSC'
	ELSE ''
end direc_cant_aapa ,
cast(month(fecha) as varchar(5))+'/'+cast(year(fecha) as varchar(10)) periodo_cant_aapa
from vpt.cant_aapa
order by 1;

VPTcontrol_pe:
LOAD
    [oficina_control_pe_vpt] as [oficina_control_pe_vpt],
	[empresa_control_pe_vpt] as [empresa_control_pe_vpt],     
	[promo_control_pe_vpt] as [promo_control_pe_vpt],
	[nit_control_pe_vpt] as [nit_control_pe_vpt],
    [mes_control_pe_vpt] as [mes_control_pe_vpt],
	[anio_control_pe_vpt] as [anio_control_pe_vpt],     
	[condicion_control_pe_vpt] as [condicion_control_pe_vpt],
	[tipoact_control_pe_vpt] as [tipoact_control_pe_vpt],
	[observ_control_pe_vpt] as [observ_control_pe_vpt],
    [lpz_control_pe_vpt] as [lpz_control_pe_vpt],
	[oru_control_pe_vpt] as [oru_control_pe_vpt],     
	[pot_control_pe_vpt] as [pot_control_pe_vpt],
	[cbba_control_pe_vpt] as [cbba_control_pe_vpt],
    [chq_control_pe_vpt] as [chq_control_pe_vpt],
	[tja_control_pe_vpt] as [tja_control_pe_vpt],     
	[scz_control_pe_vpt] as [scz_control_pe_vpt],
	[ben_control_pe_vpt] as [ben_control_pe_vpt],
	[pan_control_pe_vpt] as [pan_control_pe_vpt];
      
SQL     
select oficina oficina_control_pe_vpt,empresa empresa_control_pe_vpt, nombrepromocion promo_control_pe_vpt, nit nit_control_pe_vpt,
mes mes_control_pe_vpt, anio anio_control_pe_vpt,condicion condicion_control_pe_vpt,
tipoact tipoact_control_pe_vpt,observ observ_control_pe_vpt,
sum(isnull(lpz,0)) lpz_control_pe_vpt,sum(isnull(oru,0)) oru_control_pe_vpt,sum(isnull(pot,0)) pot_control_pe_vpt,sum(isnull(cbba,0)) cbba_control_pe_vpt,
sum(isnull(chq,0)) chq_control_pe_vpt,sum(isnull(tja,0)) tja_control_pe_vpt,sum(isnull(scz,0)) scz_control_pe_vpt,sum(isnull(ben,0)) ben_control_pe_vpt,
sum(isnull(pan,0)) pan_control_pe_vpt
from vpt.controles_pe cp
group by
oficina ,empresa, nombrepromocion , nit ,mes , anio ,condicion ,tipoact ,observ 
order by 1,2,3;

VPTvisita_pe:
LOAD
    [oficina_visita_pe] as [oficina_visita_pe],
    [lpz_visita_pe] as [lpz_visita_pe],
	[oru_visita_pe] as [oru_visita_pe],     
	[pot_visita_pe] as [pot_visita_pe],
	[cbba_visita_pe] as [cbba_visita_pe],
    [chq_visita_pe] as [chq_visita_pe],
	[tja_visita_pe] as [tja_visita_pe],
	[scz_visita_pe] as [scz_visita_pe],
	[tri_visita_pe] as [tri_visita_pe],
	[cob_visita_pe] as [cob_visita_pe],
	[mes_visita_pe] as [mes_visita_pe],
	[anio_visita_pe] as [anio_visita_pe],
	[observ_visita_pe] as [observ_visita_pe]; 	

SQL
select oficina oficina_visita_pe,isnull(lpz,0)lpz_visita_pe,isnull(oru,0) oru_visita_pe,isnull(pot,0) pot_visita_pe,
isnull(cbba,0) cbba_visita_pe,isnull(chq,0) chq_visita_pe,isnull(tja,0) tja_visita_pe,
isnull(scz,0) scz_visita_pe,isnull(tri,0) tri_visita_pe,isnull(cob,0) cob_visita_pe,mes mes_visita_pe,
anio anio_visita_pe, observ observ_visita_pe
from vpt.visitas_pe;


VPTfiscalizaciones_pe:
LOAD
     [emp_fisca_pe] as [emp_fisca_pe], 
     [nompromo_fisca_pe] as [nompromo_fisca_pe], 
     [nit_fisca_pe]   as [nit_fisca_pe] , 
     [tot_fisca_pe]  as [tot_fisca_pe], 
     [periodo_fisca_pe]   as   [periodo_fisca_pe],
     [oficina_fisca_pe]    as   [oficina_fisca_pe],
     [departamento_fisca_pe]    as   [departamento_fisca_pe],
     [id_fisca_pe]    as   [id_fisca_pe];

     
SQL     
SELECT Empresa emp_fisca_pe,
NombrePromocion nompromo_fisca_pe,NIT nit_fisca_pe,TotalFiscalizaciones tot_fisca_pe,Periodo periodo_fisca_pe,
case 
	when isnull(lpz,0)+isnull(oru,0)+isnull(pot,0) > 0 then 'DRLP'
	when isnull(cbba,0)+isnull(chq,0)+isnull(tja,0) > 0 then 'DRCB'
	when isnull(scz,0)+isnull(ben,0)+isnull(pan,0) > 0 then 'DRSC'
	else ''
end oficina_fisca_pe,
case 
	when isnull(lpz,0)+isnull(oru,0)+isnull(pot,0) > 0 then 'LA PAZ'
	when isnull(cbba,0)+isnull(chq,0)+isnull(tja,0) > 0 then 'COCHABAMBA'
	when isnull(scz,0)+isnull(ben,0)+isnull(pan,0) > 0 then 'SANTA CRUZ'
	else ''
end departamento_fisca_pe,
idFiscalizacionPE   id_fisca_pe
FROM vpt.fiscalizaciones_pe;

VPTfiscalizaciones_jlas:
LOAD
     [empresa_flo] as [empresa_flo], 
     [nit_flo] as [nit_flo], 
     [lpz_flo]   as [lpz_flo] , 
     [oru_flo]  as [oru_flo], 
     [pot_flo]   as   [pot_flo],
     [cbba_flo]    as   [cbba_flo],
     [chq_flo]    as   [chq_flo],
     [tja_flo]    as   [tja_flo],
     [scz_flo]    as   [scz_flo],
     [ben_flo]    as   [ben_flo],
     [pan_flo]    as   [pan_flo],     
     [numeromes_flo]    as   [numeromes_flo],
     [mes_flo]    as   [mes_flo],
     [anio_flo]    as   [anio_flo],
     [observ_flo]    as   [observ_flo];     

SQL     
select Empresa empresa_flo,NIT nit_flo,isnull(lpz,0)lpz_flo,isnull(oru,0) oru_flo,isnull(pot,0) pot_flo,
isnull(cbba,0) cbba_flo,isnull(chq,0) chq_flo,isnull(tja,0) tja_flo,isnull(scz,0) scz_flo,
isnull(ben,0) ben_flo,isnull(pan,0) pan_flo,numeromes numeromes_flo,mes mes_flo,anio anio_flo,observ observ_flo
from vpt.fiscalizaciones_jlas fj;

VPTintervenciones_jlas:
LOAD
     [depto_interv_jlas] as [depto_interv_jlas], 
     [nit_interv_jlas] as [nit_interv_jlas], 
     [empresa_interv_jlas]   as [empresa_interv_jlas] , 
     [salon_interv_jlas]  as [salon_interv_jlas], 
     [cantjuegos_interv_jlas]   as   [cantjuegos_interv_jlas],
     [numeromes_interv_jlas]    as   [numeromes_interv_jlas],
     [año_interv_jlas]    as   [año_interv_jlas],
     [mes_interv_jlas]    as   [mes_interv_jlas],
     [observ_interv_jlas]    as   [observ_interv_jlas];     

SQL
select Departamento depto_interv_jlas,
NIT nit_interv_jlas,RazonSocial empresa_interv_jlas,NombreSalon salon_interv_jlas,
CantidadMediosJuego cantjuegos_interv_jlas,month(Periodo) numeromes_interv_jlas,year(Periodo) año_interv_jlas,
lower(left(datename(month,Periodo),3)) mes_interv_jlas, 'Ninguna' observ_interv_jlas
from [ODS.VPTIntervenciones] ov ;

VPTmontosanciones_pe:
LOAD
     [emp_monto_sancion] as [emp_monto_sancion], 
     [documento_monto_sancion] as [documento_monto_sancion], 
     [depto_monto_sancion]   as [depto_monto_sancion] , 
     [cite_monto_sancion]  as [cite_monto_sancion], 
     [montoufv_monto_sancion]   as   [montoufv_monto_sancion],
     [direccion_monto_sancion]    as   [direccion_monto_sancion],
     [estado_monto_sancion]    as   [estado_monto_sancion],
     [fechars_monto_sancion]    as   [fechars_monto_sancion],
     [estadocite_monto_sancion]    as   [estadocite_monto_sancion],
     [periodo_monto_sancion]    as   [periodo_monto_sancion],
	 [mes_monto_sancion] as [MesFiltro],
	 [anio_monto_sancion] as [AñoFiltro],
     [observ_monto_sancion]    as   [observ_monto_sancion]
	 ;     
SQL     
select
	NombreEmpresa emp_monto_sancion,
	DocumentoIdentidad documento_monto_sancion,
	Departamento depto_monto_sancion,
	CodigoCiteRS cite_monto_sancion,
	MontoUFVRS montoufv_monto_sancion,
	[Dirección Trámite] direccion_monto_sancion,
	EstadoRS estado_monto_sancion,
	FechaRS fechars_monto_sancion,
	[EstadoCiteRS] estadocite_monto_sancion,
	periodo_monto_sancion,
	lower(left(datename(month, FechaRS), 3)) as mes_monto_sancion,
	year(FechaRS) as anio_monto_sancion,
	' ' observ_monto_sancion
from
	vpt.ViewMontosSanciones;

VPTmultas_sigep:
LOAD
     [concepto_multas_sigep] as [concepto_multas_sigep], 
     [recaudacion_multas_sigep] as [recaudacion_multas_sigep], 
     [mes_multas_sigep]   as [mes_multas_sigep] , 
     [gestion_multas_sigep]  as [gestion_multas_sigep], 
     [observacion_multas_sigep]   as   [observacion_multas_sigep];     

SQL     
SELECT concepto concepto_multas_sigep,recaudacion recaudacion_multas_sigep,
mes mes_multas_sigep, gestion gestion_multas_sigep, observacion observacion_multas_sigep
FROM vpt.multas_sigep ms 
order by sec;


VPTrevocatorias_pe:
LOAD
     [razonsocial_revocatorias_pe] as [razonsocial_revocatorias_pe], 
     [nit_revocatorias_pe] as [nit_revocatorias_pe], 
     [departamento_revocatorias_pe]   as [departamento_revocatorias_pe] , 
     [numeroproveido_revocatorias_pe]  as [numeroproveido_revocatorias_pe], 
     [fechaproveido_revocatorias_pe]   as   [fechaproveido_revocatorias_pe],
     [estadotramite_revocatorias_pe]  as [estadotramite_revocatorias_pe], 
     [periodo_revocatorias_pe]   as   [periodo_revocatorias_pe],
     [mes_revocatorias_pe]   as   [mes_revocatorias_pe],   
     [observ_revocatorias_pe]   as   [observ_revocatorias_pe];            

SQL
select RazonSocial razonsocial_revocatorias_pe, NIT nit_revocatorias_pe,Departamento departamento_revocatorias_pe,
NumeroProveido numeroproveido_revocatorias_pe,convert(varchar(10),FechaProveido,103) fechaproveido_revocatorias_pe,
EstadoTramite estadotramite_revocatorias_pe,Periodo periodo_revocatorias_pe, lower(left(datename(month,Periodo),3)) mes_revocatorias_pe,
'NINGUNA' observ_revocatorias_pe
from dbo.[ODS.VPTRecursosRevocatorias]
order by Periodo,FechaProveido;

VPTrevocatorias_confirm_pe:
LOAD
     [razonsocial_revocatorias_confirm_pe] as [razonsocial_revocatorias_confirm_pe], 
     [nit_revocatorias_confirm_pe] as [nit_revocatorias_confirm_pe], 
     [depto_revocatorias_confirm_pe]   as [depto_revocatorias_confirm_pe] , 
     [nroproveido_revocatorias_confirm_pe]  as [nroproveido_revocatorias_confirm_pe], 
     [fecproveido_revocatorias_confirm_pe]   as   [fecproveido_revocatorias_confirm_pe],
     [resolucion_revocatorias_confirm_pe]  as [resolucion_revocatorias_confirm_pe], 
     [mes_revocatorias_confirm_pe]   as   [mes_revocatorias_confirm_pe],
     [observ_revocatorias_confirm_pe]   as   [observ_revocatorias_confirm_pe],   
     [periodo_revocatorias_confirm_pe]   as   [periodo_revocatorias_confirm_pe];            

SQL
select
	ovrc.RazonSocial razonsocial_revocatorias_confirm_pe,
	NIT nit_revocatorias_confirm_pe,
	Departamento depto_revocatorias_confirm_pe,
	NumeroResolucion nroproveido_revocatorias_confirm_pe ,
	FechaResolucion fecproveido_revocatorias_confirm_pe ,
	FormaResolucion resolucion_revocatorias_confirm_pe,
	lower(left(datename(month, Periodo), 3)) mes_revocatorias_confirm_pe,
	'NINGUNA' observ_revocatorias_confirm_pe,
	Periodo periodo_revocatorias_confirm_pe
FROM
	[ODS.VPTRecursosRevocatoriasConfirmados] ovrc
where
	(
	(year(Periodo)<= 2023
		and FormaResolucion like '%CONFIRM%' COLLATE Latin1_General_CI_AS)
	or (year(Periodo)>= 2024
		and FormaResolucion not in('REVOCA', 'REVOCA TOTALMENTE', 'REVOCAR', 'REVOCAR TOTALMENTE'))
		)
order by
	Periodo,
	FechaResolucion;



VPTmontosanciones_rs:
LOAD
     [anio_rs_monto] as [anio_rs_monto], 
     [mes_rs_monto] as [mes_rs_monto], 
     [oficina_rs_monto]   as [oficina_rs_monto] , 
     [razonsocial_rs_monto]  as [razonsocial_rs_monto], 
     [nit_rs_monto]   as   [nit_rs_monto],
     [montoufv_rs_monto]    as   [montoufv_rs_monto],
     [departamento_rs_monto]    as   [departamento_rs_monto],
     [numres_rs_monto]    as   [numres_rs_monto],
     [observ_rs_monto]    as   [observ_rs_monto],
     [periodo_rs_monto]    as   [periodo_rs_monto];     

select distinct year(Periodo) anio_rs_monto,
case 
	when month(Periodo )=1 then 'ene'
	when month(Periodo )=2 then 'feb'
	when month(Periodo )=3 then 'mar'
	when month(Periodo )=4 then 'abr'
	when month(Periodo )=5 then 'may'
	when month(Periodo )=6 then 'jun'
	when month(Periodo )=7 then 'jul'
	when month(Periodo )=8 then 'ago'
	when month(Periodo )=9 then 'sep'
	when month(Periodo )=10 then 'oct'
	when month(Periodo )=11 then 'nov'
	when month(Periodo )=12 then 'dic'	
	else 'otro'
end mes_rs_monto,Oficina oficina_rs_monto,RazonSocial razonsocial_rs_monto,NIT nit_rs_monto,
MontoUFV montoufv_rs_monto,Departamento departamento_rs_monto,NumeroResolucion numres_rs_monto,'' observ_rs_monto,periodo periodo_rs_monto
from [ODS.VPTResolucionesSancionatoriasMontos];

VPTres_reg:
LOAD
     [fecha_res_reg] as [fecha_res_reg], 
     [num_res_reg] as [num_res_reg], 
     [nom_res_reg]   as [nom_res_reg] , 
     [obs_res_reg]  as [obs_res_reg];

select
	FechaResolucion fecha_res_reg,
	NumeroResolucion num_res_reg,
	NombreResolucion nom_res_reg,
	ObjetoResolucion obs_res_reg
from
	[ODS.VPTResolucionesRegulatorias] r
where r.NumeroResolucion is not NULL AND LEN(r.NumeroResolucion) > 0
order by
	ResolucionID;

select oficina oficina_control_pe,empresa empresa_control_pe, nombrepromocion promo_control_pe, nit nit_control_pe,
isnull(lpz,0)lpz_control_pe,isnull(oru,0) oru_control_pe,isnull(pot,0) pot_control_pe,
isnull(cbba,0) cbba_control_pe,isnull(chq,0) chq_control_pe,isnull(tja,0) tja_control_pe,isnull(scz,0) scz_control_pe,
isnull(ben,0) ben_control_pe,isnull(pan,0) pan_control_pe,mes mes_control_pe, anio anio_control_pe,
condicion condicion_control_pe,tipoact tipoact_control_pe,observ _control_pe
from vpt.controles_pe cp;



SELECT concepto concepto_multas_sigep,recaudacion recaudacion_multas_sigep,
mes mes_multas_sigep, gestion gestion__multas_sigep, observacion observacion_multas_sigep
FROM vpt.multas_sigep ms 
order by sec;



//*************************************************
//**** CONEVIO VPT acordado Gestion 2019***********
//***RESUMEN QUE SE MUESTRA COMO INICIO************
//************************************************* 
VPTConvenioGestion2019:
LOAD
	[NumeroConvenio] as [VPT_MVC_NumeroConvenio],
	[Ejecutado] as [VPT_MVC_Ejecutado],
	[NumeroMes] as [VPT_MVC_NumeroMes],
	[Mes] as [VPT_MVC_Mes],
	[Gestion] as [VPT_MVC_Gestion];
SQL
select NumeroConvenio, 
	(
		case 
		when NumeroConvenio=1
			then (select count(*) from [ODS.VPTResolucionesRegulatorias] as rr where Gestion = YEAR(rr.fecharesolucion) and NumeroMes>= MONTH(rr.fecharesolucion))
		when NumeroConvenio=2
			then (select count(*) from [ODS.VPTLicenciasOperaciones] as lo where Gestion = YEAR(lo.Periodo) and NumeroMes>= MONTH(lo.Periodo))
		when NumeroConvenio=3
			then
			(
				select ( 
				(select count(*) from [AlmacenCorporativo.PromocionesEmpresariales] pe 
					where pe.EstadoAutorizacion  in ('AUTORIZADA', 'RECHAZADA', 'DESISTIDA') and pe.EstadoPromocion = 'ACTIVO' and 
					year(pe.FechaAutorizacionRechazo) = Gestion and NumeroMes>= month(pe.FechaAutorizacionRechazo) and pe.CiteAutorizacionRechazo <>'') + 
					(
						CASE
							WHEN Gestion=2017
							THEN
								(select count(*) from [AlmacenCorporativo.PromocionesEmpresariales] pe, [AlmacenCorporativo.Tramites] tra
								where pe.EstadoAutorizacion	= 'DESISTIDA' and pe.EstadoPromocion= 'ACTIVO' and tra.TipoEstadoTramite = 'ACEPTADO' and tra.TramiteAsociadoID	= pe.TramiteID 
								and pe.CiteAutorizacionRechazo <>'' and year(tra.FechaEfectivizacionTramite) = Gestion and NumeroMes>= month(tra.FechaEfectivizacionTramite))
							WHEN Gestion=2018
							THEN
								(select count(*) from [AlmacenCorporativo.PromocionesEmpresariales] pe, [AlmacenCorporativo.Tramites] tra
								where pe.EstadoAutorizacion	= 'DESISTIDA' and pe.EstadoPromocion= 'ACTIVO' and tra.TipoEstadoTramite = 'ACEPTADO' and tra.TramiteAsociadoID	= pe.TramiteID 
								and pe.CiteAutorizacionRechazo ='' and year(tra.FechaEfectivizacionTramite) = Gestion and NumeroMes>= month(tra.FechaEfectivizacionTramite))
							WHEN Gestion>=2019
							THEN
								(select count(*) from [AlmacenCorporativo.PromocionesEmpresariales] pe, [AlmacenCorporativo.Tramites] tra
								where pe.EstadoPromocion= 'ACTIVO' and tra.TipoEstadoTramite = 'ACEPTADO' and tra.TramiteAsociadoID	= pe.TramiteID 
								and year(tra.FechaEfectivizacionTramite) = Gestion and NumeroMes>= month(tra.FechaEfectivizacionTramite))
							ELSE 0
						END
					)
				)
			)
		/*when NumeroConvenio=4
			then (select SUM(pe.ValorComercial) from [192.168.3.44].[SIAJPRODUCCION].[dbo].[PromocionesEmpresariales.PromocionesEmpresariales] pe where pe.EstadoID = 1000 and year(pe.FechaResolucion) = Gestion and MONTH(pe.FechaResolucion)=NumeroMes)*/
 		when NumeroConvenio=5
			then (select sum(TotalFiscalizaciones) from [ODS.VPTFiscalizacionesJLAS] as jlas where Gestion = YEAR(jlas.Periodo) and NumeroMes>= MONTH(jlas.Periodo))
		when NumeroConvenio=6
			then (select sum(TotalFiscalizaciones) from [ODS.VPTFiscalizacionesPE] as pe where Gestion = YEAR(pe.Periodo) and NumeroMes>= MONTH(pe.Periodo))
		when NumeroConvenio=7
			then (select sum(TotalControles) from [ODS.VPTControlesJLAS] as jlas where Gestion = YEAR(jlas.Periodo) and NumeroMes>= MONTH(jlas.Periodo))
		when NumeroConvenio=8
			then (select sum(TotalControles) from [ODS.VPTControlesPE] as pe where Gestion = YEAR(pe.Periodo) and NumeroMes>= MONTH(pe.Periodo))
		when NumeroConvenio=9
			then (select sum(CantidadIntervenciones) from [ODS.VPTIntervenciones] as inte where Gestion = YEAR(inte.Periodo) and NumeroMes>= MONTH(inte.Periodo))
		when NumeroConvenio=10
			then (select sum(CantidadMediosJuego) from [ODS.VPTIntervenciones] as inte where Gestion = YEAR(inte.Periodo) and NumeroMes>= MONTH(inte.Periodo))
		when NumeroConvenio=11
			then (select count(*) from [ODS.VPTResolucionesSancionatorias] as rs where Gestion = YEAR(rs.Periodo) and NumeroMes>= MONTH(rs.Periodo))
		when NumeroConvenio=12
			then (select sum(rs.MontoUFV) from [ODS.VPTResolucionesSancionatoriasMontos] as rs where Gestion = YEAR(rs.Periodo) and NumeroMes>= MONTH(rs.Periodo))
		when NumeroConvenio=13
			then (select sum(rs.MontoSancionUFV) from [ODS.VPTResolucionesSancionatoriasMontosImpuestos] as rs where Gestion = YEAR(rs.Periodo) and NumeroMes>= MONTH(rs.Periodo))
		when NumeroConvenio=14
			then (select sum(dbp.MontoPagadoUFV) from [192.168.3.44].[SIAJPRODUCCION].[dbo].[Pagos.RecepcionesBoletasPagos] rbp, 
														[192.168.3.44].[SIAJPRODUCCION].[dbo].[Pagos.VerificacionesPagos] vbp,
														[192.168.3.44].[SIAJPRODUCCION].[dbo].[Pagos.DetallesBoletasPagos] dbp,
														[192.168.3.44].[SIAJPRODUCCION].[dbo].[Transversales.Dominios] dtp,
														[192.168.3.44].[SIAJPRODUCCION].[dbo].[Transversales.Dominios] dop,
														[192.168.3.44].[SIAJPRODUCCION].[dbo].[Transversales.Dominios] ddp,
														[192.168.3.44].[SIAJPRODUCCION].[dbo].[Cites.Cites] c
							where rbp.EstadoID = 1000 and dbp.EstadoID = 1000 and c.EstadoID = 1000 and rbp.TramiteID = vbp.TramiteID and rbp.RecepcionBoletaPagoID = dbp.RecepcionBoletaPagoID
										and dbp.TipoPagoID = dtp.DominioID  and dbp.TipoOrigenPagoID = dop.DominioID and dbp.TipoDocumentoProcesoID = ddp.DominioID and c.CiteID = dbp.CiteID
										and Gestion = YEAR(dbp.FechaPresentacionBoleta) and NumeroMes >= MONTH(dbp.FechaPresentacionBoleta))
			
		when NumeroConvenio=15
			then (select count(*) from [ODS.VPTRecursosRevocatorias] as rr where Gestion = YEAR(rr.Periodo) and NumeroMes>= MONTH(rr.Periodo) and rr.estadotramite = 'PRESENTACIÓN')
		when NumeroConvenio=16
			then (select count(*) from [ODS.VPTRecursosJerarquicos] as rj where Gestion = YEAR(rj.Periodo) and NumeroMes>= MONTH(rj.Periodo))
		when NumeroConvenio=17
			then (select count(*) from [ODS.VPTDenunciasReclamos] as dr where Gestion = YEAR(dr.Periodo) and NumeroMes>= MONTH(dr.Periodo) and dr.estado <> 'EN PROCESO')
		when NumeroConvenio=18
			then (select sum(ma.MontoBs) from [ODS.VPTMontosAlquileres] as ma where Gestion = YEAR(ma.Periodo) and NumeroMes>= MONTH(ma.Periodo))
		when NumeroConvenio=19
			then (select sum(md.Entregadas) from [ODS.VPTMaquinasDestruidas] as md where Gestion = YEAR(md.Periodo) and NumeroMes>= MONTH(md.Periodo))
		end
	) as Ejecutado,
	NumeroMes, Mes, Gestion
from 
	[ODS.VPTConvenio];

DetalleDevolucionPagos:
load 
	[Oficina] as [Devolucion_Oficina],
	[NumeroBoletaPago] as [Devolucion_NumeroBoletaPago],
	[PersonaRealizoPago] as [Devolucion_PersonaRealizoPago],
	[Motivo] as [Devolucion_Motivo],
	[FechaPago] as [Devolucion_FechaPago],
	[FechaPresentacionBoleta] as [Devolucion_FechaPresentacionBoleta],
	[MontoBS] as [Devolucion_MontoPagadoBS],
	[NombreUsuarioRegistro] as [Devolucion_NombreUsuarioRegistro],
	[FechaRegistro] as [Devolucion_FechaRegistroPago];
SQL

select
	case
		when  recBol.OficinaID=1000
		then 'DNAL'
		when  recBol.OficinaID=1001
		then 'DRLP'
		when recBol.OficinaID=1002
		then 'DRSC'
		when recBol.OficinaID=1003
		then 'DRCB'
	end 'Oficina',
	detBol.NumeroBoletaPago 'NumeroBoletaPago',
	detBol.PersonaRealizoPago 'PersonaRealizoPago',
	detBol.Motivo 'Motivo',
	detBol.FechaPago 'FechaPago',
	detBol.FechaPresentacionBoleta 'FechaPresentacionBoleta',
	detBol.MontoPagadoBS 'MontoBS',
	perNat.Nombres + ' ' + perNat.ApellidoPaterno + ' ' + perNat.ApellidoMaterno 'NombreUsuarioRegistro',
	detBol.FechaRegistro 'FechaRegistro'
from 
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Pagos.DevolucionPagos] recBol,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Pagos.DetallesBoletasPagos] detBol,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Usuarios.Usuarios] usu,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Personas.PersonasNaturales] perNat
where
	recBol.DetalleBoletaPagoID = detbol.DetalleBoletaPagoID
	and recBol.EstadoID=1000
	and detBol.EstadoID=1000
	and usu.UsuarioID = detBol.UsuarioID
	and usu.PersonaID = perNat.PersonaID;
	
/**********DESTRUCCION MAQUINAS punto18 convenio VPT Gestion 2019 -- MAVC***************/
RegistroDestrucionMaquinasVPT:
load
	[Oficina] as [VPT_MVCMaquinas_Oficina],
	[Venta] as [VPT_MVCMaquinas_Venta],
	[Donacion] as [VPT_MVCMaquinas_Donacion],
	[Entregadas] as [VPT_MVCMaquinas_Entregadas],
	[Destruidas] as [VPT_MVCMaquinas_Destruidas],
	[Observacion] as [VPT_MVCMaquinas_Observacion],
	[Periodo] as [VPT_MVCMaquinas_Periodo];
SQL

SELECT mq.[MaquinaDestruida]
      ,mq.[Oficina]
      ,mq.[Venta]
      ,mq.[Donacion]
      ,mq.[Entregadas]
      ,mq.[Destruidas]
      ,mq.[Observacion]
      ,mq.[Periodo]
  FROM [MINAJPRODUCCION].[dbo].[ODS.VPTMaquinasDestruidas] mq;
