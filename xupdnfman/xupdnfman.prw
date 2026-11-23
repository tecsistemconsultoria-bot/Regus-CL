#INCLUDE "PROTHEUS.CH"
#INCLUDE "APWIZARD.CH"
#INCLUDE "FILEIO.CH"
#INCLUDE "RPTDEF.CH"
#INCLUDE "PARMTYPE.CH"

User Function XUPDNFMAN(lAuto)

Local oWizard  := Nil
Local oPanel   := Nil
Local cUkFile  := Space(30)
Local lImport  := .F.
Local aFiles   := {}
Local nX       := 0
Local oGetFile
Local lOK      := .F.

DEFAULT lAuto := .F.

/*If SM0->M0_CODIGO == "01"
	//RpcSetEnv("01","01")
	cEmpAnt := "01"
Else
	//RpcSetEnv("02","01")
	cEmpAnt := "02"
EndIf*/

//AjustaSX6()
//AjustaSX1("MT460A")

PRIVATE _UKFILE     := "_UKFILE"		//"SZ6"+cEmpAnt+"0"
PRIVATE _UKFILE_CAB := "_UKFILE"		//"SZ6"+cEmpAnt+"0"
PRIVATE lTXT        := .T.
PRIVATE lJOB        := lAuto
PRIVATE oProcess    := NIL
PRIVATE _cPATH      := GetMV("UK_PATH")					//"D:\Data2\"
PRIVATE lGeraLog    := GetMV("UK_GERALOG")				//.T. - Gera��o de Log ao final do processo.
PRIVATE lAbrePerg   := .F.


	nOpc := 0
	lRet := .F.
	DEFINE MSDIALOG oDlg TITLE OemToAnsi("Importa��o de Updates") From 0,0 To 25,50
	
	//--Arquivo
	oSayArq := tSay():New(05,07,{|| "Informe o local onde se encontra o arquivo para importa��o:"},oDlg,,,,,,.T.,,,200,80)
	oGetArq := TGet():New(15,05,{|u| If(PCount()>0,_cPATH:=u,_cPATH)},oDlg,150,10,'@!',,,,,,,.T.,,,,,,,,,,'_cPATH')
	oBtnArq := tButton():New(15,160,"&Abrir...",oDlg,{|| cUkFile := FTUKAbrir(_cPATH)},30,12,,,,.T.) //&Abrir...
	
	//--Botoes
	oBtnImp := tButton():New(170,050,"Importar",oDlg,{|| nOpc:=1,oDlg:End()},40,12,,,,.T.) //Importar
	oBtnCan := tButton():New(170,110,"Cancelar",oDlg,{|| nOpc:=0,oDlg:End()},40,12,,,,.T.) //Cancelar
	
	ACTIVATE MSDIALOG oDlg CENTERED
	
	If nOpc == 1 .AND. !Empty(cUKFile)
		lOK := FTUKProc( cUkFile )
	EndIf
	

Return lOK

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    � FTUKAbrir   � Autor � Lucas         � Data � 06.02.13 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Abrir arquivo .csv|.xls                                    ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � FTUKAbrir(cPATH)	          	                              ���
�������������������������������������������������������������������������Ĵ��
���Parametros� Nenhum						                              ���
�������������������������������������������������������������������������Ĵ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function FTUKAbrir(cCaminho)

cType 	 := "Uk Files (*.csv) |NF MAN*.csv|"
cType    += "Uk Files (*.xls) |NF MAN*.xls|"
cType	 += "All Files|*.*"
cUkFile  := cGetFile(cType, "Selecione el archivo para importa��o")

If !Empty(cUkFile)
	cUkFile += Space(100-Len(cCaminho))
Else
	cUkFile := Space(100)
EndIf
_cPATH := cUkFile
Return cUkFile

//--------------

Static Function FTUKProc(cUKFile)
Local cTexto   := ""
Local aInfo    := {}
Local cAux     := ""
Local lGeraLog := .T.  

cTexto += Replicate( "-", 128 ) + CRLF
cTexto += "Empresa : " + SM0->M0_CODIGO + "/" + SM0->M0_NOME + CRLF + CRLF
                    
              
oProcess := MsNewProcess():New( { | lEnd | ImportUKFile(,,cUkFile,@cTexto) }, 'Importando UkFile', 'Empresa: ' + SM0->M0_CODIGO + ' ' + SM0->M0_NOME + '.', .F. )
oProcess:Activate()

oProcess := MsNewProcess():New( { | lEnd | AnalisaUKFile(,,,,,,cUkFile,@cTexto) }, 'Analisando UkFile', 'Empresa: ' + SM0->M0_CODIGO + ' ' + SM0->M0_NOME + '.', .F. )
oProcess:Activate()      
                         
oProcess := MsNewProcess():New( { | lEnd | GeraUpd(,,cUkFile,@cTexto) }, 'Aplicando Updates', 'Empresa: ' + SM0->M0_CODIGO + ' ' + SM0->M0_NOME + '.', .F. )
oProcess:Activate()                                                                                                                     

Return .T.

//-------------

Static Function ImportUKFile(oMeter, oMeter2, cUKFile, cTexto)
Local nI := 0
Local cSql := ""
Local aDados  := {}
Local nPosBar := Rat("\",cUkFile)
Local nPosPto := Rat(".",cUkFile)
Local cFile   := Substr(cUkFile,nPosBar+1,nPosPto-nPosBar-1)
Local cExt    := Substr(cUKFile, nPosPto+1)

If !(File(cUKFile))
	If !lJOB
		MsgStop("O arquivo " + cUkFile + " nao encontrado.")
	Else
		FwLogMsg("INFO", ,"" , ,"" ,"" ,"O arquivo " + cUkFile + " nao encontrado.")
	EndIf
	Return .F.
EndIF

If UkImpoted(cFile)
	If !lJOB
		If MsgYesNo("O arquivo " + cUkFile + " ja foi importado anteriormente, deseja processar o mesmo arquivo? " + CRLF + " (Os dados do arquivo nao serao importados novamente)")
			Return .T.
		Else
			Return .F.
		EndIf
	Else
		Return .T.
	EndIf
EndIf

If "XLS"$UPPER(cExt)
	cUkFile := Xls2Csv(cUkFile)
EndIF
If !(File(cUKFile))
	MsgStop("O arquivo " + cUkFile + " nao encontrado.")
	Return .F.
EndIF

aDados  := If(lJOB, CargaCSV(,cUkFile), CargaCSV(oMeter,cUkFile))

If Empty(aDados)
	If lJOB
		FwLogMsg("INFO", ,"" , ,"" ,"" ,"Arquivo vazio ou invalido. Por favor, verifique o seu conteudo.")
	Else
		MsgInfo("Arquivo vazio ou invalido. Por favor, verifique o seu conteudo.")
	EndIf
	Return .F.
EndIF

/* ... resto da fun��o continua igual daqui pra baixo (a partir do "If !lJOB / oProcess:SetRegua1") ... */

//Chk_UkFile()

If !lJOB
	oProcess:SetRegua1( 8 )
	oProcess:IncRegua2( "Convertendo arquivo UKFile..." )
EndIf

nDec := Len(aDados)/100
nStep := nDec
nLin :=0

For nI := 2 To Len(aDados) // As 2 primeiras linhas s�o de cabe�alho
	
	//nPosCto := AScan(aEmpFil,{|x| Alltrim(x[RAM])== aDados[nI][XCENTRO] })
	
	
	cSql := "INSERT INTO REGUPDNF (Z6_UKFILE, Z6_EMPRESA, Z6_FILIAL, Z6_XINVNUM, Z6_NFELETR, Z6_CODNFE, Z6_XRPS) " + ;
	"VALUES(" + ;
	"'" + cFile             +"', " + ;
	"'" + (aDados[nI][1])  +"', " + ;
	"'" + (aDados[nI][2])  +"', " + ;	
	"'" + (aDados[nI][4])  +"', " + ;		
	"'" + (aDados[nI][5])  +"', " + ;			
	"'" + (aDados[nI][6])  +"', " + ;				
	"'" + (aDados[nI][3])  +"') "
	
	nRet := TcSqlExec(cSql)
	nLin++
	If nLin >= nStep
		nStep += nDec
	EndIF
	
Next nI

If lJOB
	FwLogMsg("INFO", ,"" , ,"" ,"" ,"Importacao concluida com sucesso.")
Else
	oProcess:IncRegua2( "Importando concluida com sucesso." )
EndIf
Return .T.

//---

Static Function UkImpoted(cUkFile)
Local lExist := .F.
Local cAlias := "AliasUK"
Local cSql   := "SELECT COUNT(*) EXIST FROM REGUPDNF  WHERE LEFT(Z6_UKFILE," + Alltrim(Str(Len(cUkFile))) + ") = '" + UPPER(cUkFile) + "'"
dbUseArea( .T., "TopConn", TCGenQry(,,cSql), cAlias, .F., .F. )
If !EOF()
	lExist := ((cAlias)->EXIST > 0)
EndIf
(cAlias)->(DbCloseArea())
Return lExist

//---
Static Function CargaCSV(oMeter, cCSVFile)
Local aDados := {}
Local cLinha := ""
Local nHdl:=FOPEN(cCSVFile)
If nHdl <= -0
	Return aDados
EndIF
nTotal := FSEEK(nHdl,0,2)
FClose(nHdl)
//abre o arquivo csv gerado na temp
nHandle := Ft_Fuse(cCSVFile)
If nHandle == -1
	Return aDados
EndIf

nLin   := 0
nDec   := nTotal/100
nStep := nDec

Ft_FGoTop()

//percorre todas linhas do arquivo csv
Do While !Ft_FEof()
	//le a linha
	cLinha := Ft_FReadLn()
	//verifica se a linha est� em branco, se estiver pula
	If Empty(AllTrim(StrTran(cLinha,';','')))
		Ft_FSkip()
		Loop
	EndIf
	//transforma as aspas duplas em aspas simples
	cLinha := StrTran(cLinha,"'","")
	cLinha := StrTran(cLinha,'"',"'")
	cLinha := '{"'+cLinha+'"}'
	//adiciona o cLinha no array trocando o delimitador ; por , para ser reconhecido como elementos de um array
	cLinha := StrTran(cLinha,';','","')
	aAdd(aDados, &cLinha)
	
	//passa para a pr�xima linha
	FT_FSkip()
	nLin += Len(cLinha)
	If nLin >= nStep
		nStep += nDec
	EndIf
EndDo

//libera o arquivo CSV
FT_FUse()

Return aDados       

//---------------------------------

Static Function AnalisaUKFile(oMeter3, oMeter4, oSayInv, oSayCli, oSayBlq, oSayBlq, cUkFile, cTexto)
Local nPosBar := Rat("\",cUkFile)
Local nPosPto := Rat(".",cUkFile)
Local cFile   := Substr(cUkFile,nPosBar+1,nPosPto-nPosBar-1)
Local lFind    := .F.
Local cUpd     :=""
Local cCGC     :=""

If !lJOB
	oProcess:SetRegua1( 8 )      
EndIf

// Marca Filial os clientes bloqueados e inexistentes para refaturamento
//cUpd := "UPDATE NFMANUAL SET Z6_XINDOK = " + SM0->M0_CODIGO + " WHERE Z6_UKFILE='" + cFile + "' 
//TcSqlExec(cUpd)

oProcess:IncRegua2( "Atualizando clientes inexistentes..." )

Return .T.

//---------------

Static Function GeraUpd(oMeter, oMeter2, cUKFile, cTexto)
Local cAliasUPD := "AliasUPD"
Local nPosCto   := 0
Local cPref     := ""         
Local cQueryB := ""
Local nPosBar := Rat("\",cUkFile)
Local nPosPto := Rat(".",cUkFile)
Local cFile   := Substr(cUkFile,nPosBar+1,nPosPto-nPosBar-1)
Local cChave    := ""
Local cSql := " SELECT Z6_UKFILE, Z6_EMPRESA, Z6_FILIAL, Z6_XINVNUM, Z6_NFELETR, Z6_CODNFE, Z6_XRPS, Z6_SERIE" + ;
				" FROM REGUPDNF " + ;
				" WHERE  Z6_UKFILE = '" + cFile + "'" 

dbUseArea( .T., "TopConn", TCGenQry(,,cSql), cAliasUPD, .F., .F. )

If !lJOB
	oProcess:SetRegua1( 8 )
EndIf

While (cAliasUpd)->(!EOF())

	cQuery := "UPDATE SF2" + (cAliasUpd)->Z6_EMPRESA + "0 SET F2_CODNFE = '" + (cAliasUpd)->Z6_CODNFE + "' WHERE F2_FILIAL = '" + (cAliasUpd)->Z6_FILIAL + "' AND F2_DOC = '" + (cAliasUpd)->Z6_XRPS + "' AND F2_SERIE IN ('1  ','8','RPS','13') "
	
	Begin Transaction
		nErro := TcSqlExec( cQuery )
	End Transaction	

	If nErro == 0	
		cQuery := "COMMIT"		
		TcSqlExec(cQuery)	
	Else
		FwLogMsg("INFO", ,"" , ,"" ,"" ,"XUPDNFMAN - Erro Update A: "+TCSQLError())		
	Endif 

	cQueryB := "UPDATE SF3" + (cAliasUpd)->Z6_EMPRESA + "0 SET F3_NFELETR = '" + (cAliasUpd)->Z6_NFELETR + "' WHERE F3_FILIAL = '" + (cAliasUpd)->Z6_FILIAL + "' AND F3_NFISCAL = '" + (cAliasUpd)->Z6_XRPS + "' AND F3_SERIE IN ('1  ','8','RPS','13') "
	
	Begin Transaction
		nErro := TcSqlExec( cQueryB )
	End Transaction	

	If nErro == 0	
		cQueryB := "COMMIT"		
		TcSqlExec(cQueryB)	
	Else
		FwLogMsg("INFO", ,"" , ,"" ,"" ,"XUPDNFMAN - Erro Update B: "+TCSQLError())		
	Endif 

(cAliasUPD)->(DbSkip())	
		
EndDo
(cAliasUPD)->(DbCloseArea())

Return .T.	
