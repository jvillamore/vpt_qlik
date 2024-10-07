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
   from [Datawarehouse.THSanciones] tra,
        [Datawarehouse.DimGrupoTipoEstadoTramites]  gt,
		[Datawarehouse.DimOficinaDepartamentoEmpresa] em,		
      dbo.[Datawarehouse.DimEstadosProcesos] ep,
	    [Datawarehouse.DimTiempo] ti
where tra.DimGrupoTipoEstadoTramiteID          =   gt.DimGrupoTipoEstadoTramiteID
    and ti.DimTiempoID  						 =   tra.DimTiempoID
	and em.DimJurisdiccionEmpresaID       =   tra.[DimJurisdiccionEmpresaID]
	and ep.[DimEstadoProcesoID]= tra.[DimEstadoProcesoID]
and  month( ti.FechaIngles) =09
and  year( ti.FechaIngles) =2024
and em.Oficina='DIRECCION REGIONAL SANTA CRUZ'
	;