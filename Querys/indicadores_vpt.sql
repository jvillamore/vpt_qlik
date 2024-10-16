
--indicador 1

select count(*) from [ODS.VPTResolucionesRegulatorias] as rr where rr.NumeroResolucion !='' and 2024 = YEAR(rr.fecharesolucion) and 9>= MONTH(rr.fecharesolucion);

select * from  	[ODS.VPTIndicadoresGestion] ;
select * from [ODS.VPTResolucionesRegulatorias] as rr 
where 2024 = YEAR(rr.fecharesolucion) and 9>= MONTH(rr.fecharesolucion)
and rr.NumeroResolucion !='';


-- Solo hasta el 2022
-- Indicador 2. Licencias
select *
from MINAJPRODUCCION.dbo.[ODS.VPTLicenciasOperaciones];


-- indicador 3
-- 99
select YEAR (r.fecha_emision), month (r.fecha_emision), count(*)
--,count(*)
from vpt.aut_pe r
where year(r.fecha_emision)>=2024
group by YEAR (r.fecha_emision), month (r.fecha_emision)
order by 1 desc, 2 desc;



select 
YEAR (r.periodo), month (r.periodo), sum(r.TotalFiscalizaciones)--,
--count(*)
from [ODS.VPTFiscalizacionesJLAS] r
group by YEAR (r.periodo), month (r.periodo)
order by 1 desc, 2 desc;

select --YEAR (r.periodo), month (r.periodo), sum(r.TotalFiscalizaciones)
count(*)
from [ODS.VPTFiscalizacionesJLAS] r
--group by YEAR (r.periodo), month (r.periodo)
--order by 1 desc, 2 desc
;

select
			count(*)
from
			vpt.ViewSolicitAutoriz
where
			year([FechaComodin VPT])= 2024
	and month([FechaComodin VPT])<= 9;



SELECT
	ap.empresa EmpresaVPT,
	ap.nit NITVPT,
	nombre_promo PromocionVPT,
	case
		when ap.depto IN ('LA PAZ', 'ORURO', 'POTOSI') then 'DRLP'
		when ap.depto IN ('COCHABAMBA', 'CHUQUISACA', 'TARIJA') then 'DRCB'
		when ap.depto = 'SANTA CRUZ' then 'DRSC'
	end OficinaVPT,
	ap.actividad TipoProcesoVPT,
	cast(ap.fecha_emision as datetime) 'Fecha Emisión RAA VPT',
	ap.estado_tramite EstadoAutorizacionVPT,
	ap.cite CiteResolucionVPT,
	isnull((
	select
		max(TramiteId)
	from
		[AlmacenCorporativo.PromocionesEmpresariales] b
	where
		rtrim(ltrim(b.CiteAutorizacionRechazo))= rtrim(ltrim(ap.cite))
		and rtrim(ltrim(b.DocumentoIdentidad))= rtrim(ltrim(ap.nit))),
	0) TramiteID,
	ap.fecha_emision 'Fecha Inicio Proceso VPT',
	ap.fecha_emision 'FechaComodin VPT',
	ap.estado_tramite 'EstadoAutorizacionActualVPT'
FROM
	vpt.aut_pe ap
where
	year(ap.fecha_emision)>= 2024
	and month(ap.fecha_emision)<= 9
;

SELECT 
--year(ap.fecha_emision),month(ap.fecha_emision),
count(*)
/*
ap.empresa EmpresaVPT,ap.nit NITVPT,nombre_promo PromocionVPT,
case
         when ap.depto IN ('LA PAZ','ORURO','POTOSI')   then 'DRLP'
         when ap.depto IN ('COCHABAMBA','CHUQUISACA','TARIJA') then 'DRCB'
	     when ap.depto='SANTA CRUZ' then 'DRSC'
end OficinaVPT, ap.actividad TipoProcesoVPT,cast(ap.fecha_emision as datetime) 'Fecha Emisión RAA VPT',
ap.estado_tramite EstadoAutorizacionVPT, ap.cite CiteResolucionVPT,
isnull((select max(TramiteId) from [AlmacenCorporativo.PromocionesEmpresariales] b where rtrim(ltrim(b.CiteAutorizacionRechazo))=rtrim(ltrim(ap.cite))
and rtrim(ltrim(b.DocumentoIdentidad))=rtrim(ltrim(ap.nit))),0) TramiteID,
ap.fecha_emision 'Fecha Inicio Proceso VPT',ap.fecha_emision 'FechaComodin VPT',
ap.estado_tramite 'EstadoAutorizacionActualVPT'
*/
FROM vpt.aut_pe ap
where 1=1
and year(ap.fecha_emision)>=2024 and month(ap.fecha_emision)<=09
--group by year(ap.fecha_emision), month(ap.fecha_emision)
;

-- Consulta buena, se debe remplazar en QLIk
	 select month(ti.FechaIngles)  ,
--sum(	  tra.CantidadSolicitud  ) --980
	sum( COALESCE(tra.CantidadAutorizado,0))
	+	sum(COALESCE( tra.CantidadRechazado,0) ) -- 882
--	+	sum(COALESCE (tra.ca ,0))
   from [MINAJPRODUCCION].dbo.[Datawarehouse.THPromociones] tra,
        [MINAJPRODUCCION].dbo.[Datawarehouse.DimGrupoTipoEstadoTramites]  gt,
		[MINAJPRODUCCION].dbo.[Datawarehouse.DimOficinaDepartamentoEmpresa] em,
	   dbo.[Datawarehouse.DimEstadosProcesos]               ep,
	    [MINAJPRODUCCION].dbo.[Datawarehouse.DimTiempo] ti
where tra.DimGrupoTipoEstadoTramiteID          =   gt.DimGrupoTipoEstadoTramiteID
  -- //and gt.EstadoTramite                                   =  $(vEstadoActivo)
    and ti.DimTiempoID  						 =   tra.DimTiempoID
	and em.DimJurisdiccionEmpresaID       =   tra.[DimDireccionEmpresaTipoPremioID]
	and tra.DimEstadoProcesoID = ep.DimEstadoProcesoID
	and year(ti.FechaIngles)  = 2024
	and month(ti.FechaIngles)  <= 9
	group by month(ti.FechaIngles) --, --,tra.CantidadSolicitud
--	tra.CantidadAutorizado
	--tra.CantidadRechazado
	order by 1,2;

--denominador indicador 3
	 select month(ti.FechaIngles)  ,
sum(	  tra.CantidadSolicitud  ) --980
   from [MINAJPRODUCCION].dbo.[Datawarehouse.THPromociones] tra,
        [MINAJPRODUCCION].dbo.[Datawarehouse.DimGrupoTipoEstadoTramites]  gt,
		[MINAJPRODUCCION].dbo.[Datawarehouse.DimOficinaDepartamentoEmpresa] em,
	   dbo.[Datawarehouse.DimEstadosProcesos]               ep,
	    [MINAJPRODUCCION].dbo.[Datawarehouse.DimTiempo] ti
where tra.DimGrupoTipoEstadoTramiteID          =   gt.DimGrupoTipoEstadoTramiteID
  -- //and gt.EstadoTramite                                   =  $(vEstadoActivo)
    and ti.DimTiempoID  						 =   tra.DimTiempoID
	and em.DimJurisdiccionEmpresaID       =   tra.[DimDireccionEmpresaTipoPremioID]
	and tra.DimEstadoProcesoID = ep.DimEstadoProcesoID
	and  year(ti.FechaIngles)  = 2024
	and month(ti.FechaIngles)  <= 9
	group by month(ti.FechaIngles);


-- indicador 4
--F
-- indicador 5
select 
YEAR (r.periodo), month (r.periodo), sum(r.TotalFiscalizaciones)
--count(*)
from MINAJPRODUCCION.dbo.[ODS.VPTFiscalizacionesPE] r
group by YEAR (r.periodo), month (r.periodo)
order by 1 desc, 2 desc;

select 
YEAR (r.periodo), sum(r.TotalFiscalizaciones)
--count(*)
from MINAJPRODUCCION.dbo.[ODS.VPTFiscalizacionesPE] r
group by YEAR (r.periodo)
order by 1 desc, 2 desc;


-- Indicador 6
select 
YEAR (r.periodo), month (r.periodo), sum(r.TotalControles)
--count(*)
from MINAJPRODUCCION.dbo.[ODS.VPTControlesJLAS]  r
group by YEAR (r.periodo), month (r.periodo)
order by 1 desc, 2 desc;

select 
YEAR (r.periodo), sum(r.TotalControles)
--count(*)
from MINAJPRODUCCION.dbo.[ODS.VPTControlesJLAS]  r
group by YEAR (r.periodo)
order by 1 desc, 2 desc;

-- indicador 7

select 
YEAR (r.periodo), month (r.periodo), sum(r.TotalControles)
--count(*)
from MINAJPRODUCCION.dbo.[ODS.VPTControlesPE] r
where r.TipoActividad ='PROMOCIONES EMPRESARIALES'
group by YEAR (r.periodo), month (r.periodo)
order by 1 desc, 2 desc;


-- QLIK

select
			sum(isnull(lpz, 0)+ isnull(oru, 0)+ isnull(pot, 0) + isnull(cbba, 0) + isnull(chq, 0) + isnull(tja, 0) + isnull(scz, 0) + isnull(ben, 0) + isnull(pan, 0))
		from
			vpt.controles_pe cp
		where
			anio = 2024
			and [vpt].fnMesNumerico(cp.mes)<= 9;
		
		
select
			sum(isnull(lpz, 0)+ isnull(oru, 0)+ isnull(pot, 0) + isnull(cbba, 0) + isnull(chq, 0) + isnull(tja, 0) + isnull(scz, 0) + isnull(ben, 0) + isnull(pan, 0))
from
			vpt.controles_pe cp
where
			anio = 2024
	and [vpt].fnMesNumerico(cp.mes)<= 9;

select cp.anio, cp.mes, sum(isnull(lpz, 0)+ isnull(oru, 0)+ isnull(pot, 0) + isnull(cbba, 0) + isnull(chq, 0) + isnull(tja, 0) + isnull(scz, 0) + isnull(ben, 0) + isnull(pan, 0))
--			sum(isnull(lpz, 0)+ isnull(oru, 0)+ isnull(pot, 0) + isnull(cbba, 0) + isnull(chq, 0) + isnull(tja, 0) + isnull(scz, 0) + isnull(ben, 0) + isnull(pan, 0))
from
			vpt.controles_pe cp
where
			anio = 2024
	and [vpt].fnMesNumerico(cp.mes)<= 9
group by cp.anio, cp.mes
order by 1 ,2 ;


/*
select *
--YEAR (r.periodo), month (r.periodo), count(r.TotalControles)
--count(*)
from MINAJPRODUCCION.dbo.[ODS.VPTControlesPE] r
where r.TipoActividad ='PROMOCIONES EMPRESARIALES'
group by YEAR (r.periodo), month (r.periodo)
order by 1 desc, 2 desc;


select * --count(*)
--YEAR (r.periodo), month (r.periodo), count(r.TotalControles)
--count(*)
from MINAJPRODUCCION.dbo.[ODS.VPTControlesPE] r
where r.TipoActividad ='PROMOCIONES EMPRESARIALES'
and month(r.Periodo) = 01
and year (r.Periodo)=2024
;
*/
-- Indicador 8

select 
YEAR (r.periodo), month (r.periodo), sum(r.TotalControles)
--count(*)
from MINAJPRODUCCION.dbo.[ODS.VPTControlesPE] r
where r.TipoActividad ='VISITAS PE'
group by YEAR (r.periodo), month (r.periodo)
order by 1 desc, 2 desc;

-- Indicador 9

select 
YEAR (r.periodo), month (r.periodo), count(*)
--count(*)
from MINAJPRODUCCION.dbo.[ODS.VPTIntervenciones] r
--where r.TipoActividad ='VISITAS PE'
group by YEAR (r.periodo), month (r.periodo)
order by 1 desc, 2 desc;

-- indicador 10
-- Numerador
select 
YEAR (r.periodo), month (r.periodo), count(*)
--count(*)
from dbo.[ODS.VPTResolucionesSancionatoriasMontosImpuestos] r
--where r.TipoActividad ='VISITAS PE'
group by YEAR (r.periodo), month (r.periodo)
order by 1 desc, 2 desc;

-- Denominador
select 
YEAR (r.fecha), month (r.fecha), count(*)
from vpt.cant_aapa r
group by YEAR (r.fecha), month (r.fecha)
order by 1 desc, 2 desc;

-- Indicador 11
-- Numerador
select 
YEAR (r.periodo), month (r.periodo), count(*)
--count(*)
from dbo.[ODS.VPTRecursosRevocatoriasConfirmados] r
where r.FormaResolucion  like '%CONFIRM%'
group by YEAR (r.periodo), month (r.periodo)
order by 1 desc, 2 desc;

-- Denominador
select 
YEAR (r.periodo), month (r.periodo), count(*)
--count(*)
from dbo.[ODS.VPTRecursosRevocatorias] r
--where r.EstadoTramite like '%CONFIRM%'
group by YEAR (r.periodo), month (r.periodo)
order by 1 desc, 2 desc;

-- Indicador 12
-- Numerador
select 
YEAR (r.periodo), month (r.periodo), count(*)
--count(*)
from dbo.[ODS.VPTRecursosJerarquicosConfirmados] r
--where r.FormaResolucion  like '%CONFIRM%'
group by YEAR (r.periodo), month (r.periodo)
order by 1 desc, 2 desc;

-- Numerador test
select *
--YEAR (r.periodo), month (r.periodo), count(*)
--count(*)
from dbo.[ODS.VPTRecursosJerarquicosConfirmados] r
where YEAR (r.periodo)=2024
and month (r.periodo) <=9
--where r.FormaResolucion  like '%CONFIRM%'
--group by YEAR (r.periodo), month (r.periodo)
order by 1 desc, 2 desc;

-- Denominador
select 
YEAR (r.periodo), month (r.periodo), count(*)
--count(*)
from dbo.[ODS.VPTRecursosJerarquicos] r
--where r.EstadoTramite like '%CONFIRM%'
group by YEAR (r.periodo), month (r.periodo)
order by 1 desc, 2 desc;


-- indicador 13
select 
YEAR (r.periodo), month (r.periodo), count(*)
--count(*)
from dbo.[ODS.VPTFiscalizacionesPE]  r
--where r.FormaResolucion  like '%CONFIRM%'
group by YEAR (r.periodo), month (r.periodo)
order by 1 desc, 2 desc;

-- indicador 14
select 
YEAR (r.periodo), month (r.periodo), sum(r.TotalControles)
--count(*)
from dbo.[ODS.VPTControlesPE] r
--where r.FormaResolucion  like '%CONFIRM%'
group by YEAR (r.periodo), month (r.periodo)
order by 1 desc, 2 desc;


select *
----count(*)
from dbo.[ODS.VPTControlesPE] r
--where r.FormaResolucion  like '%CONFIRM%'
--group by YEAR (r.periodo), month (r.periodo)
where YEAR (r.periodo)=2024 and month (r.periodo) =01
order by 1 desc, 2 desc;

--127
select count(r.TotalControles )
from dbo.[ODS.VPTControlesPE] r
--where r.FormaResolucion  like '%CONFIRM%'
where YEAR (r.periodo)=2024 and month (r.periodo) =01
and r.TipoActividad ='PROMOCIONES EMPRESARIALES'
group by r.periodo
order by 1 desc;

select *
from dbo.[ODS.VPTControlesPE] r
--where r.FormaResolucion  like '%CONFIRM%'
where YEAR (r.periodo)=2024 and month (r.periodo) =01
and r.TipoActividad ='PROMOCIONES EMPRESARIALES'
order by 1 desc;


select *
from dbo.[ODS.VPTControlesPE] r
--where r.FormaResolucion  like '%CONFIRM%'
where YEAR (r.periodo)=2024 and month (r.periodo) =01
and r.TipoActividad ='PROMOCIONES EMPRESARIALES'
and r.PromocionEmpresarial IN(
'“NAVIDAD JUNTO A CHOCOLATES EL CEIBO”',
'“¡EJERCÍTATE SIN LÍMITES!”',
'“SORTEO GRATIS ZONA CARNAVALERA”',
'“AÑO NUEVO CON MOTO NUEVA"',
'“LA REGALONA DE CASAMIA”',
' “LA REGALONA DE CASAMIA”',
'“CELEBRA Y DISFRUTA LA NAVIDAD CON IC NORTE”',
'“JUNTO A UNIBIENES, SIEMPRE”',
'“CONTINENTAL TE SORPRENDE 2”',
'CONTINENTAL TE SORPRENDE 2',--OJ
'“CELEBRA Y DISFRUTA LA NAVIDAD CON IC NORTE”',
'“LA REGALONA DE CASAMIA”',
'“NAVIDAD JUNTO A CHOCOLATES EL CEIBO”'
)
--or ControlPE in(12026, 12022)
order by 1 desc;

-- QLIK
select 
	(
	select
			sum(isnull(lpz, 0)+ isnull(oru, 0)+ isnull(pot, 0) + isnull(cbba, 0) + isnull(chq, 0) + isnull(tja, 0) + isnull(scz, 0) + isnull(ben, 0) + isnull(pan, 0))
	from
			vpt.controles_pe cp
	where
			anio = 2024
		and [vpt].fnMesNumerico(cp.mes)<= 9) + (
	select
			sum(isnull(lpz, 0)+ isnull(oru, 0)+ isnull(pot, 0) + isnull(cbba, 0)+ isnull(chq, 0) + isnull(tja, 0)+ isnull(scz, 0)+ isnull(tri, 0)+ isnull(cob, 0))
	from
			vpt.visitas_pe
	where
			anio = 2024
		and [vpt].fnMesNumerico(mes)<= 9);
	
	
select [vpt].fnMesNumerico(cp.mes) , sum(isnull(lpz, 0)), sum(isnull(oru, 0)), sum(isnull(pot, 0)), sum(isnull(cbba , 0)), sum(isnull(chq, 0)), sum(isnull(tja , 0)), sum(isnull(scz , 0)), sum(isnull(ben , 0)), sum(isnull(pan , 0)) 
from
			vpt.controles_pe cp
	where
			anio = 2024
		and [vpt].fnMesNumerico(cp.mes)<= 9
	group by cp.mes
order by 1 desc;

select [vpt].fnMesNumerico(cp.mes) , sum(isnull(lpz, 0)), sum(isnull(oru, 0)), sum(isnull(pot, 0)), sum(isnull(cbba , 0)), sum(isnull(chq, 0)), sum(isnull(tja , 0)), sum(isnull(scz , 0)), sum(isnull(tri , 0)), sum(isnull(cob , 0)) 
from
 vpt.visitas_pe cp
	where
			anio = 2024
		and [vpt].fnMesNumerico(cp.mes)<= 9
	group by cp.mes
order by 1 desc;
	

	
	select 
anio, mes, sum(isnull(lpz, 0)+ isnull(oru, 0)+ isnull(pot, 0) + isnull(cbba, 0) + isnull(chq, 0) + isnull(tja, 0) + isnull(scz, 0) + isnull(ben, 0) + isnull(pan, 0))
--count(*)
from vpt.controles_pe  r
where anio=2024 and mes in('ene', 'feb', 'mar','abr','may','jun','jul','ago','sep')
group by anio, mes
order by 1 desc, 2 desc;


	
	select count(*)
--anio, mes, sum(isnull(lpz, 0)+ isnull(oru, 0)+ isnull(pot, 0) + isnull(cbba, 0) + isnull(chq, 0) + isnull(tja, 0) + isnull(scz, 0) + isnull(ben, 0) + isnull(pan, 0))
--count(*)
from vpt.controles_pe  r
where anio=2024 and mes in('ene')
order by 1 desc;


	select *
from vpt.controles_pe  r
where anio=2024 and mes in('ene')
order by 1 desc;




SELECT
	year(r.FechaActualizacion),
	month(r.FechaActualizacion),
	count(*)
FROM
	dbo.[AlmacenCorporativo.Personas] r
group by
	year(r.FechaActualizacion),
	month(r.FechaActualizacion)
order by
	1 desc,
	2 desc;
select * from dbo.[AlmacenCorporativo.Personas] r
where r.NombreEmpresaRazonSocial like '%OMNI%'

