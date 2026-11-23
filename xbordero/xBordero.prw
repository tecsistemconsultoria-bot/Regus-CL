#Include 'Protheus.ch'
#Include 'Parmtype.ch'
#Include 'TopConn.ch'

/***********************************************************************
Autor: Vinicius N. de Oliveira
Data: 09/06/2023
Consultoria: TecSistem Soluções em Sistemas de Informação
Uso: Regus
Tipo: Atualizações
Rotina: Financeiro
Função: xBordero
Info: 
Alteração: 25/03/2026 - Inclusão simultânea de BOL e NF na geração
           do borderô com opção de filtrar por tipo (BOL, NF ou Ambos),
           eliminando pergunta binária anterior e evitando CNAB duplicado.
************************************************************************/
User Function xBordero()

    Local cPerg  := Padr("xyzBordero",10)
    Local aArea  := GetArea()
    
    Private cDiretorio := ""
    
    AjustaSX1(cPerg)
    
    If Pergunte(cPerg,.T.)
    
        cDiretorio := cGetFile("Arquivo Texto ( *.TXT ) |*.TXT|", "Selecione o diretório",,,.F., GETF_NETWORKDRIVE + GETF_LOCALFLOPPY + GETF_LOCALHARD + GETF_RETDIRECTORY)    

        FWMsgRun(,{||xFiltro()},"Aguarde","Gerando borderôs...")
        
    Endif     

    RestArea(aArea)

Return 

/*=================================================================
Autor: Vinicius N. de Oliveira
Data: 09/06/2023
Consultoria: TecSistem Soluções em Sistemas de Informação
Uso: Regus
Info: Filtro de dados
Alteração: 25/03/2026 - Adicionado filtro dinâmico por tipo (BOL, NF
           ou Ambos) conforme seleção do usuário na pergunta 05.
*==================================================================*/
Static Function xFiltro()

    Local cQuery   := ""
    Local cNumBor  := ""
    Local cFilEmp  := ""
    Local cMsg     := ""
    Local cPasta   := GetMV("XX_PSTBOR",.F.,"C:\temp\")
    Local cTemp    := GetNextAlias()
    Local cData    := StrTran(DToS(Date()),"/","")
    Local cHora    := StrTran(Time(),":","")
    Local cDtHora  := AllTrim(cData+"_"+cHora)    
    Local aTitulos := {}
    Local nX       := 0
    
    If !ExistDir(cPasta)
        MakeDir(cPasta)
    Endif

    cQuery += " SELECT E1_FILIAL,"
    cQuery += "       R_E_C_N_O_ RECNO"
    cQuery += " FROM "+RetSQLName("SE1")+" SE1"
    cQuery += " WHERE E1_NUMBOR = '      '"
    cQuery += "  AND E1_EMISSAO BETWEEN '"+DToS(mv_par03)+"' AND '"+DToS(mv_par04)+"'"
    cQuery += "  AND E1_CLIENTE BETWEEN '      ' AND 'ZZZZZZ'"
    cQuery += "  AND E1_VENCREA BETWEEN '"+DToS(mv_par01)+"' AND '"+DToS(mv_par02)+"'"
    cQuery += "  AND E1_MOEDA = 1"
    cQuery += "  AND E1_PREFIXO BETWEEN '   ' AND 'ZZZ'"
    cQuery += "  AND E1_NUM BETWEEN '         ' AND 'ZZZZZZZZZ'"
    cQuery += "  AND E1_SALDO > 0"
    cQuery += "  AND E1_XINVLIS <> ''"
    cQuery += "  AND E1_TIPO IN ('131',"
    cQuery += "                  '132',"
    cQuery += "                  'AB-',"
    cQuery += "                  'ADF',"
    cQuery += "                  'ADI',"
    cQuery += "                  'AF ',"
    cQuery += "                  'CC ',"
    cQuery += "                  'CD ',"
    cQuery += "                  'CDC',"
    cQuery += "                  'CF-',"
    cQuery += "                  'CH ',"
    cQuery += "                  'CN ',"
    cQuery += "                  'CO ',"
    cQuery += "                  'COF',"
    cQuery += "                  'CR ',"
    cQuery += "                  'CS-',"
    cQuery += "                  'CSL',"
    cQuery += "                  'CSS',"
    cQuery += "                  'DDI',"
    cQuery += "                  'DG ',"
    cQuery += "                  'DH ',"
    cQuery += "                  'DIC',"
    cQuery += "                  'DP ',"
    cQuery += "                  'EF ',"
    cQuery += "                  'FC ',"
    cQuery += "                  'FER',"
    cQuery += "                  'FI ',"
    cQuery += "                  'FOL',"
    cQuery += "                  'FT ',"
    cQuery += "                  'FU-',"
    cQuery += "                  'IN-',"
    cQuery += "                  'INS',"
    cQuery += "                  'INV',"
    cQuery += "                  'IR-',"
    cQuery += "                  'IRF',"
    cQuery += "                  'IS-',"
    cQuery += "                  'ISS',"
    cQuery += "                  'JP ',"
    cQuery += "                  'NCC',"
    cQuery += "                  'NCE',"
    cQuery += "                  'NCF',"
    cQuery += "                  'NCI',"
    cQuery += "                  'NCP',"
    cQuery += "                  'NDC',"
    cQuery += "                  'NDE',"
    cQuery += "                  'NDF',"
    cQuery += "                  'NDI',"
    cQuery += "                  'NDP',"
    // Alteração 25/03/2026: Filtro dinâmico por tipo conforme mv_par05
    // 1 = somente BOL | 2 = somente NF | 3 = Ambos (BOL + NF)
    If mv_par05 == 1
        cQuery += "                  'BOL',"
    ElseIf mv_par05 == 2
        cQuery += "                  'NF ',"
    Else
        cQuery += "                  'BOL',"
        cQuery += "                  'NF ',"
    Endif
    // ---
    cQuery += "                  'NP ',"
    cQuery += "                  'OP ',"
    cQuery += "                  'PA ',"
    cQuery += "                  'PF ',"
    cQuery += "                  'PI-',"
    cQuery += "                  'PIS',"
    cQuery += "                  'PR ',"
    cQuery += "                  'PRE',"
    cQuery += "                  'PRT',"
    cQuery += "                  'R$ ',"
    cQuery += "                  'RA ',"
    cQuery += "                  'RC ',"
    cQuery += "                  'RES',"
    cQuery += "                  'RPA',"
    cQuery += "                  'SES',"
    cQuery += "                  'TF ',"
    cQuery += "                  'TX ',"
    cQuery += "                  'TXA',"
    cQuery += "                  'VA ',"
    cQuery += "                  'VL ',"
    cQuery += "                  'VU ',"
    cQuery += "                  '')"
    cQuery += "  AND E1_TIPO NOT IN ('PR ',"
    cQuery += "                      'RA ',"
    cQuery += "                      'NCC',"
    cQuery += "                      '',"
    cQuery += "                      'AB-',"
    cQuery += "                      'CF-',"
    cQuery += "                      'CS-',"
    cQuery += "                      'FB-',"
    cQuery += "                      'FC-',"
    cQuery += "                      'FE-',"
    cQuery += "                      'FM-',"
    cQuery += "                      'FP-',"
    cQuery += "                      'FU-',"
    cQuery += "                      'I2-',"
    cQuery += "                      'IM-',"
    cQuery += "                      'IN-',"
    cQuery += "                      'IR-',"
    cQuery += "                      'IS-',"
    cQuery += "                      'MN-',"
    cQuery += "                      'PI-',"
    cQuery += "                      'FC-',"
    cQuery += "                      'FE-',"
    cQuery += "                      'IR-',"
    cQuery += "                      'CS-',"
    cQuery += "                      'CF-',"
    cQuery += "                      'PI-')"
    cQuery += "  AND E1_ORIGEM NOT IN ('E',"
    cQuery += "                        'U',"
    cQuery += "                        'S')"
    cQuery += "  AND E1_SITUACA IN ('0',"
    cQuery += "                     'F',"
    cQuery += "                     'G',"
    cQuery += "                     'I',"
    cQuery += "                     'J',"
    cQuery += "                     'K',"
    cQuery += "                     '') "
    cQuery += "  AND D_E_L_E_T_ = ' '"
    cQuery += " ORDER BY E1_FILIAL,"
    cQuery += "         E1_NUMBOR,"
    cQuery += "         E1_EMISSAO"
    
    If Select(cTemp) > 0
        (cTemp)->(DbCloseArea())
        cTemp := GetNextAlias()
    Endif
    
    cQuery := ChangeQuery(cQuery)
    
    DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cTemp,.F.,.T.)

    DbSelectArea(cTemp)
    
    (cTemp)->(DbGoTop())
    
    While !((cTemp)->(Eof()))
    
        aAdd(aTitulos,{(cTemp)->E1_FILIAL,(cTemp)->RECNO})
    
        (cTemp)->(DbSkip())
    
    EndDo
    
    (cTemp)->(DbCloseArea())
    
    If Len(aTitulos) > 0
    
        For nX := 1 To Len(aTitulos)
            
            If Empty(cNumBor)
            
                cNumBor := Soma1(GetMV("MV_NUMBORR"))
                cFilEmp := aTitulos[nX,1]
            
            Endif 
            
            If AllTrim(cNumBor) == "1" .Or. AllTrim(cNumBor) == "A"
                cNumBor := xVerifNumBor()
            Endif 

            If cFilEmp <> aTitulos[nX,1]
                
                DbSelectArea("SX6")
                SX6->(DbSetOrder(1))
            
                If SX6->(DbSeek(xFilial("SX6")+'MV_NUMBORR'))
                
                    RecLock("SX6",.F.)
                    SX6->X6_CONTEUD := cNumBor                
                    SX6->(MsUnlock())

                    cMsg += "Bordero: "+cNumBor+CRLF
                
                Endif 

                ConOut("xBordero: MV_NUMBORR atualizo com o valor "+cNumBor)
                
                cNumBor := Soma1(GetMV("MV_NUMBORR"))
                
            Endif 
            
            DbSelectArea("SE1")
            SE1->(DbGoTo(aTitulos[nX,2]))
            
            RecLock("SE1",.F.)
            SE1->E1_NUMBOR  := cNumBor
            SE1->E1_DATABOR := dDataBase
  

            If AllTrim(FWCodEmp()) == '01'
                SE1->E1_CONTA   := "46575-3"
                SE1->E1_PORTADO := "341"
                SE1->E1_AGEDEP  := "2000"
            ElseIf AllTrim(FWCodEmp()) == '02' 
                SE1->E1_CONTA   := "07150-2"
                SE1->E1_PORTADO := "341"
                SE1->E1_AGEDEP  := "2000"
            ElseIf AllTrim(FWCodEmp()) == '08'
                SE1->E1_CONTA   := "130193203"
                SE1->E1_PORTADO := "033"
                SE1->E1_AGEDEP  := "2271"
            Endif     

            SE1->E1_SITUACA := "1"
            SE1->E1_MOVIMEN := dDataBase
            SE1->(MsUnlock())
            
            DbSelectArea("SEA")
            
            RecLock("SEA",.T.)
            SEA->EA_FILIAL  := SE1->E1_FILIAL
            SEA->EA_PREFIXO := SE1->E1_PREFIXO
            SEA->EA_NUM     := SE1->E1_NUM
            SEA->EA_PARCELA := SE1->E1_PARCELA
            SEA->EA_PORTADO := SE1->E1_PORTADO
            SEA->EA_AGEDEP  := SE1->E1_AGEDEP
            SEA->EA_NUMBOR  := SE1->E1_NUMBOR
            SEA->EA_DATABOR := SE1->E1_DATABOR
            SEA->EA_TIPO    := SE1->E1_TIPO
            SEA->EA_CART    := "R"
            SEA->EA_NUMCON  := SE1->E1_CONTA
            SEA->EA_SITUACA := SE1->E1_SITUACA
            SEA->EA_SITUANT := "0"
            SEA->EA_FILORIG := SE1->E1_FILORIG
            SEA->EA_ORIGEM  := "FINA060"
            SEA->EA_BORAPI  := "N"
            SEA->(MsUnlock())
            
            cFilEmp := aTitulos[nX,1]
        
        Next nX 
    
    Endif 
    
    DbSelectArea("SX6")
    SX6->(DbSetOrder(1))
    
    If SX6->(DbSeek(xFilial("SX6")+'MV_NUMBORR'))
    
        RecLock("SX6",.F.)
        SX6->X6_CONTEUD := cNumBor                
        SX6->(MsUnlock())

        cMsg += "Bordero: "+cNumBor+CRLF
    
    Endif 
    
    If !Empty(cMsg)
        MemoWrite(cPasta+"Bordero_"+cDtHora+".txt",cMsg)
        ShellExecute("Open",cPasta+"Bordero_"+cDtHora+".txt","","",5)
    Endif
    
    If !Empty(cDiretorio)
        MemoWrite(cDiretorio+"Bordero_"+cDtHora+".txt",cMsg)
    Endif 

Return

/*=================================================================
Autor: Vinicius N. de Oliveira
Data: 11/09/2024
Consultoria: TecSistem Soluções em Sistemas de Informação 
Info: Verifico a numeração do borderô 
*==================================================================*/
Static Function xVerifNumBor()

    Local aArea   := GetArea()
    Local cQuery  := ""
    Local cNewBor := ""
    Local cTemp   := GetNextAlias()
    
    cQuery := " SELECT TOP 1 EA_NUMBOR FROM "+RetSQLName("SEA")
    cQuery += " WHERE D_E_L_E_T_ <> '*'"
    cQuery += " ORDER BY R_E_C_N_O_ DESC"

    If Select(cTemp) > 0
        (cTemp)->(DbCloseArea())
        cTemp := GetNextAlias()
    Endif
    
    cQuery := ChangeQuery(cQuery)
    
    DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cTemp,.F.,.T.)

    DbSelectArea(cTemp)
    
    (cTemp)->(DbGoTop())
    
    While !((cTemp)->(Eof()))
    
        cNewBor := Soma1((cTemp)->EA_NUMBOR)
    
        (cTemp)->(DbSkip())
    
    EndDo
    
    (cTemp)->(DbCloseArea())
    
    RestArea(aArea)

Return(cNewBor)

/*=================================================================
Autor: Vinicius N. de Oliveira
Data: 14/03/2023
Consultoria: TecSistem Soluções em Sistemas de Informação 
Info: Perguntas da SX1
Alteração: 25/03/2026 - Restaurada pergunta 05 com opções:
           1=BOL, 2=NF, 3=Ambos (processa os dois simultaneamente).
*==================================================================*/
Static Function AjustaSX1(cPerg)

    Local aRegs := {}
    Local nI    := 0
    Local nJ    := 0

    aAdd(aRegs,{cPerg,"01","Vencimento De?"  ,"","","mv_ch1","D",08,00,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","",""})
    aAdd(aRegs,{cPerg,"02","Vencimento Até?" ,"","","mv_ch2","D",08,00,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","",""})
    aAdd(aRegs,{cPerg,"03","Emissão De?"     ,"","","mv_ch3","D",08,00,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","",""})
    aAdd(aRegs,{cPerg,"04","Emissão Até?"    ,"","","mv_ch4","D",08,00,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","",""})
    // Alteração 25/03/2026: Pergunta 05 restaurada com três opções:
    // 1 = somente BOL | 2 = somente NF | 3 = Ambos (BOL + NF juntos)
	aAdd(aRegs,{cPerg,"05","Tipo?","3","1=BOL/2=NF/3=Ambos","mv_ch5","C",01,00,0,"C","","mv_par05","BOL","","","","","NF","","","","","Ambos","","","","","","","","","","","","","",""})

    DbSelectArea("SX1")
    SX1->(DbSetOrder(1))
    
    For nI := 1 To Len(aRegs)
    
        If !SX1->(DbSeek(cPerg + aRegs[nI,2]))
        
            RecLock("SX1",.T.)
            
            For nJ := 1 To FCount()

                If nJ <= Len(aRegs[nI])
                    FieldPut(nJ,aRegs[nI,nJ])
                Endif 
            
            Next nJ 
            
            SX1->(MsUnlock())
    
        Endif 
    
    Next nI

Return
