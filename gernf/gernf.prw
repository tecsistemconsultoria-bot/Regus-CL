#INCLUDE "rwmake.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNOVO3     บ Autor ณ AP6 IDE            บ Data ณ  18/04/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Codigo gerado pelo AP6 IDE.                                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

User Function GERNF
	
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Declaracao de Variaveis                                             ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	Private oGeraTxt
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Montagem da tela de processamento.                                  ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	@ 200,1 TO 380,380 DIALOG oGeraTxt TITLE OemToAnsi("Gerao de Arquivo Texto")
	@ 02,10 TO 080,190
	@ 10,018 Say " Este programa ira gerar um arquivo texto, conforme os parame- "
	@ 18,018 Say " tros definidos  pelo usuario,  com os registros do arquivo de "
	@ 26,018 Say "                                                            "
	
	@ 70,128 BMPBUTTON TYPE 01 ACTION OkGeraTxt()
	@ 70,158 BMPBUTTON TYPE 02 ACTION Close(oGeraTxt)
	
	Activate Dialog oGeraTxt Centered
	
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณ OKGERATXTบ Autor ณ AP5 IDE            บ Data ณ  18/04/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao chamada pelo botao OK na tela inicial de processamenบฑฑ
ฑฑบ          ณ to. Executa a geracao do arquivo texto.                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function OkGeraTxt
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Cria o arquivo texto                                                ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	Private cArqTxt := "C:\Exportacao\NF.TXT"
	Private nHdl    := fCreate(cArqTxt)
	
	Private cEOL    := "CHR(13)+CHR(10)"
	If Empty(cEOL)
		cEOL := CHR(13)+CHR(10)
	Else
		cEOL := Trim(cEOL)
		cEOL := &cEOL
	Endif
	
	If nHdl == -1
		MsgAlert("O arquivo de nome "+cArqTxt+" nao pode ser executado! Verifique os parametros.","Atencao!")
		Return
	Endif
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Inicializa a regua de processamento                                 ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	Processa({|| RunCont() },"Processando...")
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณ RUNCONT  บ Autor ณ AP5 IDE            บ Data ณ  18/04/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  บฑฑ
ฑฑบ          ณ monta a janela com a regua de processamento.               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function RunCont
	
	Local nTamLin, cLin, cCpo
	Local cPerg		:=	"GERRB1"
	Local nItem		:=	1
	Local nErro     :=  0
	Local nPvIni	:=	""
	Local nPvFim	:=	""
	Local cFil		:=	""
	Local cSelect	:=	""
	Local cSel		:=	""
	Local cUpdate	:= ""
	Local cAlias	:= "cUpd"
	Local cSQL      := ""
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Posicionamento do primeiro registro e loop principal. Pode-se criar ณ
	//ณ a logica da seguinte maneira: Posiciona-se na filial corrente e pro ณ
	//ณ cessa enquanto a filial do registro for a filial corrente. Por exem ณ
	//ณ plo, substitua o dbGoTop() e o While !EOF() abaixo pela sintaxe:    ณ
	//ณ                                                                     ณ
	//ณ dbSeek(xFilial())                                                   ณ
	//ณ While !EOF() .And. xFilial() == A1_FILIAL                           ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	Pergunte(cPerg,.T.)
	
	//Tratativa para substituir o Update - Vinicius N. de Oliveira - 14/05/2021
	cUpdate += " SELECT DISTINCT C5.R_E_C_N_O_ AS RECNO"
	cUpdate += " FROM " + RetSqlName("SC5") +  " C5"
	cUpdate += " INNER JOIN " + RetSqlName("SD2") + " D2" 
	cUpdate += " 	ON D2_FILIAL = C5_FILIAL"
	cUpdate += " 	AND D2_DOC = C5_NOTA" 
	cUpdate += " 	AND D2_SERIE = C5_SERIE"
	cUpdate += " 	AND D2_CLIENTE = C5_CLIENTE"
	cUpdate += " 	AND D2_LOJA = C5_LOJACLI"
	cUpdate += " 	AND D2.D_E_L_E_T_ = ' '"
	cUpdate += " INNER JOIN SF3010 F3" 
	cUpdate += " 	ON F3_FILIAL = D2_FILIAL"
	cUpdate += " 	AND F3_NFISCAL = D2_DOC"
	cUpdate += " 	AND F3_SERIE = D2_SERIE"
	cUpdate += " 	AND F3_CLIEFOR = D2_CLIENTE"
	cUpdate += " 	AND F3_LOJA = D2_LOJA"
	cUpdate += " 	AND F3_CODISS = D2_CODISS"
	cUpdate += " 	AND F3.D_E_L_E_T_ = ' '"
	cUpdate += "    AND F3_SERIE = D2_SERIE"
	cUpdate += " WHERE D2_FILIAL BETWEEN '"+mv_par05+"' AND '"+mv_par06+"'"
	cUpdate += "   AND D2_EMISSAO BETWEEN '"+Dtos(mv_par01)+"' AND '"+Dtos(mv_par02)+"'"	
	cUpdate += "   AND D2_SERIE IN ('RPS', '1  ', '8', '13')"
	cUpdate += "   AND D2_XTITAN BETWEEN '"+mv_par07+"' AND '"+mv_par08+"'"
	cUpdate += "   AND F3_NFELETR <> ' '"
	cUpdate += "   AND D2_FILIAL NOT IN ('08','12','15','19','16')"
	cUpdate += "   AND C5.D_E_L_E_T_ = ' '"

	cUpdate := ChangeQuery(cUpdate)
	dbUseArea( .T., "TopConn", TCGenQry(,,cUpdate), cAlias, .F., .F. )

	DbSelectArea(cAlias)
	(cAlias)->(DbGoTop())

	While (cAlias)->(!EOF())
		
		cUpdate := ""
		cUpdate := "UPDATE "+RetSqlName("SC5")+" SET C5_XDTNF = '"+DToS(dDataBase)+"'"
		cUpdate += " WHERE R_E_C_N_O_ = "+cValToChar((cAlias)->RECNO)
		
		nErro := TcSqlExec(cUpdate)	
	
		If nErro == 0	
			cUpdate := "COMMIT"		
			TcSqlExec(cUpdate)	
		Else
			FwLogMsg("INFO", ,"" , ,"" ,"" ,"GERNF - Erro Update: "+TCSQLError())		
		Endif 
		
		(cAlias)->(DbSkip())
		
	EndDo
	// ---	
	
	// Mudan็a:
	/*
	cSQL := " SELECT * FROM " + RetSqlName("SD2") + " D2"
	cSQL += " INNER JOIN " + RetSqlName("SF3") + " F3" 
	cSQL += " 	 ON F3_FILIAL = D2_FILIAL" 
	cSQL += " 	 AND F3_NFISCAL = D2_DOC" 
	cSQL += " 	 AND F3_SERIE = D2_SERIE"
	cSQL += "    AND F3_CLIEFOR = D2_CLIENTE" 
	cSQL += "    AND F3_LOJA = D2_LOJA" 
	cSQL += "    AND F3_CODISS = D2_CODISS"
	cSQL += "    AND F3.D_E_L_E_T_ = ''"
	cSQL += " INNER JOIN " + RetSqlName("SZ1") + " Z1" 
	cSQL += "	 ON Z1_XFILSIG = D2_FILIAL"
	cSQL += "    AND Z1.D_E_L_E_T_ = ''"
	cSQL += " WHERE D2_FILIAL BETWEEN '"+mv_par05+"' AND '"+mv_par06+"'"
	cSQL += "    AND D2_SERIE IN ('RPS', '1  ', '8', '13')" 
	cSQL += "    AND D2_EMISSAO BETWEEN '"+Dtos(mv_par01)+"' AND '"+Dtos(mv_par02)+"'"
	cSQL += "    AND D2_XINVTIT BETWEEN '" + MV_PAR03 + "' AND '"+MV_PAR04+"' "
	cSQL += "    AND D2_XTITAN BETWEEN '"+mv_par07+"' AND '"+mv_par08+"'"		
	cSQL += "    AND F3_NFELETR <> ''"
	cSQL += "    AND Z1_XTIPO LIKE 'E'" 
	cSQL += "    AND D2.D_E_L_E_T_ = ''"
	cSQL += " ORDER BY D2_FILIAL,D2_DOC"*/

	cSQL += " SELECT"
	cSQL += "     D2.*,"
	cSQL += "     F3.F3_ALIQICM,"
	cSQL += "     Z1.*"
	cSQL += " FROM "+RetSQLName("SD2")+" D2"
	cSQL += " INNER JOIN ("
	cSQL += "     SELECT" 
	cSQL += "         F3_FILIAL,"
	cSQL += "         F3_NFISCAL,"
	cSQL += "         F3_SERIE,"
	cSQL += "         F3_CLIEFOR,"
	cSQL += "         F3_LOJA,"
	cSQL += "         F3_CODISS,"
	cSQL += "         MIN(F3_ALIQICM) AS F3_ALIQICM"
	cSQL += "     FROM "+RetSQLName("SF3")
	cSQL += "     WHERE D_E_L_E_T_ = ''"
	cSQL += "     GROUP BY" 
	cSQL += "         F3_FILIAL,"
	cSQL += "         F3_NFISCAL,"
	cSQL += "         F3_SERIE,"
	cSQL += "         F3_CLIEFOR,"
	cSQL += "         F3_LOJA,"
	cSQL += "         F3_CODISS"
	cSQL += " ) F3"
	cSQL += "     ON F3.F3_FILIAL = D2_FILIAL"
	cSQL += "     AND F3.F3_NFISCAL = D2_DOC"
	cSQL += "     AND F3.F3_SERIE = D2_SERIE"
	cSQL += "     AND F3.F3_CLIEFOR = D2_CLIENTE"
	cSQL += "     AND F3.F3_LOJA = D2_LOJA"
	cSQL += "     AND F3.F3_CODISS = D2_CODISS"
	cSQL += " INNER JOIN "+RetSQLName("SZ1")+" Z1"
	cSQL += "     ON Z1_XFILSIG = D2_FILIAL"
	cSQL += "     AND Z1.D_E_L_E_T_ = ''"
	cSQL += " WHERE D2_FILIAL BETWEEN '"+mv_par05+"' AND '"+mv_par06+"'"
	cSQL += "     AND D2_SERIE IN ('RPS', '1  ', '8', '13')"
	cSQL += "     AND D2_EMISSAO BETWEEN '"+Dtos(mv_par01)+"' AND '"+Dtos(mv_par02)+"'"
	cSQL += "     AND D2_XINVTIT BETWEEN '" + MV_PAR03 + "' AND '"+MV_PAR04+"' "
	cSQL += "     AND D2_XTITAN BETWEEN '"+mv_par07+"' AND '"+mv_par08+"'"
	cSQL += "     AND Z1_XTIPO LIKE 'E'"
	cSQL += "     AND D2.D_E_L_E_T_ = ''"
	cSQL += " ORDER BY D2_FILIAL, D2_DOC"
	
	//cSQL := ChangeQuery(cSQL)
	
	dbUseArea( .T., "TopConn", TCGenQry(,,cSQL), "cQuery", .F., .F. )
	
	dbSelectArea("cQuery")
	dbGoTop()
	
	ProcRegua(RecCount()) // Numero de registros a processar
	
	nPvIni	:=	cQuery->D2_DOC
	
	While cQuery->(!EOF())
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Incrementa a regua                                                  ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		
		IncProc()
		
		
		//ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
		//บ Lay-Out do arquivo Texto gerado:                                บ
		//ฬออออออออออออออออัออออออออัอออออออออออออออออออออออออออออออออออออออน
		//บCampo           ณ Inicio ณ Tamanho                               บ
		//วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
		//บ ??_FILIAL     ณ 01     ณ 02                                    บ
		//ศออออออออออออออออฯออออออออฯอออออออออออออออออออออออออออออออออออออออผ
		
		nTamLin := 2
		cLin    := Space(nTamLin)+cEOL // Variavel para criacao da linha do registros para gravacao
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Substitui nas respectivas posicioes na variavel cLin pelo conteudo  ณ
		//ณ dos campos segundo o Lay-Out. Utiliza a funcao STUFF insere uma     ณ
		//ณ string dentro de outra string.                                      ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		
		//cCpo := PADR(->??_FILIAL,02)
		//cLin := Stuff(cLin,01,02,cCpo)
		aQuery := " SELECT * FROM " + RetSqlName("SZ1")
		aQuery += " WHERE Z1_XFILSIG = '" + cQuery->D2_FILIAL + "' AND D_E_L_E_T_ <> '*'"
		dbUseArea( .T., "TopConn", TCGenQry(,,aQuery), "aQuery", .F., .F. )
		dbSelectArea("aQuery")
		dbGoTop()
		
		cFil	:= ALLTRIM(aQuery->Z1_XCENTRO)
		
		DbSelectArea("aQuery")
		DbCloseArea()
		
		
		cLin	:=	cFil // Filial
		cLin	+=	'|'
		cLin	+=	ALLTRIM(POSICIONE('SC5',1,cQuery->D2_FILIAL+cQuery->D2_PEDIDO, 'C5_XINVTIT')) //Invoice Titan
		cLin	+=	'|'
		cLin	+=	'NF' // Tipo do Arquivo
		cLin	+=	'|'
		cLin	+=	ALLTRIM(POSICIONE('SA1',1,cQuery->D2_FILIAL+cQuery->D2_CLIENTE+cQuery->D2_LOJA, 'A1_XTITAN'))  // Cod Titan
		cLin	+=	'|'
		cLin	+=	ALLTRIM(POSICIONE('SA1',1,cQuery->D2_FILIAL+cQuery->D2_CLIENTE+cQuery->D2_LOJA, 'A1_NOME'))  //Nome Cliente
		cLin	+=	'|'
		cLin	+=	ALLTRIM(POSICIONE('SA1',1,cQuery->D2_FILIAL+cQuery->D2_CLIENTE+cQuery->D2_LOJA, 'A1_END'))   //Endere็o Cli
		cLin	+=	'|'
		_cCep := POSICIONE('SA1',1,cQuery->D2_FILIAL+cQuery->D2_CLIENTE+cQuery->D2_LOJA, 'A1_CEP')
		IF aLLTRIM(_cCep) > " "
			cLin	+=	TRANSFORM(_cCep,"@r 99999-999")  //CEP CLiente
		EndIf
		cLin	+=	'|'
		_cMun := POSICIONE('SA1',1,cQuery->D2_FILIAL+cQuery->D2_CLIENTE+cQuery->D2_LOJA, 'A1_MUN') //Cidade
		cLin	+=	ALLTRIM(SUBSTR(_cMun,1,15))
		cLin	+=	'|'
		cLin	+=	POSICIONE('SA1',1,cQuery->D2_FILIAL+cQuery->D2_CLIENTE+cQuery->D2_LOJA, 'A1_EST')       //Estado
		cLin	+=	'|'
		_cBai	:=  POSICIONE('SA1',1,cQuery->D2_FILIAL+cQuery->D2_CLIENTE+cQuery->D2_LOJA, 'A1_BAIRRO') //Bairro
		cLin	+=	ALLTRIM(Substr(_cBai,1,15))
		cLin	+=	'|'
		
		_cCnpj	:= POSICIONE('SA1',1,cQuery->D2_FILIAL+cQuery->D2_CLIENTE+cQuery->D2_LOJA, 'A1_CGC')
		IF Alltrim(_cCnpj) > " "
			IF Len(alltrim(_cCnpj)) == 14
				cLin	+=	TRANSFORM(_cCnpj,"@r 99.999.999/9999-99")
			Else                                                                                                //CNPJ Cliente
				cLin	+=	TRANSFORM(_cCnpj,"@r 999.999.999-99")
			EndIf
		ENDIF
		cLin	+=	'|'
		IF nPvIni == nPvFim
			nItem++
			cLin	+=	Alltrim(Str(nItem))
		Else                                                       // Numeros dos Itens
			cLin	+=	'1'
			nItem 	:= 1
		EndIF
		
		cLin	+=	'|'
		cLin	+=	ALLTRIM(POSICIONE('SB1',1,xFilial("SB1")+cQuery->D2_COD, 'B1_DESC'))   //Descri็ใo do Produto
		cLin	+=	'|'
		cLin	+=	cQuery->D2_EMISSAO  // Emissao Nota Fiscal
		cLin	+=	'|'
		cLin	+=	DTOS(POSICIONE('SC5',1,cQuery->D2_FILIAL+cQuery->D2_PEDIDO, 'C5_DATA1'))   //Data de Vencto
		cLin	+=	'|'
		cLin	+=	'' 		//Quantidade
		cLin	+=	'|'
		cLin	+=  '00000000000000'    //Valor Unitario
		cLin	+=	'|'
		
		cSelect := " SELECT C6_VALOR FROM " + RetSqlName("SC6") + " C6 "
		cSelect += " WHERE C6_FILIAL = '" + cQuery->D2_FILIAL + "' AND C6_PRODUTO = '" + cQuery->D2_COD + "' AND C6_ITEM = '" + cQuery->D2_ITEMPV + "' "
		cSelect += " AND C6_NUM = '" + cQuery->D2_PEDIDO +  "' AND C6.D_E_L_E_T_ = '' "
		cSelect := ChangeQuery(cSelect)
		dbUseArea( .T., "TopConn", TCGenQry(,,cSelect), "cSelect", .F., .F. )
		
		DbSelectArea("cSelect")
		DbGotop()
		_nPrcTot   := cSelect->C6_VALOR
		
		//_nPrcTot  := POSICIONE('SC6',1,cQuery->D2_FILIAL+cQuery->D2_COD+cQuery->D2_PEDIDO+cQuery->D2_ITEM, 'C6_VALOR')
		_nPrcTot  := STRZERO(_nPrcTot,15,2)
		_cPar3 := _nPrcTot
		_cTro3 := At('.',_cPar3)
		If _cTro3 <> 0
			_nPrcTot := Stuff(_cPar3,_cTro3,1,"")
		EndiF
		
		cLin	+=	_nPrcTot          // Valor Total
		cLin	+=	'|'
		cLin	+=	''	// Codigo de Boleto
		cLin	+=	'|'
		
		cSel := " SELECT F2_FILIAL, F2_HORA,F2_NFELETR, F2_CODNFE FROM " + RetSqlName("SF2") + " F2 "
		cSel += " WHERE F2_FILIAL = '" + cQuery->D2_FILIAL + "' AND F2_DOC = '" + cQuery->D2_DOC + "' AND F2_SERIE = '" + cQuery->D2_SERIE + "' "
		cSel += " AND F2.D_E_L_E_T_ = '' "
		cSel := ChangeQuery(cSel)
		dbUseArea( .T., "TopConn", TCGenQry(,,cSel), "cSel", .F., .F. )
		
		DbSelectArea("cSel")
		DbGotop()
		
		cCodIss := Posicione("SX5",1,cQuery->D2_FILIAL+"Z1","X5_DESCRI")
		
		cLin	+=	cSel->F2_HORA    // Hora de Envio
		cLin	+=	'|'
		cLin +=	Alltrim(cSel->F2_CODNFE) 
		cLin	+=	'|'
		cLin	+=	Alltrim(cCodIss)   //Codigo de ISS
		cLin	+=	'|'
		cLin	+=	'00000000000000' 		//Valor de Dedu็๕es
		cLin	+=	'|'
		cLin	+=	'00000000000000'		//Valor de Desc Incondicional
		cLin	+=	'|'
		cLin	+=	_nPrcTot	// Base de Calculo
		cLin	+=	'|'
		_nPrcT := Strzero(cQuery->D2_ALIQISS,15,2)
		
		_cPar3 := _nPrcT
		_cTro3 := At('.',_cPar3)
		If _cTro3 <> 0
			_nPrcT := Stuff(_cPar3,_cTro3,1,"")
		EndiF
		
		cLin	+=  _nPrcT		// Aliquota do ISS
		cLin	+=	'|'
		
		_ValIss := Strzero(cQuery->D2_VALISS,15,2)
		
		_cPar3 := _ValIss
		_cTro3 := At('.',_cPar3)
		If _cTro3 <> 0
			_ValIss := Stuff(_cPar3,_cTro3,1,"")
		EndiF
		
		cLin	+=	_ValIss   // Valor do ISS
		cLin	+=	'|'
		cLin	+=	''   //Outras Infoma็๕es
		cLin	+=	'|'
		cLin	+=	''   //Inscri็ใo municipal
		cLin	+=	'|'
		cLin	+=	ALLTRIM(POSICIONE('SA1',1,cQuery->D2_FILIAL+cQuery->D2_CLIENTE+cQuery->D2_LOJA, 'A1_EMAIL')) //e-Mail
		cLin	+=	'|'
		cLin	+=	'00000000000000'   //Valor PIS
		cLin	+=	'|'
		cLin	+=	'00000000000000'   //Valor Cofins
		cLin	+=	'|'
		cLin	+=	'00000000000000'   //Valor INSS
		cLin	+=	'|'
		cLin	+=	'00000000000000'   //Valor IR
		cLin	+=	'|'
		cLin	+=	'00000000000000'   //Valor CSLL
		cLin	+=	'|'
		If Len(ALLTRIM(POSICIONE('SF3',5,cQuery->D2_FILIAL+cQuery->D2_SERIE+cQuery->D2_DOC, 'F3_NFELETR'))) > 4
			cLin	+=	CVALTOCHAR(VAL(RIGHT(ALLTRIM(POSICIONE('SF3',5,cQuery->D2_FILIAL+cQuery->D2_SERIE+cQuery->D2_DOC, 'F3_NFELETR')),5)))
		Else
		    cLin	+=	ALLTRIM(POSICIONE('SF3',5,cQuery->D2_FILIAL+cQuery->D2_SERIE+cQuery->D2_DOC, 'F3_NFELETR'))
		EndIf
		cLin	+=	'|'
		
		
		cLin	+=  Chr(13) + Chr(10)
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Gravacao no arquivo texto. Testa por erros durante a gravacao da    ณ
		//ณ linha montada.                                                      ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		
		If fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
			If !MsgAlert("Ocorreu um erro na gravacao do arquivo. Continua?","Atencao!")
				Exit
			Endif
		Else
			u_inserttxt(cArqTxt,"NFE",cFil,nItem)
		Endif
		nPvIni  := cQuery->D2_DOC
		cQuery->(dbSkip())
		nPvFim	:= cQuery->D2_DOC
		DbSelectArea("cSelect")
		DbCloseArea()
		DbSelectArea("cSel")
		DbCloseArea()
	EndDo
	
	
	DbSelectArea("cQuery")
	DbCloseArea()
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ O arquivo texto deve ser fechado, bem como o dialogo criado na fun- ณ
	//ณ cao anterior.                                                       ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	fClose(nHdl)
	Close(oGeraTxt)
	
	MsgInfo("Gera็ใo Concluida!!")
	
Return
