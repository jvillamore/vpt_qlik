-- Obtener Cantida AAPA
select gt.DimGrupoTipoEstadoTramiteID,
        convert(varchar(10),  FechaAAPA ,112)'FechaSancion',                           
		em.DimJurisdiccionEmpresaID,
		ep.[DimEstadoProcesoID],
		count(distinct pr.CiteAAPA)        'Cantidad AAPAS'
  from dbo.[AlmacenCorporativo.Tramites]                    tr,
	   dbo.[AlmacenCorporativo.Sanciones]                   pr,
	   dbo.[Datawarehouse.DimOficinaDepartamentoEmpresa]    em ,
       dbo.[Datawarehouse.DimGrupoTipoEstadoTramites]       gt,
	    [dbo].[Datawarehouse.DimEstadosProcesos] ep
 where tr.EstadoDimTramite            in ('ACTUAL', 'NUEVO')
   and pr.estadociteaapa='ACTIVO'
   and pr.EstadoSancion='ACTIVO'
   and FechaAAPA is not null
   and ep.[ProcesoNegocio]=pr.procesonegocio
   and ep.[TipoProcesoNegocio]=pr.TipoProceso
   and ep.[EstadoProcesoNegocio]= pr.[EstadoProcesoNegocio]  
   and ep.[TipoEstadoProcesoNegocio] ='NO DEFINIDO' 
   and tr.TramiteID                   =  pr.TramiteID
   and tr.GrupoTramite                =  gt.grupotramite
   and tr.TipoTramite                 =  gt.tipotramite
   and tr.EstadoTramite               =  gt.EstadoTramite
   and em.Empresa                     =  pr.NombreEmpresa
   and em.Oficina                     =  pr.Oficina
   and  month(pr.FechaAAPA) =09
   and year (pr.FechaAAPA)=2024
  group by gt.DimGrupoTipoEstadoTramiteID,convert(varchar(10), pr.FechaAAPA,112),  em.DimJurisdiccionEmpresaID, ep.[DimEstadoProcesoID];


-- Consulta en el origen 
-- 13 CITES
select * from dbo.[AlmacenCorporativo.Sanciones] pr
 where 1=1 
  and  month(pr.FechaAAPA) =09
   and year (pr.FechaAAPA)=2024
   and   pr.CiteAAPA  IN(
'AJ/DRSC/DJ/AAPA/90/2024',
'AJ/DRSC/DJ/AAPA/100/2024',
'AJ/DRSC/DJ/AAPA/91/2024',
'AJ/DRSC/DJ/AAPA/92/2024',
'AJ/DRSC/DJ/AAPA/93/2024',
'AJ/DRSC/DJ/AAPA/94/2024',
'AJ/DRSC/DJ/AAPA/95/2024',
'AJ/DRSC/DJ/AAPA/98/2024',
'AJ/DRSC/DJ/AAPA/99/2024',
'AJ/DRSC/DJ/AAPA/96/2024',
'AJ/DRSC/DJ/AAPA/97/2024',
'AJ/DRSC/DJ/AAPA/101/2024',
'AJ/DRSC/DJ/AAPA/102/2024')
  order by pr.CiteAAPA;



  -- ETL Obtener cantidad RS
  select gt.DimGrupoTipoEstadoTramiteID,
        convert(varchar(10),  FechaRS ,112)'FechaSancion',                           
		em.DimJurisdiccionEmpresaID,
		ep.[DimEstadoProcesoID],
		count(distinct pr.CiteRS)        'Cantidad RS'
  from dbo.[AlmacenCorporativo.Tramites]                    tr,
	   dbo.[AlmacenCorporativo.Sanciones]                   pr,
	   dbo.[Datawarehouse.DimOficinaDepartamentoEmpresa]    em ,
	   [ODS.MontoUFV_CitesRS] mr,
       dbo.[Datawarehouse.DimGrupoTipoEstadoTramites]       gt,
	    [dbo].[Datawarehouse.DimEstadosProcesos] ep
 where tr.EstadoDimTramite            in ('ACTUAL', 'NUEVO')
    and pr.estadociters='ACTIVO'
  and pr.EstadoSancion='ACTIVO'
 and tr.TramiteID                   =  pr.TramiteID
   and tr.GrupoTramite                =  gt.grupotramite
   and tr.TipoTramite                 =  gt.tipotramite
   and tr.EstadoTramite               =  gt.EstadoTramite
   and em.Empresa                     = pr.NombreEmpresa
   and em.Oficina                     =  pr.Oficina
   and mr.CiteRS  = pr.CiteRS
   and ep.[EstadoProcesoNegocio]= pr.estadoprocesoNegocio
   and ep.[TipoProcesoNegocio]=pr.TipoProceso
   and ep.[TipoEstadoProcesoNegocio]= mr.EstadoRS
   and FechaRS is not null
   and ep.[ProcesoNegocio]=pr.[ProcesoNegocio]
   and  month(pr.FechaAAPA) =09
   and year (pr.FechaAAPA)=2024
   and em.Oficina='DIRECCION REGIONAL SANTA CRUZ'   
 group by gt.DimGrupoTipoEstadoTramiteID,convert(varchar(10), pr.FechaRS,112),  em.DimJurisdiccionEmpresaID, ep.[DimEstadoProcesoID]
union
 select gt.DimGrupoTipoEstadoTramiteID,
        convert(varchar(10),  FechaRS ,112)'FechaSancion',                           
		em.DimJurisdiccionEmpresaID,
		ep.[DimEstadoProcesoID],
		count(distinct pr.CiteRS)        'Cantidad RS'
   from dbo.[AlmacenCorporativo.Tramites]                    tr,
	   dbo.[AlmacenCorporativo.Sanciones]                   pr,
	   dbo.[Datawarehouse.DimOficinaDepartamentoEmpresa]    em ,
       dbo.[Datawarehouse.DimGrupoTipoEstadoTramites]       gt,
	    [dbo].[Datawarehouse.DimEstadosProcesos] ep
 where tr.EstadoDimTramite            in ('ACTUAL', 'NUEVO')
    and pr.estadociters='ACTIVO'
  and pr.EstadoSancion='ACTIVO'
 and tr.TramiteID                   =  pr.TramiteID
   and tr.GrupoTramite                =  gt.grupotramite
   and tr.TipoTramite                 =  gt.tipotramite
   and tr.EstadoTramite               =  gt.EstadoTramite
   and em.Empresa=  pr.NombreEmpresa 
   and em.Oficina                     =  pr.Oficina
   and pr.CiteRS not in (select mr.CiteRS from [ODS.MontoUFV_CitesRS] mr where mr.CiteRS=pr.CiteRS)
   and ep.[EstadoProcesoNegocio]=pr.estadoprocesonegocio
   and ep.[TipoEstadoProcesoNegocio]='NO DEFINIDO'
   and ep.[TipoProcesoNegocio]=pr.TipoProceso
   and FechaRS is not null 
   and ep.[ProcesoNegocio]=pr.[ProcesoNegocio]
    and  month(pr.FechaAAPA) =09
   and year (pr.FechaAAPA)=2024
   and em.Oficina='DIRECCION REGIONAL SANTA CRUZ'
 group by gt.DimGrupoTipoEstadoTramiteID,convert(varchar(10), pr.FechaRS,112),  em.DimJurisdiccionEmpresaID, ep.[DimEstadoProcesoID]
 order by gt.DimGrupoTipoEstadoTramiteID,convert(varchar(10), pr.FechaRS,112),  em.DimJurisdiccionEmpresaID, ep.[DimEstadoProcesoID]

 ;