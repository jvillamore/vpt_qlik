/********* Se consideran todos los trámites ACTIVOS o VALIDOS*******************
- Estado Tramite ='ACTIVO'
- 
*******************************************************************************/
/*ResumenTramitesDocumentos:
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
		  [Estado Autorización]                    as [Estado Autorización],
		  [CantidadSolicitudesPromociones]  as [CantidadSolicitudesPromociones] 
 resident ResumenSolicitudesPromociones
	where [Estado Trámite] =  $(vEstadoActivo)
	  and  [Direccion] <>'DNAL';
Concatenate (ResumenTramitesDocumentos)
	 load [Grupo Trámite]               as [Grupo Trámite],
	      [Tipo Trámite]                as [Tipo Trámite],
	      [Estado Trámite]              as [Estado Trámite],
		  [Direccion]                   as [Dirección]  ,
		  [Año]                         as [Año],
		  [Mes]                         as [Mes],  
		  [Fecha Ingles]                as [Fecha Ingles], 
		  [Dia]                         as [Dia],
	      [Semestre]                    as [Semestre],
		  [Trimestre]                   as [Trimestre],
		  [NumeroMes]                   as [NumeroMes],
		   [Usuario]                     as [Usuario],
		  [Tipo Documento]              as [Tipo Documento],
		  [Tipo Documento (Sigla)]      as [Tipo Documento (Sigla)],
		  [Estado Documento]            as [Estado Documento],	
		  [Departamento]                as [Departamento],
		  [CantidadDocumentosGenerados] as [CantidadDocumentosGenerados]
 resident ResumenCites 
    where [Estado Trámite]   =  $(vEstadoActivo)
      and [Estado Documento] =  $(vEstadoActivo)
        and  [Direccion] <>'DNAL';
  Concatenate
   LOAD [Grupo Trámite]  				    as [Grupo Trámite],
	      [Tipo Trámite]   				    as [Tipo Trámite],
	      [Estado Trámite] 				    as [Estado Trámite],
		  [Dirección]      					    as [Dirección]  ,
		  [Año]            					    as [Año],
		  [Mes]            					    as [Mes],  
		  [Fecha Ingles]   				    as [Fecha Ingles], 
		  [Dia]          					    as [Dia],
	      [Semestre]       					    as [Semestre],
		  [Trimestre]      				    as [Trimestre],
		  [NumeroMes]                               as [NumeroMes],
		  [Estado Autorización]                    as [Estado Autorización],
		  [Valor Comercial]                         as [Valor Comercial Total]
resident ResumenValorComercial
	where [Estado Trámite] =  $(vEstadoActivo)
	  and  [Dirección] <>'DNAL';
Concatenate
   LOAD [Grupo Trámite]  				    as [Grupo Trámite],
	      [Tipo Trámite]   				    as [Tipo Trámite],
	      [Estado Trámite] 				    as [Estado Trámite],
		  [Dirección]      					    as [Dirección]  ,
		  [Año]            					    as [Año],
		  [Mes]            					    as [Mes],  
		  [Fecha Ingles]   				    as [Fecha Ingles], 
		  [Dia]          					    as [Dia],
	      [Semestre]       					    as [Semestre],
		  [Trimestre]      				    as [Trimestre],
		  [NumeroMes]                               as [NumeroMes],
		  [Tipo Proceso Sanción]                 as [Tipo Proceso Sanción Total],
		  [CantidadSanciones]                     as [CantidadSanciones]
resident ResumenSanciones
	where [Estado Trámite] =  $(vEstadoActivo)
	  and  [Dirección] <>'DNAL';
Concatenate
   LOAD [Grupo Trámite]  				    as [Grupo Trámite],
	      [Tipo Trámite]   				    as [Tipo Trámite],
	      [Estado Trámite] 				    as [Estado Trámite],
		  [Dirección]      					    as [Dirección]  ,
		  [Año]            					    as [Año],
		  [Mes]            					    as [Mes],  
		  [Fecha Ingles]   				    as [Fecha Ingles], 
		  [Dia]          					    as [Dia],
	      [Semestre]       					    as [Semestre],
		  [Trimestre]      				    as [Trimestre],
		  [NumeroMes]                               as [NumeroMes],
		  [Tipo Proceso Sanción]                 as [Tipo Proceso Sanción Total],
		  [MontoUFV AAPA Total]                     as [Monto UFV AAPA Total]
resident ResumenMontoSancionesAAPA
	where [Estado Trámite] =  $(vEstadoActivo)
	  and  [Dirección] <>'DNAL';
Concatenate
   LOAD [Grupo Trámite]  				    as [Grupo Trámite],
	      [Tipo Trámite]   				    as [Tipo Trámite],
	      [Estado Trámite] 				    as [Estado Trámite],
		  [Dirección]      					    as [Dirección]  ,
		  [Año]            					    as [Año],
		  [Mes]            					    as [Mes],  
		  [Fecha Ingles]   				    as [Fecha Ingles], 
		  [Dia]          					    as [Dia],
	      [Semestre]       					    as [Semestre],
		  [Trimestre]      				    as [Trimestre],
		  [NumeroMes]                               as [NumeroMes],
		  [Tipo Proceso Sanción]                 as [Tipo Proceso Sanción Total],
		  [MontoUFV RS Total]      as [MontoUFV RS Total]
resident ResumenMontoSancionesRS
	where [Estado Trámite] =  $(vEstadoActivo)
	  and  [Dirección] <>'DNAL';	
Concatenate
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
		   [Estado Autorización]                    as [Estado Autorización],
		  [CantidadSolicitudesAsociados]      as [CantidadSolicitudesAsociados]
 resident ResumenAsociadosPromociones
	where [Estado Trámite] =  $(vEstadoActivo)
	  and  [Direccion] <>'DNAL';
Concatenate
   LOAD [Grupo Trámite]  				    as [Grupo Trámite],
	       [Tipo Trámite]   				    as [Tipo Trámite],
	       [Estado Trámite] 				    as [Estado Trámite],
		 [Dirección]      					    as [Dirección],
		 [Año]            					    as [Año],
		 [Mes]            					    as [Mes],  
		 [Fecha Ingles]   				    as [Fecha Ingles], 
		 [Dia]          					    as [Dia],
	       [Semestre]       				    as [Semestre],
		 [Trimestre]      				          as [Trimestre],
		 [NumeroMes]                               as [NumeroMes],
		 [Tipo Documento Pagado]             as [Tipo Documento Pagado Total],
		 [Cantidad Pagos]                          as  [Cantidad Pagos], 
		 [MontoBS Pagado]                        as [Total MontoBS Pagado],
		 [MontoUFV Pagado]                      as [Total MontoUFV Pagado] 
resident ResumenPagosSanciones
	where [Estado Trámite] =  $(vEstadoActivo)
	  and  [Dirección] <>'DNAL';
*/


