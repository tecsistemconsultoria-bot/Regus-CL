#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TOTVS.CH"
#INCLUDE "FILEIO.CH"
#DEFINE CRLF Chr(13)+Chr(10)

/*
+------------+----------+--------+------------------------------+-------+------------------+
| PROGRAMA:  | RELCNTREC | Autor: | Matheus Lemos (Câmara Leal) | Data: | 04/11/2022       |
+------------+-----------------------------------------------------------------------------+
| DESCRIÇÃO: | Relatório de contas a receber para utilização no portal de boletos da regus |
+------------+-----------------------------------------------------------------------------+
| USO:       | REGUS                                                                       |
+------------------------------------------------------------------------------------------+
| Módulo:    | Faturamento                                                                 |
+------------------------------------------------------------------------------------------+
*/

User Function RELCNTREC()

	Local cPerg := Padr("RELCNTREC",10)

	cMontaTxt       := ""

	//Incluo/Altero as perguntas na tabela SX1
	AjustaSX1(cPerg)
	If Pergunte(cPerg,.T.)
		Processa({||MntQry() },,"Processando...")
	Endif

Return

/*=================================================================
Autor: Matheus Lemos Vieira dos Santos (Câmara Leal)
Data: 04/11/2022
Info: Inclui as perguntas na SX1
*==================================================================*/
Static Function AjustaSX1(cPerg)

	Local aRegs := {}
	Local I, J

	//Adiciono um novo elemento no final do array
	aAdd(aRegs,{cPerg,"02","Id Titan?" ,"","","mv_ch1","C",20,00,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg,"03","Data de Emissão De?"  ,"","","mv_ch2","D",20,00,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg,"04","Data de Emissão Até?" ,"","","mv_ch3","D",20,00,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","",""})

	DbSelectArea("SX1")
	SX1->(DbSetOrder(1))

	For I := 1 To Len(aRegs)
		If !DbSeek(cPerg + aRegs[ I, 2 ])
			RecLock("SX1",.T.)
			For J := 1 To FCount()
				If J <= Len(aRegs[ I ])
					FieldPut(J, aRegs[ I, J ])
				Endif
			Next
			SX1->(MsUnlock())
		Endif
	Next

Return

/*=================================================================
Autor: Matheus Lemos Vieira dos Santos (Câmara Leal)
Data: 04/11/2022
Info: Realiza a montagem da consulta para o relatório
*==================================================================*/
Static Function MntQry()

	Local cQuery := ""
	Local aRegs   := {}
	Local nEmpresa

	cQuery += "SELECT"
	cQuery += " SZ1.Z1_XCENTRO,"
	cQuery += " SE1.E1_PREFIXO,"
	cQuery += " SE1.E1_XINVTIT,"
	cQuery += " SE1.E1_XTITAN,"
	cQuery += " SE1.E1_VENCREA,"
	cQuery += " SE1.E1_SALDO"
	cQuery += " FROM " + RetSqlName("SE1") + " SE1"
	cQuery += " INNER JOIN " + RetSqlName("SZ1") + " SZ1 ON (SZ1.Z1_XFILSIG = SE1.E1_FILIAL AND SZ1.D_E_L_E_T_ <> '*')"
	cQuery += " WHERE"
	cQuery += " SE1.D_E_L_E_T_ = ''"
	cQuery += " AND SE1.E1_XTITAN != ''"
	cQuery += " AND SE1.E1_XTITAN != '0'"
	cQuery += " AND SE1.E1_XTITAN LIKE '%[0123456789]%'"
	cQuery += IIf(RetSqlName("SE1") == "SE1010",  " AND SE1.E1_PREFIXO IN ('WTC','BAR','MOU','FAL','PTA','ETW','MOR','BRA','FIN','CON','VIT','ADU','CAN','SMP','NSA','NFO','FOR','VIC','TOP','ARG','ELD','NCE','PCD','CJP','SFL','CCD','MIL','REN','PLA','VIS','VEN','VLM','AJP','JKI','PTC','NUT','MAN','PDA','RB1','PAS','BDV','PAP','PCO','VGS','SPC','EZT','PFL','LAC','TRZ','MAG','RSL','TLP','DSB','FLC','NS5','JK1','GUA','SCN','SBI','RPS','EBU','VWC','SIP','GFT','UBE','RXV','SXI','SCC','TFG','MTC','CSA','ANC','ARC','AME','ANA','FLO','TRO','AYR','ALM','CAS','SOC','GCH','SPP','JDO','LIB','SJT','CEA','AMH','LED','WPC','SPI','NLI','EZ2','S15','HVI','PIN','MAR','COT','TAQ','LAP','MA7')", "")
	cQuery += " AND SE1.E1_XINVTIT != ''"
	cQuery += " AND SE1.E1_XINVTIT LIKE '%[^A-Z]%'"
	cQuery += " AND SE1.E1_SALDO > 0"
	cQuery += " AND SE1.E1_TIPO = 'NF'"
	cQuery += Iif(AllTrim(mv_par01)!="", " AND SE1.E1_XTITAN = '"+mv_par01+"'", "")
	cQuery += Iif(cValToChar(mv_par02)!="".AND.cValToChar(mv_par03)!="", " AND SE1.E1_EMISSAO BETWEEN '"+ DTOS(mv_par02) +"' AND '"+ DTOS(mv_par03) +"'", "")
	cQuery += ";"

	If Select("QRY") <> 0
		DbSelectArea("QRY")
		DbCloseArea()
	EndIf

	cQuery := ChangeQuery(cQuery)
	dbUseArea(.T., "TOPCONN", TCGENQRY(,,cQuery), 'QRY', .F., .T.)

	DbSelectArea("QRY")
	QRY->(DbGoTop())

	If RetSqlName("SE1") == "SE1010"
		nEmpresa := 1
	ElseIf RetSqlName("SE1") == "SE1020"
		nEmpresa := 2
		ElseIf RetSqlName("SE1") == "SE1080"
		nEmpresa := 8	
	EndIf

	While !QRY->(EOF())		
		aAdd(aRegs,{CValToChar(QRY->Z1_XCENTRO), QRY->E1_PREFIXO,AllTrim(QRY->E1_XINVTIT),AllTrim(QRY->E1_XTITAN),;
		cValToChar(STOD(QRY->E1_VENCREA)),AllTrim(STRTRAN(Str(QRY->E1_SALDO, 10, 2),".",","))})
		QRY->(DbSkip())
	EndDo

	If Len(aRegs) > 0
		MntRel(aRegs, nEmpresa)
	Else
		MsgAlert("Não foram encontrados dados para processamento com os parâmetros informados!","Atenção")
	Endif

	QRY->(dbCloseArea())

Return

/*=================================================================
Autor: Matheus Lemos Vieira dos Santos (Câmara Leal)
Data: 04/11/2022
Info: Monta o relatório
*==================================================================*/
Static Function MntRel(aRegs, nEmpresa)

	Local nX

	cMontaTxt += "Centro;Prefixo;Invoice Titan;ID Titan;Vencimento Real;saldo;" + CRLF

	for nX := 1 to Len(aRegs)
		cMontaTxt += CValToChar(aRegs[nX,1]) + ";"
		cMontaTxt += cValToChar(aRegs[nX,2]) + ";"
		cMontaTxt += aRegs[nX,3] + ";"
		cMontaTxt += aRegs[nX,4] + ";"
		cMontaTxt += aRegs[nX,5] + ";"
		cMontaTxt += aRegs[nX,6] + ";"
		cMontaTxt += CRLF
	next nX

	criaCSV(nEmpresa)

return

/*=================================================================
Autor: Matheus Lemos Vieira dos Santos (Câmara Leal)
Data: 04/11/2022
Info: Cria o arquivo do relatório e salva no diretório escolhido pelo usuário
*==================================================================*/
Static Function criaCSV(nEmpresa)

	Local cPath := cGetFile('Selecione uma Pasta (*.*)|*.*', "Arquivos",0,, .F.,nOR( GETF_LOCALHARD, GETF_LOCALFLOPPY, GETF_RETDIRECTORY ), .F., .T.)
	cPath += dtos(date())+'_'+SubStr(Time(),1,2)+"-"+SubStr(Time(),4,2)+"-"+SubStr(Time(),7,2)

	if nEmpresa == 1
		cPath            += "_regus.csv"
	elseif nEmpresa == 2
		cPath            += "_hq.csv"
	elseif nEmpresa == 8
		cPath            += "_iwg.csv"	
	endif

	MemoWrite(cPath, cMontaTxt)

	If File(cPath)
		MsgInfo("O arquivo foi gerado no diretório: "+ cPath +".")
	
	Else
		MsgAlert("Erro ao criar arquivo no diretório " + cPath +".")
	EndIf
return

/*=================================================================
Autor: Matheus Lemos Vieira dos Santos (Câmara Leal)
Data: 04/11/2022
Info: Realiza o "de para" da empresa 1 (REGUS) de acordo com a filial
*==================================================================*/
// Static Function emp01IdTitan(nFilial)

// 	Local cCentroTitan
// 		Do Case
// 		Case nFilial == "01"
// 			cCentroTitan := "041"
// 		Case nFilial == "02"
// 			cCentroTitan := "587"
// 		Case nFilial == "03"
// 			cCentroTitan := "230"
// 		Case nFilial == "04"
// 			cCentroTitan := "295"
// 		Case nFilial == "05"
// 			cCentroTitan := "323"
// 		Case nFilial == "06"
// 			cCentroTitan := "736"
// 		Case nFilial == "07"
// 			cCentroTitan := "1351"
// 		Case nFilial == "08"
// 			cCentroTitan := "1421"
// 		Case nFilial == "09"
// 			cCentroTitan := "1500"
// 		Case nFilial == "10"
// 			cCentroTitan := "1521"
// 		Case nFilial == "11"
// 			cCentroTitan := "9223"
// 		Case nFilial == "12"
// 			cCentroTitan := "1802"
// 		Case nFilial == "13"
// 			cCentroTitan := "1822"
// 		Case nFilial == "14"
// 			cCentroTitan := "1837"
// 		Case nFilial == "15"
// 			cCentroTitan := "1824"
// 		Case nFilial == "16"
// 			cCentroTitan := "1874"
// 		Case nFilial == "17"
// 			cCentroTitan := "1884"
// 		Case nFilial == "19"
// 			cCentroTitan := "1875"
// 		Case nFilial == "20"
// 			cCentroTitan := "2025"
// 		Case nFilial == "21"
// 			cCentroTitan := "2098"
// 		Case nFilial == "22"
// 			cCentroTitan := "2190"
// 		Case nFilial == "23"
// 			cCentroTitan := "2211"
// 		Case nFilial == "24"
// 			cCentroTitan := "2189"
// 		Case nFilial == "25"
// 			cCentroTitan := "2042"
// 		Case nFilial == "26"
// 			cCentroTitan := "2225"
// 		Case nFilial == "27"
// 			cCentroTitan := "2224"
// 		Case nFilial == "28"
// 			cCentroTitan := "2446"
// 		Case nFilial == "29"
// 			cCentroTitan := "2303"
// 		Case nFilial == "30"
// 			cCentroTitan := "2587"
// 		Case nFilial == "31"
// 			cCentroTitan := "2550"
// 		Case nFilial == "32"
// 			cCentroTitan := "2572"
// 		Case nFilial == "33"
// 			cCentroTitan := "4423"
// 		Case nFilial == "34"
// 			cCentroTitan := "4424"
// 		Case nFilial == "35"
// 			cCentroTitan := "4425"
// 		Case nFilial == "36"
// 			cCentroTitan := "4426"
// 		Case nFilial == "37"
// 			cCentroTitan := "4427"
// 		Case nFilial == "38"
// 			cCentroTitan := "4428"
// 		Case nFilial == "39"
// 			cCentroTitan := "4429"
// 		Case nFilial == "40"
// 			cCentroTitan := "4430"
// 		Case nFilial == "41"
// 			cCentroTitan := "4431"
// 		Case nFilial == "42"
// 			cCentroTitan := "4534"
// 		Case nFilial == "43"
// 			cCentroTitan := "4631"
// 		Case nFilial == "44"
// 			cCentroTitan := "4632"
// 		Case nFilial == "45"
// 			cCentroTitan := "4633"
// 		Case nFilial == "46"
// 			cCentroTitan := "4634"
// 		Case nFilial == "47"
// 			cCentroTitan := "4657"
// 		Case nFilial == "48"
// 			cCentroTitan := "4749"
// 		Case nFilial == "49"
// 			cCentroTitan := "4750"
// 		Case nFilial == "50"
// 			cCentroTitan := "4751"
// 		Case nFilial == "51"
// 			cCentroTitan := "4756"
// 		Case nFilial == "52"
// 			cCentroTitan := "4906"
// 		Case nFilial == "53"
// 			cCentroTitan := "4907"
// 		Case nFilial == "54"
// 			cCentroTitan := "4908"
// 		Case nFilial == "55"
// 			cCentroTitan := "4912"
// 		Case nFilial == "56"
// 			cCentroTitan := "4910"
// 		Case nFilial == "57"
// 			cCentroTitan := "4915"
// 		Case nFilial == "58"
// 			cCentroTitan := "4911"
// 		Case nFilial == "59"
// 			cCentroTitan := "4991"
// 		Case nFilial == "60"
// 			cCentroTitan := "4913"
// 		Case nFilial == "61"
// 			cCentroTitan := "5008"
// 		Case nFilial == "62"
// 			cCentroTitan := "9373"
// 		Case nFilial == "63"
// 			cCentroTitan := "5454"
// 		Case nFilial == "64"
// 			cCentroTitan := "5680"
// 		Case nFilial == "65"
// 			cCentroTitan := "5692"
// 		Case nFilial == "66"
// 			cCentroTitan := "6069"
// 		Case nFilial == "67"
// 			cCentroTitan := "6387"
// 		Case nFilial == "69"
// 			cCentroTitan := "7335"
// 		Case nFilial == "70"
// 			cCentroTitan := "7434"
// 		Case nFilial == "71"
// 			cCentroTitan := "8061"
// 		Case nFilial == "72"
// 			cCentroTitan := "7738"
// 		Case nFilial == "73"
// 			cCentroTitan := "7739"
// 		Case nFilial == "74"
// 			cCentroTitan := "7972"
// 		Case nFilial == "75"
// 			cCentroTitan := "7933"
// 		Case nFilial == "76"
// 			cCentroTitan := "8289"
// 		Case nFilial == "77"
// 			cCentroTitan := "8175"
// 		Case nFilial == "78"
// 			cCentroTitan := "8522"
// 		Case nFilial == "79"
// 			cCentroTitan := "8538"
// 		Case nFilial == "80"
// 			cCentroTitan := "8542"
// 		Case nFilial == "81"
// 			cCentroTitan := "8966"
// 		Case nFilial == "82"
// 			cCentroTitan := "8863"
// 		Case nFilial == "83"
// 			cCentroTitan := "7189"
// 		Case nFilial == "84"
// 			cCentroTitan := "6889"
// 		Case nFilial == "85"
// 			cCentroTitan := "6791"
// 		Case nFilial == "86"
// 			cCentroTitan := "7077"
// 		Case nFilial == "87"
// 			cCentroTitan := "6928"
// 		Case nFilial == "88"
// 			cCentroTitan := "6979"
// 		Case nFilial == "89"
// 			cCentroTitan := "6931"
// 		Case nFilial == "90"
// 			cCentroTitan := "7289"
// 		Case nFilial == "91"
// 			cCentroTitan := "6977"
// 		Case nFilial == "92"
// 			cCentroTitan := "6987"
// 		Case nFilial == "93"
// 			cCentroTitan := "6981"
// 		Case nFilial == "94"
// 			cCentroTitan := "6978"
// 		Case nFilial == "95"
// 			cCentroTitan := "6988"
// 		Case nFilial == "96"
// 			cCentroTitan := "6983"
// 		Case nFilial == "97"
// 			cCentroTitan := "5520"
// 		Case nFilial == "98"
// 			cCentroTitan := "6985"
// 		Case nFilial == "99"
// 			cCentroTitan := "6998"
// 		Case nFilial == "1A"
// 			cCentroTitan := "6989"
// 		Case nFilial == "2A"
// 			cCentroTitan := "5514"
// 		Case nFilial == "3A"
// 			cCentroTitan := "6990"
// 		Case nFilial == "4A"
// 			cCentroTitan := "6991"
// 		Case nFilial == "5A"
// 			cCentroTitan := "5506"
// 		EndCase

// Return cCentroTitan

/*=================================================================
Autor: Matheus Lemos Vieira dos Santos (Câmara Leal)
Data: 04/11/2022
Info: Realiza o "de para" da empresa 2 (HQ) de acordo com a filial
*==================================================================*/
// Static Function emp02IdTitan(nFilial)

// 	Local cCentroTitan

// 	Do Case
// 	Case nFilial == "01"
// 		cCentroTitan := "1585"
// 	Case nFilial == "02"
// 		cCentroTitan := "1591"
// 	Case nFilial == "03"
// 		cCentroTitan := "1589"
// 	Case nFilial == "04"
// 		cCentroTitan := "1593"
// 	Case nFilial == "05"
// 		cCentroTitan := "1594"
// 	Case nFilial == "06"
// 		cCentroTitan := "1584"
// 	Case nFilial == "07"
// 		cCentroTitan := "1581"
// 	Case nFilial == "08"
// 		cCentroTitan := "1582"
// 	Case nFilial == "09"
// 		cCentroTitan := "1587"
// 	Case nFilial == "10"
// 		cCentroTitan := "1579"
// 	Case nFilial == "11"
// 		cCentroTitan := "1590"
// 	Case nFilial == "12"
// 		cCentroTitan := "1586"
// 	Case nFilial == "13"
// 		cCentroTitan := "1583"
// 	Case nFilial == "14"
// 		cCentroTitan := "1580"
// 	Case nFilial == "15"
// 		cCentroTitan := "1588"
// 	Case nFilial == "16"
// 		cCentroTitan := "1592"
// 	EndCase

// Return cCentroTitan
