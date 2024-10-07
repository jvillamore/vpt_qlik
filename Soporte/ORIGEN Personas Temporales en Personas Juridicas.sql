--Se comento la linea de Nombre de la Empresa 
--and pe.NombrePersona = pj.NombreEmpresa - 07-10-2024
select pe.personatemporalid, 
       pj.PersonaID		  
   from [SIAJPRODUCCION].dbo.[Personas.PersonasTemporales]    pe,
 	   [SIAJPRODUCCION].dbo.[Transversales.Dominios]       ec,
 	   [SIAJPRODUCCION].dbo.[Transversales.Dominios]       es,
	   [SIAJPRODUCCION].dbo.[Transversales.Dominios]       td,
	   [SIAJPRODUCCION].dbo.[Organizacion.Oficinas]          do1,	   
	   [SIAJPRODUCCION].dbo.[Transversales.Dominios]       sp,
                      [SIAJPRODUCCION].dbo.[Personas.PersonasJuridicas]  pj,
	   [SIAJPRODUCCION].dbo.[Personas.Personas] per,
	   [SIAJPRODUCCION].dbo.[Personas.DatosPersonas] dp,
	   [SIAJPRODUCCION].dbo.                      [Transversales.TiposActividadesEconomicas]    ta,
	   [SIAJPRODUCCION].dbo.[Transversales.Dominios]     dr
 where ec.dominio    =  'TipoPersonaID'
   and per.EstadoID=1000
   and dp.PersonaID=pj.PersonaID
   and pe.TipoDocumentoID= td.DominioID
   and ec.dominioid  =  pe.TipoPersonaID
   and do1.oficinaid =  pe.oficinaid
   and es.dominioid  =  pe.estadoid
   --and pe.NombrePersona = pj.NombreEmpresa
   and per.personaid=pj.personaid
   and sp.DominioID  = pj.TipoJuridicoID
   and ta.TipoActividadEconomicaID  =  pj.TipoActividadEconomicaID
   and dr.DominioID  =  per.DepartamentoFiscalID
order by pj.PersonaID