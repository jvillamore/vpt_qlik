ResumenPromociones:
    load [Grupo Trámite]  				    as [Grupo Trámite],
	      [Tipo Trámite]   				    as [Tipo Trámite],
	      [Estado Trámite] 				    as [Estado Trámite],
		  [Direccion]      					    as [Dirección]  ,
		  [Año]            					    as [Año],
		  [Mes]            					    as [Mes],  
		  [Fecha Ingles]   				    as [Fecha Ingles], 
		  [Dia]          					    as [Dia],
	      [Semestre]       					    as [Semestre],
		  [Trimestre]      				    as [Trimestre],
		  [NumeroMes]                               as [NumeroMes],
		[Nombre/Empresa]                         as [Nombre/Empresa Total],		
		[Departamento]   as  [Departamento Total],
		[Tipo Actividad Económica]  as 		[Tipo Actividad Económica Total],
		[Proceso Negocio]   as [Proceso Negocio Total],
		[Tipo Proceso Negocio]   as [Tipo Proceso Negocio Total],
	    [CantidadSolicitudesPromociones]      as [CantidadSolicitudesPromociones],  
		[CantidadAutorizado]                      as [CantidadAutorizado],
		[CantidadRechazado]                      as [CantidadRechazado],
		[CantidadDesistido]                         as [CantidadDesistido],
		[CantidadEnProceso]                       as [CantidadEnProceso],
		[CantidadEnProcesoUltimo]                       as [CantidadEnProcesoUltimo],
		[MontoValorPremiosSolicitud]              as [Valor Comercial Total]  ,
		[MontoValorPremiosAutorizado]        as [MontoValorPremioAutorizado],
		[MontoValorPremiosSolicitud]    as  [MontoValorPremiosSolicitud];		
SQL
select gt.GrupoTramite                                                   'Grupo Trámite',
	     gt.TipoTramite                                                     'Tipo Trámite',
	     gt.EstadoTramite                                                  'Estado Trámite',
	     case
		 when em.Oficina ='DIRECCION NACIONAL'  then 'DNAL'
		 when em.Oficina='DIRECCION REGIONAL COCHABAMBA' then 'DRCB'
		 when em.Oficina='DIRECCION REGIONAL SANTA CRUZ'  then 'DRSC'
		 when em.Oficina='DIRECCION REGIONAL LA PAZ'          then 'DRLP'
  	    end 												 'Direccion',
  	    ti.Anio                                             'Año',
	    case   
            when month(convert(datetime, ti.FechaIngles ,103)) = 1 then  'ene'
            when month(convert(datetime, ti.FechaIngles ,103)) = 2 then  'feb'
            when month(convert(datetime, ti.FechaIngles ,103)) = 3 then  'mar'
            when month(convert(datetime, ti.FechaIngles ,103)) = 4 then  'abr'
            when month(convert(datetime, ti.FechaIngles ,103)) = 5 then  'may'
            when month(convert(datetime, ti.FechaIngles,103))  = 6 then  'jun'
            when month(convert(datetime, ti.FechaIngles ,103)) = 7 then  'jul'
            when month(convert(datetime, ti.FechaIngles ,103)) = 8 then  'ago'
            when month(convert(datetime, ti.FechaIngles ,103)) = 9 then  'sep'
            when month(convert(datetime, ti.FechaIngles ,103)) = 10 then 'oct'
            when month(convert(datetime, ti.FechaIngles ,103)) = 11 then 'nov'
            when month(convert(datetime, ti.FechaIngles ,103)) = 12 then 'dic'
            when month(convert(datetime, ti.FechaIngles ,103)) is null then 'NA'
          end 											      'Mes',  
	    ti.FechaIngles   									  'Fecha Ingles', 
	    ti.Dia           									  'Dia',
          ti.NombreSemestre 								      'Semestre',
	    ti.NombreTrimestre 									  'Trimestre',
	    ti.Mes 												  'NumeroMes',
		em.Empresa                                  'Nombre/Empresa',
		em.Departamento                            'Departamento',
		em.[TipoActividadEconomica]                'Tipo Actividad Económica',
		ep.ProcesoNegocio                          'Proceso Negocio',
		ep.TipoProcesoNegocio                       'Tipo Proceso Negocio',
	    tra.CantidadSolicitud                      'CantidadSolicitudesPromociones',
		tra.CantidadAutorizado                      'CantidadAutorizado',
		tra.CantidadRechazado                       'CantidadRechazado',
		tra.CantidadDesistidoConfirmado                       'CantidadDesistido',
		tra.CantidadEnProceso                       'CantidadEnProceso',
		tra.CantidadEnProcesoUltimo                 'CantidadEnProcesoUltimo',
		tra.[MontoValorPremiosSolicitud]               'MontoValorPremiosSolicitud'  ,
		tra.MontoValorPremiosAutorizado                'MontoValorPremiosAutorizado',
		MontoSancionadoRS			
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
	order by tra.CantidadAutorizado  ,  tra.MontoValorPremiosAutorizado desc  ;


ResumenSanciones:
load     [Grupo Trámite]  				    as [Grupo Trámite],
	      [Tipo Trámite]   				    as [Tipo Trámite],
	      [Estado Trámite] 				    as [Estado Trámite],
		  [Direccion]      					    as [Dirección]  ,
		  [Año]            					    as [Año],
		  [Mes]            					    as [Mes],  
		  [Fecha Ingles]   				    as [Fecha Ingles], 
		  [Dia]          					    as [Dia],
	      [Semestre]       					    as [Semestre],
		  [Trimestre]      				    as [Trimestre],
		  [NumeroMes]                               as [NumeroMes],
		[Nombre/Empresa]                         as [Nombre/Empresa Total],	
		[Departamento]   as  [Departamento Total],
		[Tipo Actividad Económica]  as 		[Tipo Actividad Económica Total],
		[Cantidad Pagos]              as  [Cantidad Pagos],
		[Estado Proceso Negocio]         as     [Estado Proceso Negocio],
		[Proceso Negocio]                  as   [Proceso Negocio],
		[Tipo Proceso Negocio]             as   [Tipo Proceso Negocio],
	   		[CantidadAAPA]     as    [CantidadAAPA],
		[CantidadRS]   as   [CantidadRS],
		[CantidadAFA]   as  [CantidadAFA] ,
		[CantidadRJ]   as   [CantidadRJ],
		[CantidadRR]   as   [CantidadRR],
		[MontoBS Pagado Total]   as   [MontoBS Pagado Total],
		[MontoUFV Pagado Total]   as  [MontoUFV Pagado Total] ,
		[MontoUFV RARR Total]   as   [MontoUFV RARR Total] ,
		[MontoUFV RJ Total]   as   [MontoUFV RJ Total] ,
		[MontoUFV AAPA Total]   as   [MontoUFV AAPA Total],
		[MontoUFV RS Total]   as  [MontoUFV RS Total]  ,
		[MontoBs Presentado Total]   as  [MontoBs Presentado Total],
		[MontoUFV Presentado Total]  as  		[MontoUFV Presentado Total],
		[CantidadPagos_Presentado]   as   [Cantidad Pagos Presentado];
SQL
select gt.GrupoTramite                                                   'Grupo Trámite',
	     gt.TipoTramite                                                     'Tipo Trámite',
	     gt.EstadoTramite                                                  'Estado Trámite',
	     case
		 when em.Oficina ='DIRECCION NACIONAL'  then 'DNAL'
		 when em.Oficina='DIRECCION REGIONAL COCHABAMBA' then 'DRCB'
		 when em.Oficina='DIRECCION REGIONAL SANTA CRUZ'  then 'DRSC'
		 when em.Oficina='DIRECCION REGIONAL LA PAZ'          then 'DRLP'
  	    end 												 'Direccion',
  	    ti.Anio                                             'Año',
	    case   
            when month(convert(datetime, ti.FechaIngles ,103)) = 1 then  'ene'
            when month(convert(datetime, ti.FechaIngles ,103)) = 2 then  'feb'
            when month(convert(datetime, ti.FechaIngles ,103)) = 3 then  'mar'
            when month(convert(datetime, ti.FechaIngles ,103)) = 4 then  'abr'
            when month(convert(datetime, ti.FechaIngles ,103)) = 5 then  'may'
            when month(convert(datetime, ti.FechaIngles,103)) = 6 then  'jun'
            when month(convert(datetime, ti.FechaIngles ,103)) = 7 then  'jul'
            when month(convert(datetime, ti.FechaIngles ,103)) = 8 then  'ago'
            when month(convert(datetime, ti.FechaIngles ,103)) = 9 then  'sep'
            when month(convert(datetime, ti.FechaIngles ,103)) = 10 then 'oct'
            when month(convert(datetime, ti.FechaIngles ,103)) = 11 then 'nov'
            when month(convert(datetime, ti.FechaIngles ,103)) = 12 then 'dic'
            when month(convert(datetime, ti.FechaIngles ,103)) is null then 'NA'
          end 											      'Mes',  
	    ti.FechaIngles   									  'Fecha Ingles', 
	    ti.Dia           									  'Dia',
          ti.NombreSemestre 								      'Semestre',
	    ti.NombreTrimestre 									  'Trimestre',
	    ti.Mes 												  'NumeroMes',
		em.Empresa                                  'Nombre/Empresa',
		em.Departamento                            'Departamento',
		em.[TipoActividadEconomica]                'Tipo Actividad Económica',
		tra.cantidadpagos                     'Cantidad Pagos',
		ep.EstadoProcesoNegocio               'Estado Proceso Negocio',
		ep.ProcesoNegocio                      'Proceso Negocio',
		ep.TipoProcesoNegocio                 'Tipo Proceso Negocio',
	    tra.CantidadAAPA                      'CantidadAAPA',
		tra.CantidadRS                      'CantidadRS',
		tra.CantidadAFA                       'CantidadAFA',
		tra.CantidadRJ                      'CantidadRJ',
		tra.CantidadRR                       'CantidadRR',
		tra.MontoPagadoBS                   'MontoBS Pagado Total',
		tra.MontoPagadoUFV                  'MontoUFV Pagado Total',
		tra.MontoRevocadoRARR               'MontoUFV RARR Total',
		tra.MontoRevocadoRJ                 'MontoUFV RJ Total',
		tra.MontoSancionadoAAPA             'MontoUFV AAPA Total',
		tra.MontoSancionadoRS               'MontoUFV RS Total',
		tra.[MontoPagadoUFV_Presentado] 'MontoUFV Presentado Total',
		tra.[MontoPagadoBS_Presentado] 'MontoBs Presentado Total',
		tra.[CantidadPagos_Presentado] 'CantidadPagos_Presentado'
   from [MINAJPRODUCCION].dbo.[Datawarehouse.THSanciones] tra,
        [MINAJPRODUCCION].dbo.[Datawarehouse.DimGrupoTipoEstadoTramites]  gt,
		[MINAJPRODUCCION].dbo.[Datawarehouse.DimOficinaDepartamentoEmpresa] em,		
      dbo.[Datawarehouse.DimEstadosProcesos] ep,
	    [MINAJPRODUCCION].dbo.[Datawarehouse.DimTiempo] ti
where tra.DimGrupoTipoEstadoTramiteID          =   gt.DimGrupoTipoEstadoTramiteID
    and ti.DimTiempoID  						 =   tra.DimTiempoID
	and em.DimJurisdiccionEmpresaID       =   tra.[DimJurisdiccionEmpresaID]
	and ep.[DimEstadoProcesoID]= tra.[DimEstadoProcesoID];

ResumenSanciones_aux:
load     [CantidadAutorizado1] 	    as [CantidadAutorizado1],
	      [Dirección]   			as [Dirección],
	      [Mes] 				    as [Mes],
		  [Año]      				as [Año];
SQL		  
 select sum(a.CantidadAutorizado1) CantidadAutorizado1,Dirección,Mes,Año
 from ViewPromAuto a
 group by Dirección,Mes,Año;

ResumenModalidades:
LOAD
  [Grupo Trámite]  				    as [Grupo Trámite],
	      [Tipo Trámite]   				    as [Tipo Trámite],
	      [Estado Trámite] 				    as [Estado Trámite],
		  [Direccion]      					    as [Dirección]  ,
		  [Año]            					    as [Año],
		  [Mes]            					    as [Mes],  
		  [Fecha Ingles]   				    as [Fecha Ingles], 
		  [Dia]          					    as [Dia],
	      [Semestre]       					    as [Semestre],
		  [Trimestre]      				    as [Trimestre],
		  [NumeroMes]                               as [NumeroMes],
		[Nombre/Empresa]                         as [Nombre/Empresa Total],		
		[Departamento]   as  [Departamento Total],
		[Tipo Actividad Económica]  as 		[Tipo Actividad Económica Total],
		[ModalidadPremiacionAgrupador]     as   [Modalidad Premiacion Agrupador Total],
		[ModalidadPremiacion]     as   [Modalidad Premiacion Total],
		[Clasificacion]     as   [Clasificacion Total],
		[ModalidadAzarSorteo]     as   [Modalidad Azar Sorteo Total],
		[PremiacionDirecta]     as   [Premiacion Directa Total],		
		[Proceso de Negocio]  as [Proceso de Negocio Mod Total],
		[Tipo Proceso de Negocio]  as [Tipo Proceso de Negocio Mod Total],
		[Estado Proceso Negocio]  as [Estado Proceso Negocio Mod Total],
		[Cantidad Promociones]     as   [Cantidad Promociones Total],
		[Monto Valor Modalidad]     as   [Monto Valor Modalidad Total]		;
SQL
select gt.GrupoTramite                                                   'Grupo Trámite',
	     gt.TipoTramite                                                     'Tipo Trámite',
	     gt.EstadoTramite                                                  'Estado Trámite',
	     case
		 when em.Oficina ='DIRECCION NACIONAL'  then 'DNAL'
		 when em.Oficina='DIRECCION REGIONAL COCHABAMBA' then 'DRCB'
		 when em.Oficina='DIRECCION REGIONAL SANTA CRUZ'  then 'DRSC'
		 when em.Oficina='DIRECCION REGIONAL LA PAZ'          then 'DRLP'
  	    end 												 'Direccion',
  	    ti.Anio                                             'Año',
	    case   
            when month(convert(datetime, ti.FechaIngles ,103)) = 1 then  'ene'
            when month(convert(datetime, ti.FechaIngles ,103)) = 2 then  'feb'
            when month(convert(datetime, ti.FechaIngles ,103)) = 3 then  'mar'
            when month(convert(datetime, ti.FechaIngles ,103)) = 4 then  'abr'
            when month(convert(datetime, ti.FechaIngles ,103)) = 5 then  'may'
            when month(convert(datetime, ti.FechaIngles,103))  = 6 then  'jun'
            when month(convert(datetime, ti.FechaIngles ,103)) = 7 then  'jul'
            when month(convert(datetime, ti.FechaIngles ,103)) = 8 then  'ago'
            when month(convert(datetime, ti.FechaIngles ,103)) = 9 then  'sep'
            when month(convert(datetime, ti.FechaIngles ,103)) = 10 then 'oct'
            when month(convert(datetime, ti.FechaIngles ,103)) = 11 then 'nov'
            when month(convert(datetime, ti.FechaIngles ,103)) = 12 then 'dic'
            when month(convert(datetime, ti.FechaIngles ,103)) is null then 'NA'
          end 											      'Mes',  
	    ti.FechaIngles   									  'Fecha Ingles', 
	    ti.Dia           									  'Dia',
          ti.NombreSemestre 								      'Semestre',
	    ti.NombreTrimestre 									  'Trimestre',
	    ti.Mes 												  'NumeroMes',
		em.Empresa                                  'Nombre/Empresa',
		em.Departamento                            'Departamento',
		mo.ModalidadPremiacionAgrupador          'ModalidadPremiacionAgrupador',
		mo.ModalidadPremiacion                  'ModalidadPremiacion',
		mo.Clasificacion                    'Clasificacion',
		mo.ModalidadAzarSorteo             'ModalidadAzarSorteo',
		mo.PremiacionDirecta             'PremiacionDirecta',
		ep.ProcesoNegocio                'Proceso de Negocio',
		ep.TipoProcesoNegocio            'Tipo Proceso de Negocio',
		ep.EstadoProcesoNegocio          'Estado Proceso Negocio',
		tra.[CantidadModalidade]                      'Cantidad Promociones',
		tra.[MontoValorPremio]                      'Monto Valor Modalidad'	,
		em.[TipoActividadEconomica]                'Tipo Actividad Económica'
   from [MINAJPRODUCCION].[dbo].[Datawarehouse.THModalidadesPremiaciones]tra,
        [MINAJPRODUCCION].dbo.[Datawarehouse.DimGrupoTipoEstadoTramites]  gt,
		[MINAJPRODUCCION].dbo.[Datawarehouse.DimOficinaDepartamentoEmpresa] em,
		[MINAJPRODUCCION].dbo.[Datawarehouse.DimEstadosProcesos] ep,
	    [MINAJPRODUCCION].dbo.[Datawarehouse.DimTiempo] ti,
		[Datawarehouse.DimModalidadesPremiaciones] mo
  where ep.EstadoProcesoNegocio='ACTIVO'
    and gt.DimGrupoTipoEstadoTramiteID          =   tra.DimGrupoTipoEstadoTramiteID
    and ti.DimTiempoID  						 =   tra.DimTiempoID
	and em.DimJurisdiccionEmpresaID       =   tra.[DimJurisdiccionEmpresaID]
	and mo.DimTipoModalidadPremiacionID   =tra.[DimTipoModalidadPremiacionID]
	and ep.DimEstadoProcesoID             =  tra.[DimEstadoProcesoID];

ResumenProcesoFiscalizacion:
   load 
  [Grupo Trámite]  				    as [Grupo Trámite],
	      [Tipo Trámite]   				    as [Tipo Trámite],
	      [Estado Trámite] 				    as [Estado Trámite],
		  [Direccion]      					    as [Dirección]  ,
		  [Año]            					    as [Año],
		  [Mes]            					    as [Mes],  
		  [Fecha Ingles]   				    as [Fecha Ingles], 
		  [Dia]          					    as [Dia],
	      [Semestre]       					    as [Semestre],
		  [Trimestre]      				    as [Trimestre],
		  [NumeroMes]                               as [NumeroMes],
		[Nombre/Empresa]                         as [Nombre/Empresa Total],		
		[Departamento]   as  [Departamento Total],
		[Tipo Actividad Económica]  as 		[Tipo Actividad Económica Total],
	    [CantidadProcesoFiscalizacion]      as [CantidadProcesoFiscalizacion Total], 
		[MontoValorPremiosFiscalizacion]                as    [MontoValorPremiosFiscalizacion Total],
		[MontoValorPremiosFiscalizacionDNF]   as  [MontoValorPremiosFiscalizacionDNF Total],
		[CantidadOrdenesSancionadas]  as [Cantidad Ordenes Sancionadas Total],
	//	[MontoSancionadoFiscalizaciones]  as [Monto Sancionado Fiscalizaciones Total],
		[Departamento Proceso Fiscalización Total]    as [Departamento Proceso Fiscalización Total],
	    [Dirección Proceso Fiscalización Total]    as [Dirección Proceso Fiscalización Total],
		[Nombre Usuario Proceso Fiscalización Total]    as [Nombre Usuario Proceso Fiscalización Total] ,
		[Usuario Proceso Fiscalización Total]    as  [Usuario Proceso Fiscalización Total] ,
		[ProcesoNegocio]    as [Proceso Fiscalización Total] ,
		[TipoProcesoNegocio]    as [Tipo Proceso Fiscalización Total] ,
		[EstadoProcesoNegocio]    as [Estado Proceso Fiscalización Total],
		[CantidadFiscalizacionesDNF] 	as	[CantidadFiscalizacionesDNF]; 
SQL
select gt.GrupoTramite                                                   'Grupo Trámite',
	     gt.TipoTramite                                                     'Tipo Trámite',
	     gt.EstadoTramite                                                  'Estado Trámite',
	     case
		 when em.Oficina ='DIRECCION NACIONAL'  then 'DNAL'
		 when em.Oficina='DIRECCION REGIONAL COCHABAMBA' then 'DRCB'
		 when em.Oficina='DIRECCION REGIONAL SANTA CRUZ'  then 'DRSC'
		 when em.Oficina='DIRECCION REGIONAL LA PAZ'          then 'DRLP'
  	    end 												 'Direccion',
  	    ti.Anio                                             'Año',
	    case   
            when month(convert(datetime, ti.FechaIngles ,103)) = 1 then  'ene'
            when month(convert(datetime, ti.FechaIngles ,103)) = 2 then  'feb'
            when month(convert(datetime, ti.FechaIngles ,103)) = 3 then  'mar'
            when month(convert(datetime, ti.FechaIngles ,103)) = 4 then  'abr'
            when month(convert(datetime, ti.FechaIngles ,103)) = 5 then  'may'
            when month(convert(datetime, ti.FechaIngles,103))  = 6 then  'jun'
            when month(convert(datetime, ti.FechaIngles ,103)) = 7 then  'jul'
            when month(convert(datetime, ti.FechaIngles ,103)) = 8 then  'ago'
            when month(convert(datetime, ti.FechaIngles ,103)) = 9 then  'sep'
            when month(convert(datetime, ti.FechaIngles ,103)) = 10 then 'oct'
            when month(convert(datetime, ti.FechaIngles ,103)) = 11 then 'nov'
            when month(convert(datetime, ti.FechaIngles ,103)) = 12 then 'dic'
            when month(convert(datetime, ti.FechaIngles ,103)) is null then 'NA'
          end 											      'Mes',  
	    ti.FechaIngles   									  'Fecha Ingles', 
	    ti.Dia           									  'Dia',
          ti.NombreSemestre 								      'Semestre',
	    ti.NombreTrimestre 									  'Trimestre',
	    ti.Mes 												  'NumeroMes',
		em.Empresa                                  'Nombre/Empresa',
		em.Departamento                            'Departamento',
		em.[TipoActividadEconomica]                'Tipo Actividad Económica',
		du.Departamento                             'Departamento Proceso Fiscalización Total',
	    du.Direccion						'Dirección Proceso Fiscalización Total',
		du.NombreUsuario                  'Nombre Usuario Proceso Fiscalización Total',
		du.Usuario                         'Usuario Proceso Fiscalización Total',
		ep.ProcesoNegocio               'ProcesoNegocio',
		ep.TipoProcesoNegocio            'TipoProcesoNegocio',
		ep.EstadoProcesoNegocio          'EstadoProcesoNegocio',
		tra.CantidadProcesoFiscalizacion                      'CantidadProcesoFiscalizacion',
		case when CantidadProcesoFiscalizacion >0 then  tra.MontoValorPremiosFiscalizado end           'MontoValorPremiosFiscalizacion' ,
		case when CantidadFiscalizacionesDNF >0 then tra.MontoValorPremiosFiscalizado    end           'MontoValorPremiosFiscalizacionDNF' ,
		tra.CantidadOrdenesSancionadas           'CantidadOrdenesSancionadas',
		tra.CantidadFiscalizacionesDNF 'CantidadFiscalizacionesDNF'
   from [MINAJPRODUCCION].dbo.[Datawarehouse.THProcesosFiscalizaciones] tra,
        [MINAJPRODUCCION].dbo.[Datawarehouse.DimGrupoTipoEstadoTramites]  gt,
		[MINAJPRODUCCION].dbo.[Datawarehouse.DimOficinaDepartamentoEmpresa] em,
	    [MINAJPRODUCCION].dbo.[Datawarehouse.DimTiempo] ti,
		[MINAJPRODUCCION].dbo.[Datawarehouse.DimEstadosProcesos] ep,
		[MINAJPRODUCCION].dbo.[Datawarehouse.DimDireccionDepartamentoUsuarios] du
where tra.DimGrupoTipoEstadoTramiteID          =   gt.DimGrupoTipoEstadoTramiteID
    and ti.DimTiempoID  						 =   tra.DimTiempoID
	and em.DimJurisdiccionEmpresaID       =   tra.DimJurisdiccionEmpresaID
	and du.DimDireccionDepartamentoUsuarioID  = tra.DimDireccionDepartamentoUsuarioID
	and ep.DimEstadoProcesoID                 =  tra.DimProcesoNegocioID;

Ranking:
LOAD
	  [Direccion]      					    as [Dirección]  ,
		  [Año]            					    as [Año],
		/*  [Mes]            					    as [Mes],  
		   [Semestre]       					    as [Semestre],
		  [Trimestre]      				    as [Trimestre],
		  [NumeroMes]                               as [NumeroMes],*/
		[Nombre/Empresa]                         as [Nombre/Empresa Total],		
		[CantidadAutorizado]                      as [CantidadAutorizado  Rank],
		[MontoValorPremiosAutorizado]        as [MontoValorPremioAutorizado  Rank];
SQL 
select   case
		 when em.Oficina ='DIRECCION NACIONAL'  then 'DNAL'
		 when em.Oficina='DIRECCION REGIONAL COCHABAMBA' then 'DRCB'
		 when em.Oficina='DIRECCION REGIONAL SANTA CRUZ'  then 'DRSC'
		 when em.Oficina='DIRECCION REGIONAL LA PAZ'          then 'DRLP'
  	    end 												 'Direccion',
  	    ti.Anio                                             'Año',
	   /* case   
            when month(convert(datetime, ti.FechaIngles ,103)) = 1 then  'ene'
            when month(convert(datetime, ti.FechaIngles ,103)) = 2 then  'feb'
            when month(convert(datetime, ti.FechaIngles ,103)) = 3 then  'mar'
            when month(convert(datetime, ti.FechaIngles ,103)) = 4 then  'abr'
            when month(convert(datetime, ti.FechaIngles ,103)) = 5 then  'may'
            when month(convert(datetime, ti.FechaIngles,103))  = 6 then  'jun'
            when month(convert(datetime, ti.FechaIngles ,103)) = 7 then  'jul'
            when month(convert(datetime, ti.FechaIngles ,103)) = 8 then  'ago'
            when month(convert(datetime, ti.FechaIngles ,103)) = 9 then  'sep'
            when month(convert(datetime, ti.FechaIngles ,103)) = 10 then 'oct'
            when month(convert(datetime, ti.FechaIngles ,103)) = 11 then 'nov'
            when month(convert(datetime, ti.FechaIngles ,103)) = 12 then 'dic'
            when month(convert(datetime, ti.FechaIngles ,103)) is null then 'NA'
          end 											      'Mes',  
	    ti.NombreSemestre 								      'Semestre',
	    ti.NombreTrimestre 									  'Trimestre',
	    ti.Mes 												  'NumeroMes',*/
		em.Empresa                                  'Nombre/Empresa',
	    SUM(tra.CantidadAutorizado)                      'CantidadAutorizado',
		SUM(tra.MontoValorPremiosAutorizado)                'MontoValorPremiosAutorizado'
   from [MINAJPRODUCCION].dbo.[Datawarehouse.THPromociones] tra,
        [MINAJPRODUCCION].dbo.[Datawarehouse.DimGrupoTipoEstadoTramites]  gt,
		[MINAJPRODUCCION].dbo.[Datawarehouse.DimOficinaDepartamentoEmpresa] em,
	    [MINAJPRODUCCION].dbo.[Datawarehouse.DimTiempo] ti
where tra.DimGrupoTipoEstadoTramiteID          =   gt.DimGrupoTipoEstadoTramiteID
    and gt.EstadoTramite                                   =  'ACTIVO'
    and ti.DimTiempoID  						 =   tra.DimTiempoID
	and em.DimJurisdiccionEmpresaID       =   tra.[DimDireccionEmpresaTipoPremioID]
	GROUP BY em.Oficina,ti.Anio ,  em.Empresa   //ti.NombreSemestre ,	ti.NombreTrimestre , ti.Mes ,, ti.FechaIngles                              
	order by SUM(tra.CantidadAutorizado) DESC ,SUM(tra.MontoValorPremiosAutorizado)  DESC  ;
/*
ResumenPagos:
load
[Dirección]   as  [Dirección]  ,
[Mes]    as [Mes],
[Año]   as  [Año],
[TipoPago]   as [TipoPago],
[TipoDocumento]   as  [TipoDocumento],
[Motivo]    as   [Motivo],
[Cantidad Pagos]   as   [Cantidad Pagos Tramites],
[Monto Pago BS]   as [MontoBS PagadoBS Total Tramites],
[Monto Pago UFV]   as  [MontoBS PagadoUFV Total Tramites];
SQL
select  case
		 when Oficina ='DIRECCION NACIONAL'  then 'DNAL'
		 when Oficina='DIRECCION REGIONAL COCHABAMBA' then 'DRCB'
		 when Oficina='DIRECCION REGIONAL SANTA CRUZ'  then 'DRSC'
		 when Oficina='DIRECCION REGIONAL LA PAZ'          then 'DRLP'
  	    end 												 'Dirección',  
       month(FechaPago) 'Mes', 
	   year(FechaPago) 'Año', 
	   TipoPago, 
	   TipoDocumento,
	   Motivo, 
	   count(distinct cite) 'Cantidad Pagos', 
       sum(MontoPagadoBS) 'Monto Pago BS', 
       sum(MontoPagadoUFV) 'Monto Pago UFV'
from [AlmacenCorporativo.PagosSanciones]
group by Oficina, month(FechaPago), year(FechaPago), TipoPago, TipoDocumento,Motivo;

*/
