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
			then (
		select
			count(*)
		from
			vpt.ViewSolicitAutoriz
		where
			year([FechaComodin VPT])= Gestion
				and month([FechaComodin VPT])<= NumeroMes)
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
			year(Periodo)= Gestion
				and month(Periodo)<= NumeroMes
					and upper(FormaResolucion) like '%CONFIRM%')
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
			then (
		select
			count(*)
		from
			vpt.ViewSolicitAutoriz
		where
			year([FechaComodin VPT])= Gestion
				and month([FechaComodin VPT])<= NumeroMes)
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
	[ODS.VPTIndicadoresGestion]
where
	Gestion = 2024
	and mes = 'sep';