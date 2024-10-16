FiscalizacionesSIAJ:
LOAD 
	[Oficina] as [FiscaSiajOficina],
	[NombreEmpresa] as [FiscaSiajNombreEmpresa],
	[NombrePromocion] as [FiscaSiajNombrePromocion],
	[CadenaCiteRAA] as [FiscaSiajCadenaCiteRAA],
	[ValorComercial] as [FiscaSiajValorComercial],
	[CadenaOFPE] as [FiscaSiajCadenaOFPE],
	[FechaOFPE] as [FiscaSiajFechaOFPE],
	[CadenaCiteInforme] as [FiscaSiajCadenaCiteInforme],
	[CadenaCiteAuto] as [FiscaSiajCadenaCiteAuto],
	[Descripcion] as [FiscaSiajEstado],
	[FechaRegistro] as [FiscaSiajFechaRegistro];
SQL
select 
	case
		when fis.OficinaID=1000  then 'DNAL'
		when fis.OficinaID=1001  then 'DRLP'
		when fis.OficinaID=1002  then 'DRSC'
		when fis.OficinaID=1003  then 'DRCB'
	end Oficina,
	perjur.NombreEmpresa,
	pe.NombrePromocion,
	fis.CadenaCiteRAA,
	pe.ValorComercial,
	fis.CadenaOFPE,
	fis.FechaOFPE,
	fis.CadenaCiteInforme,
	fis.CadenaCiteAuto,
	est.Descripcion,
	fis.FechaRegistro
from
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[FiscalizacionPES.Fiscalizaciones] fis,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[PromocionesEmpresariales.PromocionesEmpresariales] pe,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Personas.PersonasJuridicas] perjur,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Transversales.Dominios] est
where 
	fis.EstadoID=1000 
	and pe.EstadoID=1000 
	and fis.TramiteRelacionadoID = pe.TramiteID
	and pe.PersonaID = perjur.PersonaID
	and est.DominioID = fis.EstadoFiscalizacionID;

ProcesosFiscalizacionesSIAJ:
LOAD 
	[Oficina] as [PFSiajOficina],
	[NombreEmpresa] as [PFSiajNombreEmpresa],
	[NumeroDocumento] as [PFSiajNumeroDocumento],
	[NombrePromocion] as [PFSiajNombrePromocion],
	[CadenaCiteRAA] as [PFSiajCadenaCiteRAA],
	[ValorComercial] as [PFSiajValorComercial],
	[CadenaOFPE] as [PFSiajCadenaOFPE],
	[FechaOFPE] as [PFSiajFechaOFPE],
	[FiscalizadorAsignado] as [PFSiajFiscalizadorAsignado],
	[CadenaCiteInforme] as [PFSiajCadenaCiteInforme],
	[FechaCiteInforme] as [PFSiajFechaCiteInforme],
	[CadenaCiteAuto] as [PFSiajCadenaCiteAuto],
	[FechaCiteAuto] as [PFSiajFechaCiteAuto],
	[CadenaCiteMemo] as [PFSiajCadenaCiteMemo],
	[FechaCiteMemo] as [PFSiajFechaCiteMemo],
	[Descripcion] as [PFSiajEstado],
	[DescripcionMINAJ] as [PFSiajEstadoMINAJ],
	[FechaRegistro] as [PFSiajFechaRegistro],
	[PFSiajanio] as [PFSiajanio],
	[PFSiajmes] as [PFSiajmes],
	[PFSiajCantidad] as [PFSiajCantidad];		
SQL
select 
	case
		when fis.OficinaID=1000  then 'DNAL'
		when fis.OficinaID=1001  then 'DRLP'
		when fis.OficinaID=1002  then 'DRSC'
		when fis.OficinaID=1003  then 'DRCB'
	end Oficina,
	perjur.NombreEmpresa,
	'NIT ' + datPer.NumeroDocumento NumeroDocumento,
	pe.NombrePromocion,	
	fis.CadenaCiteRAA,
	pe.ValorComercial,
	fis.CadenaOFPE,
	fis.FechaOFPE,
	(select top 1 usu.login 
		from [192.168.3.44].[SIAJPRODUCCION].[dbo].[Usuarios.Usuarios] usu 
		where usu.UsuarioID=(select top 1 UsuarioID 
								from [192.168.3.44].[SIAJPRODUCCION].[dbo].[FiscalizacionPES.FiscalizadoresAsignados] fisca 
								where fisca.FiscalizacionID=fis.FiscalizacionID and fisca.EstadoID=1000)) FiscalizadorAsignado,
	fis.CadenaCiteInforme,
	fis.FechaCiteInforme,
	fis.CadenaCiteAuto,
	nn.FechaNotificacion FechaCiteAuto,
	(select top 1 CadenaCiteMemo from [192.168.3.44].[SIAJPRODUCCION].[dbo].[FiscalizacionPES.FiscalizadoresAsignados] fisca 
		where fisca.FiscalizacionID=fis.FiscalizacionID and fisca.EstadoID=1000) CadenaCiteMemo,
	(select top 1 FechaCiteMemo from [192.168.3.44].[SIAJPRODUCCION].[dbo].[FiscalizacionPES.FiscalizadoresAsignados] fisca 
		where fisca.FiscalizacionID=fis.FiscalizacionID and fisca.EstadoID=1000) FechaCiteMemo,
	case
		when est.DominioID=2707 then 'INICIO PROCESO SANCIONADOR'
		when est.DominioID=2708 then 'ARCHIVO DE OBRADOS'
	end Descripcion,
	case
		when est.DominioID=2703 then 'ORDEN GENERADA'
		when est.DominioID=2706 then 'EN PROCESO'
		when est.DominioID=2707 then 'CONCLUIDO'
		when est.DominioID=2708 then 'CONCLUIDO'
		when est.DominioID=2894 then 'CONCLUIDO'
		when est.DominioID=2895 then 'SIN INICIO'
		when est.DominioID=2896 then 'ANULADA'
		when est.DominioID=2897 then 'ORDEN GENERADA'
		when est.DominioID=2898 then 'EN PROCESO'
	end DescripcionMINAJ,
	fis.FechaRegistro, year(fis.FechaOFPE) PFSiajanio,lower(left(datename(month,FechaOFPE),3)) PFSiajmes,1 PFSiajCantidad
from
		[192.168.3.44].[SIAJPRODUCCION].[dbo].[FiscalizacionPES.Fiscalizaciones] fis,
		[192.168.3.44].[SIAJPRODUCCION].[dbo].[PromocionesEmpresariales.PromocionesEmpresariales] pe,
		[192.168.3.44].[SIAJPRODUCCION].[dbo].[Personas.PersonasJuridicas] perjur,
		[192.168.3.44].[SIAJPRODUCCION].[dbo].[Personas.DatosPersonas] datPer,
		[192.168.3.44].[SIAJPRODUCCION].[dbo].[Transversales.Dominios] est,
		[192.168.3.44].[SIAJPRODUCCION].[dbo].[Cites.Cites] cc,
		[192.168.3.44].[SIAJPRODUCCION].[dbo].[Notificaciones.Notificaciones] nn,
		[192.168.3.44].[SIAJPRODUCCION].[dbo].[Transversales.TiposActividadesEconomicas] acti,
		[192.168.3.44].[SIAJPRODUCCION].[dbo].[Usuarios.Usuarios] usu,
		[192.168.3.44].[SIAJPRODUCCION].[dbo].[FiscalizacionPES.FiscalizadoresAsignados] fisca,
		[192.168.3.44].[SIAJPRODUCCION].[dbo].[Personas.Personas] per
		left join [192.168.3.44].[SIAJPRODUCCION].[dbo].[Transversales.Dominios] depa on depa.DominioID = per.DepartamentoFiscalID
	where 
		fis.EstadoID=1000 
		and pe.EstadoID=1000 
		and fis.TramiteRelacionadoID = pe.TramiteID
		and fis.PromocionEmpresarialID = pe.PromocionEmpresarialID
		and pe.PersonaID = perjur.PersonaID
		and est.DominioID = fis.EstadoFiscalizacionID
		and datPer.PersonaID = perjur.PersonaID
		and cc.CadenaCite=fis.CadenaOFPE and cc.EstadoID=1000
		and nn.CiteActuadoID=cc.CiteID and nn.EstadoId=1000
		and per.PersonaID = perjur.PersonaID
		and acti.TipoActividadEconomicaID = perjur.TipoActividadEconomicaID
		and fisca.FiscalizacionID = fis.FiscalizacionID and Fisca.EstadoId=1000
		and usu.UsuarioID = fisca.UsuarioID;

ResumenProcesoFiscalizacionSIAJ:
load 
	[Grupo Trámite] as [PFSIAJR_Grupo Trámite],
	[Tipo Trámite] as [PFSIAJR_Tipo Trámite],
	[Estado Trámite] as [PFSIAJR_Estado Trámite],
	[Direccion] as [PFSIAJR_Dirección]  ,
	[Año] as [PFSIAJR_Año],
	[Mes] as [PFSIAJR_Mes],  
	[Fecha Ingles]   				    as [PFSIAJR_Fecha Ingles], 
	[Dia]          					    as [PFSIAJR_Dia],
	[Semestre]       					    as [PFSIAJR_Semestre],
	[Trimestre]      				    as [PFSIAJR_Trimestre],
	[NumeroMes]                               as [PFSIAJR_NumeroMes],
	[Nombre/Empresa]                         as [PFSIAJR_Nombre/Empresa Total],		
	[Departamento]   as  [PFSIAJR_Departamento Total],
	[Tipo Actividad Económica]  as 		[PFSIAJR_Tipo Actividad Económica Total],
	[CantidadProcesoFiscalizacion]      as [PFSIAJR_CantidadProcesoFiscalizacion Total], 
	[MontoValorPremiosFiscalizacion]                as    [PFSIAJR_MontoValorPremiosFiscalizacion Total],
	[MontoValorPremiosFiscalizacionDNF]   as  [PFSIAJR_MontoValorPremiosFiscalizacionDNF Total],
	[CantidadOrdenesSancionadas]  as [PFSIAJR_Cantidad Ordenes Sancionadas Total],
	[Departamento Proceso Fiscalización Total]    as [PFSIAJR_Departamento Proceso Fiscalización Total],
	[Dirección Proceso Fiscalización Total]    as [PFSIAJR_Dirección Proceso Fiscalización Total],
	[Nombre Usuario Proceso Fiscalización Total]    as [PFSIAJR_Nombre Usuario Proceso Fiscalización Total] ,
	[Usuario Proceso Fiscalización Total]    as  [PFSIAJR_Usuario Proceso Fiscalización Total] ,
	[ProcesoNegocio]    as [PFSIAJR_Proceso Fiscalización Total] ,
	[TipoProcesoNegocio]    as [PFSIAJR_Tipo Proceso Fiscalización Total] ,
	[EstadoProcesoNegocio]    as [PFSIAJR_Estado Proceso Fiscalización Total],
	[CantidadFiscalizacionesDNF] 	as	[PFSIAJR_CantidadFiscalizacionesDNF]; 
SQL
select  
'TRAMITES DEFINIDOS (PROCESOS)' 'Grupo Trámite',
	'SOLICITUD AUTORIZACION PROMOCION EMPRESARIAL' 'Tipo Trámite',
	'ACTIVO' 'Estado Trámite',
	case
		when fis.OficinaID = 1000 then 'DNAL'
		when fis.OficinaID = 1003 then 'DRCB'
		when fis.OficinaID = 1002 then 'DRSC'
		when fis.OficinaID = 1001 then 'DRLP'
	end	'Direccion',
	year(fis.FechaCiteInforme) 'Año',
	case   
		when month(convert(datetime, fis.FechaCiteInforme ,103)) = 1 then 'ene'
		when month(convert(datetime, fis.FechaCiteInforme ,103)) = 2 then 'feb'
		when month(convert(datetime, fis.FechaCiteInforme ,103)) = 3 then 'mar'
		when month(convert(datetime, fis.FechaCiteInforme ,103)) = 4 then 'abr'
		when month(convert(datetime, fis.FechaCiteInforme ,103)) = 5 then 'may'
		when month(convert(datetime, fis.FechaCiteInforme ,103)) = 6 then 'jun'
		when month(convert(datetime, fis.FechaCiteInforme ,103)) = 7 then 'jul'
		when month(convert(datetime, fis.FechaCiteInforme ,103)) = 8 then 'ago'
		when month(convert(datetime, fis.FechaCiteInforme ,103)) = 9 then 'sep'
		when month(convert(datetime, fis.FechaCiteInforme ,103)) = 10 then 'oct'
		when month(convert(datetime, fis.FechaCiteInforme ,103)) = 11 then 'nov'
		when month(convert(datetime, fis.FechaCiteInforme ,103)) = 12 then 'dic'
		when month(convert(datetime, fis.FechaCiteInforme ,103)) is null then 'NA'
	end 'Mes',
	fis.FechaCiteInforme 'Fecha Ingles', 
	day(fis.FechaCiteInforme) 'Dia',
	case
		when month(convert(datetime, fis.FechaCiteInforme ,103)) in (1,2,3,4,5,6) then 'Semestre1'
		when month(convert(datetime, fis.FechaCiteInforme ,103)) in (7,8,9,10,11,12) then 'Semestre2'
	end 'Semestre',
	case
		when month(convert(datetime, fis.FechaCiteInforme ,103)) in (1,2,3) then 'Trimestre1'
		when month(convert(datetime, fis.FechaCiteInforme ,103)) in (4,5,6) then 'Trimestre2'
		when month(convert(datetime, fis.FechaCiteInforme ,103)) in (7,8,9) then 'Trimestre3'
		when month(convert(datetime, fis.FechaCiteInforme ,103)) in (10,11,12) then 'Trimestre4'
	end 'Trimestre',
	month(fis.FechaCiteInforme) 'NumeroMes',
	perjur.NombreEmpresa 'Nombre/Empresa',
	isnull(depa.Descripcion,'') 'Departamento',
	acti.Descripcion 'Tipo Actividad Económica',
	'DEPARTAMENTO FISCALIZACION Y CONTROL' 'Departamento Proceso Fiscalización Total',
	' ' 'Dirección Proceso Fiscalización Total',	
	usu.Login 'Nombre Usuario Proceso Fiscalización Total',
	usu.Login 'Usuario Proceso Fiscalización Total',
	'PROMOCION' 'ProcesoNegocio',
	case
		when est.DominioID=2703 then 'ORDEN GENERADA'
		when est.DominioID=2706 then 'EN PROCESO'
		when est.DominioID=2707 then 'CONCLUIDO'
		when est.DominioID=2708 then 'CONCLUIDO'
		when est.DominioID=2894 then 'CONCLUIDO'
		when est.DominioID=2895 then 'SIN INICIO'
		when est.DominioID=2896 then 'ANULADA'
		when est.DominioID=2897 then 'ORDEN GENERADA'
		when est.DominioID=2898 then 'EN PROCESO'
	end 'TipoProcesoNegocio',
	'ARCHIVO DE OBRADOS' 'EstadoProcesoNegocio',
	1 'CantidadProcesoFiscalizacion',
	pe.ValorComercial 'MontoValorPremiosFiscalizacion',
		0 'MontoValorPremiosFiscalizacionDNF' ,
	0 'CantidadOrdenesSancionadas',
	0 'CantidadFiscalizacionesDNF'
from
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[FiscalizacionPES.Fiscalizaciones] fis,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[PromocionesEmpresariales.PromocionesEmpresariales] pe,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Personas.PersonasJuridicas] perjur,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Personas.DatosPersonas] datPer,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Transversales.Dominios] est,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Cites.Cites] cc,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Notificaciones.Notificaciones] nn,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Transversales.TiposActividadesEconomicas] acti,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Usuarios.Usuarios] usu,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[FiscalizacionPES.FiscalizadoresAsignados] fisca,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Personas.Personas] per
	left join [192.168.3.44].[SIAJPRODUCCION].[dbo].[Transversales.Dominios] depa on depa.DominioID = per.DepartamentoFiscalID
where 
	fis.EstadoID=1000 
	and pe.EstadoID=1000 
	and fis.TramiteRelacionadoID = pe.TramiteID
	and fis.PromocionEmpresarialID = pe.PromocionEmpresarialID
	and pe.PersonaID = perjur.PersonaID
	and est.DominioID = fis.EstadoFiscalizacionID
	and datPer.PersonaID = perjur.PersonaID
	and cc.CadenaCite=fis.CadenaOFPE and cc.EstadoID=1000
	and nn.CiteActuadoID=cc.CiteID and nn.EstadoId=1000
	and per.PersonaID = perjur.PersonaID
	and acti.TipoActividadEconomicaID = perjur.TipoActividadEconomicaID
	and fisca.FiscalizacionID = fis.FiscalizacionID and Fisca.EstadoId=1000
	and usu.UsuarioID = fisca.UsuarioID;
	
DetalleProcesoFiscalizacionSIAJTodosLosCampos:
load 
	[FiscalizacionID] as [DetFisSIAJ_FiscalizacionID],
	[TramiteFiscalizacionID] as [DetFisSIAJ_TramiteFiscalizacionID],
	[PromocionEmpresarialID] as [DetFisSIAJ_PromocionEmpresarialID],
	[TramitePromocionEmpresarial] as [DetFisSIAJ_TramitePromocionEmpresarial],
	[Oficina] as [DetFisSIAJ_Oficina],
	[NIT] as [DetFisSIAJ_NIT],
	[NombreEmpresa] as [DetFisSIAJ_NombreEmpresa],
	[NombrePromocion] as [DetFisSIAJ_NombrePromocion],
	[CadenaCiteRAA] as [DetFisSIAJ_CadenaCiteRAA],
	[FechaCiteRAA] as [DetFisSIAJ_FechaCiteRAA],
	[Proceso] as [DetFisSIAJ_Proceso],
	[TipoInicio] as [DetFisSIAJ_TipoInicio],
	[FechaDesde] as [DetFisSIAJ_FechaDesde],
	[FechaHasta] as [DetFisSIAJ_FechaHasta],
	[ValorComercial] as [DetFisSIAJ_ValorComercial],
	[CadenaOFPE] as [DetFisSIAJ_CadenaOFPE],
	[FechaOFPE] as [DetFisSIAJ_FechaOFPE],
	[FiscalizadorAsignado] as [DetFisSIAJ_FiscalizadorAsignado],
	[CiteMEMO] as [DetFisSIAJ_CiteMEMO],
	[FECHACiteMEMO] as [DetFisSIAJ_FECHACiteMEMO],
	[CiteInforme] as [DetFisSIAJ_CiteInforme],
	[FechaInforme] as [DetFisSIAJ_FechaInforme],
	[ArchivoJuridica] as [DetFisSIAJ_ArchivoJuridica],
	[CiteAuto] as [DetFisSIAJ_CiteAuto],
	[EstadoFiscalizacion] as [DetFisSIAJ_EstadoFiscalizacion],
	[EstadoProceso] as [DetFisSIAJ_EstadoProceso],
	[FechaRegistro] as [DetFisSIAJ_FechaRegistro];
SQL

select
	fis.FiscalizacionID 'FiscalizacionID',
	fis.TramiteID 'TramiteFiscalizacionID',
	fis.PromocionEmpresarialID 'PromocionEmpresarialID',
	pe.TramiteID 'TramitePromocionEmpresarial',
	case
		when fis.OficinaID=1000  then 'DNAL'
		when fis.OficinaID=1001  then 'DRLP'
		when fis.OficinaID=1002  then 'DRSC'
		when fis.OficinaID=1003  then 'DRCB'
	end 'Oficina',
	'NIT ' + per.NumeroDocumento 'NIT',
	perjur.NombreEmpresa 'NombreEmpresa',
	pe.NombrePromocion 'NombrePromocion',
	fis.CadenaCiteRAA 'CadenaCiteRAA',
	fis.FechaCiteRAA 'FechaCiteRAA',
	'PROMOCION' 'Proceso',
	tipoInicio.Descripcion 'TipoInicio',
	pe.FechaDesde 'FechaDesde',
	pe.FechaHasta 'FechaHasta',
	pe.ValorComercial 'ValorComercial',
	fis.CadenaOFPE 'CadenaOFPE',
	fis.FechaOFPE 'FechaOFPE',	
	pernat.ApellidoPaterno + ' ' + pernat.ApellidoMaterno + ' ' + pernat.Nombres 'FiscalizadorAsignado',
	CONVERT(varchar,fiscas.CadenaCiteMemo) 'CiteMEMO',
	fiscas.FechaCiteMemo 'FECHACiteMEMO',
	fis.CadenaCiteInforme 'CiteInforme',
	fis.FechaCiteInforme 'FechaInforme',
	case
		when est.Descripcion='INFORME CON INFRACCION' then 'INICIO PROCESO SANCIONADOR'
		when est.Descripcion='INFORME SIN INFRACCION' then 'ARCHIVO DE OBRADOS'
	end 'ArchivoJuridica',
	fis.CadenaCiteAuto 'CiteAuto',
	'CONCLUIDO' 'EstadoFiscalizacion',
	'ACTIVO' 'EstadoProceso',
	fis.FechaRegistro 'FechaRegistro'
from
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[FiscalizacionPES.Fiscalizaciones] fis,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[FiscalizacionPES.FiscalizadoresAsignados] fiscas,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Usuarios.Usuarios] usu,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[PromocionesEmpresariales.PromocionesEmpresariales] pe,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Personas.DatosPersonas] per,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Personas.PersonasJuridicas] perjur,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Personas.PersonasNaturales] pernat,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Transversales.Dominios] est,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Transversales.Dominios] tipoInicio
where 
	fis.EstadoID=1000 
	and pe.EstadoID=1000 
	and fis.TramiteRelacionadoID = pe.TramiteID
	and fiscas.FiscalizacionID = fis.FiscalizacionID
	AND fiscas.EstadoID=1000
	and fiscas.UsuarioID = usu.UsuarioID
	and pe.PersonaID = perjur.PersonaID
	and per.PersonaID = perjur.PersonaID
	and pernat.PersonaID = usu.PersonaID
	and est.DominioID = fis.EstadoFiscalizacionID
	and pe.TipoInicioPromocionID = tipoInicio.DominioID
	and fis.EstadoID=1000;

/* /////********INFORMES DE AUTORIZACIÓN PROMOCIONES EMPRESARIALES VIA WEB v4.0*/
DetalleInformesTecnicosAutorizacionesViaWeb:
load 
	[TramiteID] as [DetInfTecWeb_TramiteID],
	[Oficina] as [DetInfTecWeb_Oficina],
	[NombreEmpresa] as [DetInfTecWeb_NombreEmpresa],
	[NombrePromocion] as [DetInfTecWeb_NombrePromocion],
	[CadenaCiteResolucion] as [DetInfTecWeb_CadenaCiteResolucion],
	[FechaResolucion] as [DetInfTecWeb_FechaResolucion],
	[CadenaCiteInfTecnico] as [DetInfTecWeb_CadenaCiteInfTecnico],
	[FechaInfTecnico] as [DetInfTecWeb_FechaInfTecnico],
	[ValorComercial] as [DetInfTecWeb_ValorComercial],
	[ValorIndeterminado] as [DetInfTecWeb_ValorIndeterminado],
	[FechaInicio] as [DetInfTecWeb_FechaInicio],
	[Flujo] as [DetInfTecWeb_Flujo];
SQL

select 
	pr.TramiteID,
	case
		when pr.OficinaID=1001
		then 'DRLP'
		when pr.OficinaID=1002
		then 'DRSC'
		when pr.OficinaID=1003
		then 'DRCB'
	end Oficina,
	pj.NombreEmpresa,
	pr.NombrePromocion,
	pr.CadenaCiteResolucion,
	CONVERT(date, pr.FechaResolucion, 105) FechaResolucion,
	pr.CadenaCiteInfTecnico,
	CONVERT(date, pr.FechaInfTecnico, 105) FechaInfTecnico,
	pr.ValorComercial,
	case
		when pr.ValorIndeterminado=1
		then 'SI'
		when pr.ValorIndeterminado=0
		then 'NO'
		else ' '
	end ValorIndeterminado,
	tram.FechaInicio,
	(select fl.Nombre from [192.168.3.44].[SIAJPRODUCCION].[dbo].[Procesos.Flujos] as fl where fl.FlujoID= (select top 1 FlujoID from [192.168.3.44].[SIAJPRODUCCION].[dbo].[Tramites.DetallesTramites] as det where det.TramiteID=tram.TramiteID)) Flujo
from 
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[PromocionesEmpresariales.PromocionesEmpresariales] as pr,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Correspondencia.Recepciones] as rec,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Tramites.Tramites] as tram,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Personas.PersonasJuridicas] as pj
where 
	pr.TramiteID=rec.TramiteID and
	tram.TramiteID=rec.TramiteID and
	pr.EstadoID=1000 and
	pr.PersonaID=pj.PersonaID
	and (select fl.Nombre from [192.168.3.44].[SIAJPRODUCCION].[dbo].[Procesos.Flujos] as fl where fl.FlujoID= (select top 1 FlujoID from [192.168.3.44].[SIAJPRODUCCION].[dbo].[Tramites.DetallesTramites] as det where det.TramiteID=tram.TramiteID))
		like 'AUTORIZACIÓN PROMOCIONES EMPRESARIALES VIA WEB v%';
		

/* ---/////******* INFORMES AUTORIZACIÓN PROMOCIONES EMPRESARIALES v4.0 ****** INFORMES AUTORIZACIÓN PROMOCIONES EMPRESARIALES VIA WEB v4.0**********************/

InformesTecnicosAutorizacionesViaWebViaPersonal:
load 
	[TramiteID] as [InfTecWebViaPersonal_TramiteID],
	[Oficina] as [InfTecWebViaPersonal_Oficina],
	[NombreEmpresa] as [InfTecWebViaPersonal_NombreEmpresa],
	[NombrePromocion] as [InfTecWebViaPersonal_NombrePromocion],
	[CadenaCiteResolucion] as [InfTecWebViaPersonal_CadenaCiteResolucion],
	[FechaResolucion] as [InfTecWebViaPersonal_FechaResolucion],
	[CadenaCiteInfTecnico] as [InfTecWebViaPersonal_CadenaCiteInfTecnico],
	[FechaInformeTecnico] as [InfTecWebViaPersonal_FechaInfTecnico],
	[ValorComercial] as [InfTecWebViaPersonal_ValorComercial],
	[ValorIndeterminado] as [InfTecWebViaPersonal_ValorIndeterminado],
	[FechaInicio] as [InfTecWebViaPersonal_FechaInicio],
	[Flujo] as [InfTecWebViaPersonal_Flujo];
SQL

select 
	pr.TramiteID,
	case
		when pr.OficinaID=1001
		then 'DRLP'
		when pr.OficinaID=1002
		then 'DRSC'
		when pr.OficinaID=1003
		then 'DRCB'
	end Oficina,
	pj.NombreEmpresa,
	pr.NombrePromocion,
	pr.CadenaCiteResolucion,
	CONVERT(date, pr.FechaResolucion, 105) as FechaResolucion,
	pr.CadenaCiteInfTecnico,
	CONVERT(date, pr.FechaInfTecnico, 105) as FechaInformeTecnico,
	pr.ValorComercial,
	case
		when pr.ValorIndeterminado=1
		then 'SI'
		when pr.ValorIndeterminado=0
		then 'NO'
		else ' '
	end ValorIndeterminado,
	tram.FechaInicio,
	(select fl.Nombre from [192.168.3.44].[SIAJPRODUCCION].[dbo].[Procesos.Flujos] as fl where fl.FlujoID= (select top 1 FlujoID from [192.168.3.44].[SIAJPRODUCCION].[dbo].[Tramites.DetallesTramites] as det where det.TramiteID=tram.TramiteID)) as Flujo
from 
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[PromocionesEmpresariales.PromocionesEmpresariales] as pr,
	/*[192.168.3.44].[SIAJPRODUCCION].[dbo].[Correspondencia.Recepciones] as rec,*/
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Tramites.TramitesFlujosRecepciones] as rec,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Tramites.Tramites] as tram,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Personas.PersonasJuridicas] as pj
where 
	pr.TramiteID=rec.TramiteID and
	tram.TramiteID=rec.TramiteID and
	pr.EstadoID=1000 and
	pr.PersonaID=pj.PersonaID
	and (select fl.Nombre from [192.168.3.44].[SIAJPRODUCCION].[dbo].[Procesos.Flujos] as fl where fl.FlujoID= (select top 1 FlujoID from [192.168.3.44].[SIAJPRODUCCION].[dbo].[Tramites.DetallesTramites] as det where det.TramiteID=tram.TramiteID))
		like 'AUTORIZACIÓN PROMOCIONES EMPRESARIALES v%';

/* ---/////******* RESOLUCIONES ADMINISTRATIVAS DE AMPLIACION ****************************/

InformesTecnicosAmpliacionesPromEmp:
load 
	[TramiteID] as [InfTecAmpliacionPE_TramiteID],
	[Oficina] as [InfTecAmpliacionPE_Oficina],
	[NombreEmpresa] as [InfTecAmpliacionPE_NombreEmpresa],
	[NombrePromocion] as [InfTecAmpliacionPE_NombrePromocion],
	[CadenaCiteResolucion] as [InfTecAmpliacionPE_CadenaCiteResolucion],
	[FechaResolucion] as [InfTecAmpliacionPE_FechaResolucion],
	[CadenaCiteInfTecnico] as [InfTecAmpliacionPE_CadenaCiteInfTecnico],
	[FechaInformeTecnico] as [InfTecAmpliacionPE_FechaInfTecnico],
	[ValorComercial] as [InfTecAmpliacionPE_ValorComercial],
	[ValorIndeterminado] as [InfTecAmpliacionPE_ValorIndeterminado],
	[FechaInicio] as [InfTecAmpliacionPE_FechaInicio];
SQL

select 
	apr.TramiteID,
	case
		when pr.OficinaID=1001
		then 'DRLP'
		when pr.OficinaID=1002
		then 'DRSC'
		when pr.OficinaID=1003
		then 'DRCB'
	end Oficina,
	pj.NombreEmpresa,
	pr.NombrePromocion,
	apr.CadenaCiteResolucion,
	CONVERT(date, apr.FechaResolucion, 105) AS FechaResolucion,
	(select top 1 CadenaCite from [192.168.3.44].[SIAJPRODUCCION].[dbo].[Cites.Cites] as cit where cit.CadenaCite like '%/DF/INF/%' and cit.TramiteID = apr.TramiteID and cit.EstadoID=1000) as CadenaCiteInfTecnico,
	CONVERT(date, (select top 1 cit.FechaDocumento from [192.168.3.44].[SIAJPRODUCCION].[dbo].[Cites.Cites] as cit where cit.CadenaCite like '%/DF/INF/%' and cit.TramiteID = apr.TramiteID and cit.EstadoID=1000), 105) as FechaInformeTecnico,
	pr.ValorComercial,
	case
		when pr.ValorIndeterminado=1
		then 'SI'
		when pr.ValorIndeterminado=0
		then 'NO'
		else ' '
	end ValorIndeterminado,
	tram.FechaInicio
from 
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[PromocionesEmpresariales.PromocionesEmpresariales] as pr,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[PromocionesEmpresariales.AmpliacionesPromocionesEmpresariales] as apr,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Tramites.Tramites] as tram,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Personas.PersonasJuridicas] as pj
where 
	pr.PromocionEmpresarialID = apr.PromocionEmpresarialID and
	apr.tramiteId = tram.TramiteID and
	apr.EstadoID=1000 and
	pr.PersonaID=pj.PersonaID;

/* ---/////******* INFORMES TECNICOS SANCIONADOR de PE AUTORIZADO ****************************/
InformesTecnicosSancionadorPEAutorizadas:
load 
	[TramiteID] as [InfTecSancionadorPEA_TramiteID],
	[TipoSancionador] as [InfTecSancionadorPEA_TipoSancionador],
	[Oficina] as [InfTecSancionadorPEA_Oficina],
	[NombreEmpresa] as [InfTecSancionadorPEA_NombreEmpresa],
	[InfTecnico] as [InfTecSancionadorPEA_InfTecnico],
	[FechaInfTecnico] as [InfTecSancionadorPEA_FechaInfTecnico],
	[UsuarioGeneracion] as [InfTecSancionadorPEA_UsuarioGeneracion],
	[FechaInicioTramite] as [InfTecSancionadorPEA_FechaInicioTramite],
	[NoAAPA] as [InfTecSancionadorPEA_NoAAPA],
	[FechaAAPA] as [InfTecSancionadorPEA_FechaAAPA],
	[NoRS] as [InfTecSancionadorPEA_NoRS],
	[FechaRS] as [InfTecSancionadorPEA_FechaRS];
SQL

select 
	ps.TramiteID,
	'PROCESO SANCIONADOR A PROMOCIONES EMPRESARIALES AUTORIZADAS' as TipoSancionador,
	case
		when ps.OficinaID=1001
		then 'DRLP'
		when ps.OficinaID=1002
		then 'DRSC'
		when ps.OficinaID=1003
		then 'DRCB'
	end Oficina,
	pj.NombreEmpresa,
	ps.CadenaCiteInformeTecnico as InfTecnico,
	CONVERT(date, ps.FechaInformeTecnico, 105) as FechaInfTecnico,
	perNat.ApellidoPaterno + ' ' + perNat.ApellidoMaterno + ' ' + perNat.Nombres as UsuarioGeneracion,
	tram.FechaInicio as FechaInicioTramite,
	ps.CadenaCiteAAPA as NoAAPA,
	ps.FechaCiteAAPA as FechaAAPA,
	ps.CadenaCiteRS as NoRS,
	ps.FechaRS
from 
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[PromocionesEmpresariales.ProcesosSanciones] as ps,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[PromocionesEmpresariales.Sanciones] as p,
  	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Correspondencia.Recepciones] as rec,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Tramites.Tramites] as tram,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Personas.PersonasJuridicas] as pj,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Cites.Cites] as cit,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Usuarios.Usuarios] as usu,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Personas.PersonasNaturales] perNat
where 
	usu.UsuarioID = cit.UsuarioID and
	perNat.PersonaID = usu.PersonaID and
	cit.CiteID = ps.CiteInformeTecnicoID and
	ps.TramiteID=rec.TramiteID and
	tram.TramiteID=rec.TramiteID and
	ps.EstadoID=1000 and
	p.PersonaID=pj.PersonaID and
	p.SancionID = ps.SancionID;

/* ---/////******* INFORMES TECNICOS SANCIONADOR de PE DETECTADAS ****************************/
InformesTecnicosSancionadorPEAutorizadas:
load 
	[TramiteID] as [InfTecSancionadorPED_TramiteID],
	[TipoSancionador] as [InfTecSancionadorPED_TipoSancionador],
	[Oficina] as [InfTecSancionadorPED_Oficina],
	[NombreEmpresa] as [InfTecSancionadorPED_NombreEmpresa],
	[InfTecnico] as [InfTecSancionadorPED_InfTecnico],
	[FechaInfTecnico] as [InfTecSancionadorPED_FechaInfTecnico],
	[UsuarioGeneracion] as [InfTecSancionadorPED_UsuarioGeneracion],
	[FechaInicioTramite] as [InfTecSancionadorPED_FechaInicioTramite],
	[NoAAPA] as [InfTecSancionadorPED_NoAAPA],
	[FechaAAPA] as [InfTecSancionadorPED_FechaAAPA],
	[NoRS] as [InfTecSancionadorPED_NoRS],
	[FechaRS] as [InfTecSancionadorPED_FechaRS];
SQL

select 
	ps.TramiteID,
	'PROCESO SANCIONADOR A PROMOCIONES EMPRESARIALES DETECTADAS' as TipoSancionador,
	case
		when ps.OficinaID=1001
		then 'DRLP'
		when ps.OficinaID=1002
		then 'DRSC'
		when ps.OficinaID=1003
		then 'DRCB'
	end Oficina,
	p.NombreEmpresa,
	ps.CadenaCiteInformeTecnico as InfTecnico,
	CONVERT(date, ps.FechaInformeTecnico, 105) as FechaInfTecnico,
	perNat.ApellidoPaterno + ' ' + perNat.ApellidoMaterno + ' ' + perNat.Nombres as UsuarioGeneracion,
	tram.FechaInicio as FechaInicioTramite,
	ps.CadenaCiteAAPA as NoAAPA,
	ps.FechaCiteAAPA as FechaAAPA,
	ps.CadenaCiteRS as NoRS,
	ps.FechaRS
from 
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Sanciones.ProcesosSancionesEmpresas] as ps,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Sanciones.SancionesEmpresas] as p,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Correspondencia.Recepciones] as rec,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Tramites.Tramites] as tram,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Cites.Cites] as cit,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Usuarios.Usuarios] as usu,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Personas.PersonasNaturales] perNat
where 
	usu.UsuarioID = cit.UsuarioID and
	perNat.PersonaID = usu.PersonaID and
	cit.CiteID = ps.CiteInformeTecnicoID and
	ps.TramiteID=rec.TramiteID and
	tram.TramiteID=rec.TramiteID and
	ps.EstadoID=1000 and
	p.SancionEmpresaID = ps.SancionEmpresaID;
