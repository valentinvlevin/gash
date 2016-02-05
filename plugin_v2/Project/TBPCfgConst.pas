unit TBPCfgConst;

// Copyright 2008-2010 Ritlabs SRL. All rights reserved.

interface

const
  // Account configuration index constants for referencing by ITBPDataProvider
  // (ITBPAccount)
  ucfx_8BitEncode             = 33001;
  ucfx_AddFolders             = 33003;
  ucfx_AllowAttach            = 33004;
  ucfx_AltDelMode             = 33005;
  ucfx_AltDelPurge            = 33006;
  ucfx_AltDelTrashFFF         = 33007;
  ucfx_AskReceivePassword     = 33008;
  ucfx_AttachmentEncode       = 33009;
  ucfx_AutoCheck              = 33010;
  ucfx_AutoDispatch           = 33011;
  ucfx_AutoHangup             = 33012;
  ucfx_CachePassword          = 33013;
  ucfx_CanEditEditor          = 33014;
  ucfx_CanEditHotKeys         = 33015;
  ucfx_CanEditMsgList         = 33016;
  ucfx_CanEditShortcuts       = 33017;
  ucfx_CanEditXLAT            = 33018;
  ucfx_ChangeSorting          = 33019;
  ucfx_ChangeTransport        = 33020;
  ucfx_CheckLocked            = 33021;
  ucfx_CheckOnActivate        = 33022;
  ucfx_CompressEmpty          = 33023;
  ucfx_CompressFoldersOnExit  = 33024;
  ucfx_ConfirmSendEditor      = 33025;
  ucfx_DeferredSend           = 33026;
  ucfx_DefMailTo              = 33027;
  ucfx_DefRCR                 = 33028;
  ucfx_DefRRQ                 = 33029;
  ucfx_DelAttach              = 33030;
  ucfx_DelFolderFFF           = 33031;
  ucfx_DelLargeMsgs           = 33032;
  ucfx_DelMode                = 33033;
  ucfx_DelMessages            = 33034;
  ucfx_DelOldMsgs             = 33035;
  ucfx_DelTrashMsgs           = 33036;
  ucfx_Dialup                 = 33037;
  ucfx_DontUsePGP             = 33038;
  ucfx_DontUseSMIME           = 33039;
  ucfx_DUNUseExisting         = 33040;
  ucfx_EarlyBind              = 33041;
  ucfx_EmptyTrash             = 33042;
  ucfx_EncryptCompleted       = 33043;
  ucfx_IgnoreAllCheck         = 33044;
  ucfx_iKeySMTP               = 33045;
  ucfx_ImapAutodisconnect     = 33046;
  ucfx_ImapAutoRefresh        = 33047;
  ucfx_ImapCompressClose      = 33048;
  ucfx_ImapConnectAnyV2V4     = 33049;
  ucfx_ImapConnectFoldersV2V4 = 33050;
  ucfx_ImapConnectSelectV2V4  = 33051;
  ucfx_ImapConnnectStartV2V4  = 33052;
  ucfx_IMAPDontRescanFlags    = 33053;
  ucfx_ImapGetStruct          = 33054;
  ucfx_ImapGetTextOnly        = 33055;
  ucfx_ImapMultiPort          = 33056;
  ucfx_ImapOutbox             = 33057;
  ucfx_ImapSent               = 33058;
  ucfx_ImapSyncDisconnect     = 33059;
  ucfx_ImapTrash              = 33060;
  ucfx_ImapUseGetTextLimit    = 33061;
  ucfx_LimitSize              = 33062;
  ucfx_MarkReadOpen           = 33063;
  ucfx_MarkReadTime           = 33064;
  ucfx_NoAutoDial             = 33065;
  ucfx_NoDelMarkread          = 33066;
  ucfx_NoFromInReply          = 33067;
  ucfx_OldAPOP                = 33068;
  ucfx_OptionsMenu            = 33069;
  ucfx_OwnConnection          = 33070;
  ucfx_AuthPopBeforeSMTP      = 33071;
  ucfx_PromptOnSplit          = 33072;
  ucfx_ProtocolType           = 33073;
  ucfx_PurgeUnread            = 33074;
  ucfx_QuoteType              = 33075;
  ucfx_RasLoginOverride       = 33076;
  ucfx_RCRAction              = 33077;
  ucfx_RCRAsk                 = 33078;
  ucfx_ReenterAuth            = 33079;
  ucfx_SA_cbSpecMD5           = 33080;
  ucfx_SA_MailRetrMD5         = 33081;
  ucfx_SendOnFetch            = 33082;
  ucfx_ShowDspAll             = 33083;
  ucfx_SignCompleted          = 33084;
  ucfx_SingleReOld            = 33085;
  ucfx_Slave                  = 33086;
  ucfx_SMTPAuth               = 33087;
  ucfx_SpecSMTP               = 33088;
  ucfx_SplitLimitSize         = 33089;
  ucfx_StoreFiles             = 33090;
  ucfx_UseMimeForward         = 33091;
  ucfxABFile                  = 33092;
  ucfxABName                  = 33093;
  ucfxAltDelFolderName        = 33094;
  ucfxAttDir                  = 33095;
  ucfxAuthMethod              = 33096;
  ucfxAutoCheck               = 33097;
  ucfxCachePwdMinutes         = 33098;
  ucfxChatMode                = 33099;
  ucfxConnRece                = 33100;
  ucfxConnSend                = 33101;
  ucfxCookies                 = 33102;
  ucfxCurPsw                  = 33103;
  ucfxDCExpandAll             = 33104;
  ucfxDefBookUID              = 33105;
  ucfxDefCharset              = 33106;
  ucfxDelFolderName           = 33107;
  ucfxHomeDir                 = 33108;
  ucfxExpanded                = 33109;
  ucfxfConfirmTemplate        = 33110;
  ucfxfFwdTemplate            = 33111;
  ucfxfReplyTemplate          = 33112;
  ucfxFromAddr                = 33113;
  ucfxFromName                = 33114;
  ucfxfTemplate               = 33115;
  ucfxHistoryMax              = 33116;
  ucfxID                      = 33117;
  ucfxiKeySASerNum            = 33118;
  ucfxiKeySerNum              = 33119;
  ucfxImapDCTime              = 33120;
  ucfxImapDCTimeType          = 33121;
  ucfxImapFolderRefresh       = 33122;
  ucfxImapFolderRefreshType   = 33123;
  ucfxImapFullTextLimit       = 33124;
  ucfxImapMaxMultiPort        = 33125;
  ucfxImapOutbox              = 33126;
  ucfxImapRoot                = 33127;
  ucfxImapSent                = 33128;
  ucfxImapTrash               = 33129;
  ucfxInSound                 = 33130;
  ucfxKnownChatAggressive     = 33131;
  ucfxLastABSel               = 33132;
  ucfxLastread                = 33133;
  ucfxLogHighlight            = 33134;
  ucfxMaxDays                 = 33135;
  ucfxMaxLog                  = 33136;
  ucfxMaxMsgSize              = 33137;
  ucfxMCExpandAll             = 33138;
  ucfxMemo                    = 33139;
  ucfxName                    = 33140;
  ucfxOrg                     = 33142;
  ucfxPassword                = 33143;
  ucfxPlaySound               = 33144;
  ucfxReceiveHost             = 33145;
  ucfxReceivePassword         = 33146;
  ucfxReceiveUser             = 33147;
  ucfxPort_Imap               = 33148;
  ucfxPort_Imap_TLS           = 33149;
  ucfxPort_Pop                = 33150;
  ucfxPort_Pop_TLS            = 33151;
  ucfxPort_Smtp               = 33152;
  ucfxPort_Smtp_TLS           = 33153;
  ucfxRAS_Entry               = 33154;
  ucfxRASLoginDomain          = 33155;
  ucfxRASLoginName            = 33156;
  ucfxRASLoginPassword_Plain  = 33157;
  ucfxRASRedialDelay          = 33158;
  ucfxRASRedialTries          = 33159;
  ucfxReadTime                = 33160;
  ucfxReceBioReader           = 33161;
  ucfxReceCacheBIOEnabled     = 33162;
  ucfxReceCacheBIOTime        = 33163;
  ucfxReceEnableBIO           = 33164;
  ucfxReceTokenSN             = 33165;
  ucfxReplyAddr               = 33166;
  ucfxReplyName               = 33167;
  ucfxSA_POP                  = 33168;
  ucfxSA_POP_Pwd_Plaintext    = 33169;
  ucfxSA_POP_User             = 33170;
  ucfxSA_SMTP_IKEYUser        = 33171;
  ucfxSA_SMTP_Pwd_Plaintext   = 33172;
  ucfxSA_SMTP_User            = 33173;
  ucfxSaveTemplate            = 33174;
  ucfxSCEmailsCrAPIReadFailed = 33175;
  ucfxSendBioReader           = 33176;
  ucfxSendCacheBIOEnabled     = 33177;
  ucfxSendCacheBIOTime        = 33178;
  ucfxSendEnableBIO           = 33179;
  ucfxSendTokenSN             = 33180;
  ucfxSizeLimit               = 33181;
  ucfxSmtp                    = 33182;
  ucfxSoundTime               = 33183;
  ucfxTCExpandAll             = 33184;
  ucfxTimeout                 = 33185;
  ucfxTopLines                = 33186;
  ucfxUnknownChatAggressive   = 33187;
  ucfxVCExpandAll             = 33188;
  ucfxVFolderTemplate         = 33189;
  ucfxEReceivePassword        = 33190;
  ucfxEReceiveUser            = 33191;
  ucfxEPassword               = 33192;
  ucfx_IMAPFixCourier         = 33193;
  ucfxSharedFilters           = 33194;
  ucfxLastSelectedFilter      = 33195;
  ucfxUID                     = 33199;
  ucfxVerboseLog              = 33200;
  ucfx_DispatchLocked         = 33202;
  ucfx_IMAPUseServerLock      = 33203; // enable internal locking mechanism in simultaneous connections
  ucfxExchangeProfile         = 33204;
  ucfxHeaderEncoding          = 33205; // 0 - auto, 1 - q-p, 2 - base64, 3 - 8-bit, 4 - none
  ucfxExchangeLog             = 33207; // whether sessions with Exchange server via MAPI should create verbose log files on the disk of activity
  ucfxSA_POP_Pwd_Scrambled    = 33212;
  ucfxSA_SMTP_Pwd_Scrambled   = 33213;
  ucfxRASLoginPassword_Scr    = 33214;
  ucfxTrackHistory            = 33215;
  ucfx_NumberedRe             = 33216;
  ucfxNewPassword             = 33217;
  ucfxfConfirmTemplateUTF     = 33220;
  ucfxfFwdTemplateUTF         = 33221;
  ucfxfReplyTemplateUTF       = 33222;
  ucfxfTemplateUTF            = 33223;
  ucfxSaveTemplateUTF         = 33224;
  ucfxPostponedSendings       = 33225;
  ucfx_ConfirmUnencryptedSend = 33226;
  ucfxImapConnectAllowedFor   = 33227;  // see icaf* definitions
  ucfx_ImapIgnoreFilters      = 33230;
  ucfx_ImapDontUseIdleCmd     = 33231;

  ucfxMultiSmtpCount          = 33232;
  ucfxActiveSmtp              = 33233;
  ucfxUseMultiSMTP            = 33234;

  ucfxImapAutoCheckSub        = 33235;

  ucfxSocialNetworkName       = 33236;
  ucfx_ImapResendIdleCmd      = 33237;

  ucfx_DontForceAscii         = 33238;

  ucfxQRSendTemplate          = 33239;
  ucfxQREditTemplate          = 33240;

  ucfxMarkRepliedRead         = 33241;

  ucfxGausKey                 = 33333;








  ucfx_NewFilters             = 50000;


  ucfxMultiSMTPBase           = 650000;


  ucfxColumnsVM       = 100000;
  ucfxColumnsVMSize   = 10000;
  ucfxMColumnsVMIdx   = 0;
  ucfxVColumnsVMIdx   = 1;
  ucfxTickerColumnsVMIdx = 2;
  ucfxFirstVMField    = 3; //vmThreadBy;

  // --- IMAP parameters common for accounts and folders ---
  // Indexes from 1000000 to 1999999 a reserved for this use
  ucfxImapFldDwnMode          = 1000000; // (ifdm* constants)
  ucfxImapFldDwnUnseen        = 1000001; // (ifmp* constants)
  ucfxImapFldDwnSeen          = 1000002; // (ifmp* constants)
  ucfxImapFldDwnUsePeriod     = 1000003; // Limit period (Boolean)
  ucfxImapFldDwnPeriodDays    = 1000004; // Days of interest
  ucfxImapFldDwnOlder         = 1000005; // (ifmp* constants)
  // Events
  _not_supported_ucfxImapFldDwnOnSelect      = 1000100; // Download on folder select
  ucfxImapFldDwnOnTimer       = 1000101; // Download on timer event
  ucfxImapFldDwnOnManual      = 1000102; // Download on "Receive new mail" click
  // --- (end of) IMAP parameters common for accounts and folders ---
  // Indexes from 1000000 to 1999999 a reserved for this use

const
  // Folder configuration index constants for referencing by ITBPDataProvider
  // (ITBPFolder)
  mfx_PurgeDays      = 201;
  mfx_PurgeMsgs      = 202;
  mfxCheckPsw        = 203;
  mfxConfirmAction   = 204;
  mfxConfirmAsk      = 205;
  mfxConfirmPersonal = 206;
  mfxConfirmTemplate = 207;
  mfxDefaultViewXLT  = 208;
  mfxDir             = 209;
  mfxExitCompress    = 210;
  mfxExitPurge       = 211;
  mfxExpanded        = 212;
  mfxfName           = 213;
  mfxFromAddr        = 214;
  mfxFromName        = 215;
  mfxFwdTemplate     = 216;
  mfxHidden          = 217;
  mfxInSound         = 218;
  mfxLastIdx         = 219;
  mfxMaxDays         = 220;
  mfxMaxMsgs         = 221;
  mfxMemo            = 222;
  mfxOKTicker        = 223;
  mfxOrder           = 224;
  mfxOrg             = 225;
  mfxPlaySound       = 227;
  mfxReplyAddr       = 228;
  mfxReplyName       = 229;
  mfxReplyTemplate   = 230;
  mfxSaveTemplate    = 231;
  mfxScannedObsolete = 232;
  mfxSoundTime       = 233;
  mfxTemplate        = 234;
  mfxUpdateAfter     = 235;
  mfxUseDefColumns   = 236;
  mfxUsePrnCtl       = 237;
  mfxVColumns        = 238;
  mfxDColumns        = 239;
  mfxMColumns        = 240;
  mfxxLastUID        = 241;
  mfxSubFolders      = 242;
  mfxSizeUsed        = 243;
  mfxDeletedMsgsObsolete = 244;
 		                // 245 - reserved for past IMAP use
  mfxBaseName        = 246;
		                // 247 - reserved for past IMAP use
                    // 248 - reserved for past IMAP use
                    // 249 - reserved for past IMAP use
                    // 250 - reserved for past IMAP use
                    // 251 - reserved for past IMAP use
                    // 252 - reserved for past IMAP use
                    // 253 - reserved for past IMAP use
                    // 254 - reserved for past IMAP use
                    // 255 - reserved for past IMAP use
                    // 256 - reserved for past IMAP use
  mfxOverrideDelete  = 257;
  mfxDeleteMode      = 258;
  mfxDeleteFolder    = 259;
  mfxAltDelMode      = 260;
  mfxAltDelFolder    = 261;
  mfxCompressEmpty   = 262;
  mfxAltDelPurge     = 263;
  mfxVColumnsEx      = 264;
  mfxDColumnsEx      = 265;
  mfxMColumnsEx      = 266;
  first_ex_column    = mfxVColumnsEx;
  ex_col_diff        = mfxVColumnsEx-mfxVColumns;
  mfxColumnsType     = 267;
  mfxViewModeID      = 268;
  mfxColorGroup      = 269;
  mfxFilter          = 270;
  mfxUID1            = 271;
  mfxUID2            = 272;
  mfxOwnerPos        = 273;
  mfxLastViewUID     = 274;
  mfxPreSearch       = 275;
  mfxUseFilter       = 276;
  mfxAutoSync        = 277;
  mfxLastMsgID       = 278;
  mfxLastImapFiltered =279;
  mfxIsDeleted       = 280;
  mfxSaveState       = 281;

  mfxUseCounters     = 294;
  mfxGroupBaseChanges= 295;
  mfxWrapDir         = 299;
  mfxForceFrom       = 303;  // KGBatMod only boolean flag
  mfxForceFromAddr   = 304;  // KGBatMod only address only
  mfxHistoryEmail    = 310;

  mfxConfirmTemplateUTF  =320;
  mfxFwdTemplateUTF     = 321;
  mfxReplyTemplateUTF   = 322;
  mfxSaveTemplateUTF    = 323;
  mfxTemplateUTF        = 324;
  mfxLastViewTopViewPos = 325;
  mfxScanned            = 326;
  mfxDeletedMsgs        = 327;
// 328 to 360 are reserved for IMAP
  mfx_fnx0F             = 361; // see fnx* in Config pas, "False"
  mfx_fnx1F             = 362;
  mfx_fnx2F             = 363;
  mfx_fnx3F             = 364;
  mfx_fnx4F             = 365;
  mfx_fnx5F             = 366;
  mfx_fnx6F             = 367;

  mfx_fnx0T             = 368; // see fnx* in Config pas, "True"
  mfx_fnx1T             = 369;
  mfx_fnx2T             = 370;
  mfx_fnx3T             = 371;
  mfx_fnx4T             = 372;
  mfx_fnx5T             = 373;
  mfx_fnx6T             = 374;

  mfxQReplyTemplate     = 380;


  // the mfxTbp_*** values are only returned by ITBPFolder,
  // they are calculated-on-the fly and thus temporary, in future they can be
  // renamed and moved to permanent valus of the above
  mfxTbp_Name             = 500;
  mfxTbp_FullName         = 501;
  mfxTbp_DisplayName      = 502;
  mfxTbp_FullDisplayName  = 503;

  //600-700 for meta folder
  cStartPmfInfo = 600;
  cEndPmfInfo = 700;

  mfxMf_Reserved            = 600;
  mfxMfLiveMailPeriodInDays = 601;
  mfxMfLastSentMsgCount     = 602;
  mfxMfLastSentMsgOldInDays = 603;
  mfxMfMaxSentLPMailsCount  = 604;
  mfxMfFolderNamebyEmail    = 605;
  mfxMfAddAccNameToName     = 606;
  mfxMfUseUserPhoto         = 607;
  mfxMfBlackList            = 608;
  mfxMfExpand               = 609;
  mfxMfFolderName           = 610;
  mfxMfAccounts             = 611;
//  mfxMfWhiteList            = 609;

// for meatsubfolder
  mfxMfEmailId              = 620;
  mfxMfFolderLastUseData    = 621;
  mfxMfFolderId             = 622;

  mfxShowQReply             = 623;

  mfxLastCopyFolder         = 624;
  mfxLastMoveFolder         = 625;

  // the values below are special
  mfxFoldersCount    = 1000;
  mfxFoldersStart    = 1001;
  mfxFoldersEnd      = 1300;

  mfxColumnsVM       = 10000;
  mfxColumnsVMSize   = 10000;
  mfxMColumnsVMIdx   = 0;
  mfxVColumnsVMIdx   = 1;
  mfxFirstVMField    = 3; // vmThreadBy;

  // --- IMAP parameters common for accounts and folders ---
  // Indexes from 1000000 to 1999999 a reserved for this use
  mfxImapFldDwnMode          = 1000000; // (ifdm* constants)
  mfxImapFldDwnUnseen        = 1000001; // (ifmp* constants)
  mfxImapFldDwnSeen          = 1000002; // (ifmp* constants)
  mfxImapFldDwnUsePeriod     = 1000003; // Limit period (Boolean)
  mfxImapFldDwnPeriodDays    = 1000004; // Days of interest
  mfxImapFldDwnOlder         = 1000005; // (ifmp* constants)
  // Events
  _not_supported_mfxImapFldDwnOnSelect      = 1000100; // Download on folder select
  mfxImapFldDwnOnTimer       = 1000101; // Download on timer event
  mfxImapFldDwnOnManual      = 1000102; // Download on "Receive new mail" click
  // --- (end of) IMAP parameters common for accounts and folders ---
  // Indexes from 1000000 to 1999999 a reserved for this use

const
  // Message data index constants for referencing by ITBPDataProvider
  // (ITBPMessage)
  mmxAttachUTF8  = 1;
  mmxFCutResSubj = 2;
  mmxFlagged     = 3;
  mmxForwarded   = 4;
  mmxFromAddr    = 5;
  mmxFromName    = 6;
  mmxID          = 7;
  mmxParked      = 8;
  mmxRef         = 9;
  mmxReplied     = 10;
  mmxReplyAddr   = 11;
  mmxReplyName   = 12;
  mmxSubj        = 13;
  mmxToAddr      = 14;
  mmxToName      = 15;
  mmxunRead      = 16;
  mmxDate        = 17;
  mmxRcvDate     = 18;
  mmxContentType = 19;
  mmxServerStrUID= 20; // POP3 UIDL or IMAP4 UID
  mmxXFiles      = 21;
  mmxXMsgs       = 22;
  mmxXFileCvt    = 23;
  mmxContentID   = 24;
  mmxContentPart = 25;
  mmxContentTotal= 26;
  mmxOrganization= 27;
  mmxTo_Cvt      = 28;
  mmxFrom_Cvt    = 29;
  mmxSubj_Cvt    = 30;
  mmxOrg_Cvt     = 31;
  mmxRefList     = 32;
  mmx_FileName   = 33;
  mmx_FileOffset = 34;
  mmx_FileSize   = 35;
  mmx_Memo       = 36;
  mmx_MemoEx     = 37;
  mmxComment     = 38;
  mmxComment_Cvt = 39;
  mmxMatter      = 40;
  mmxCustomData  = 41;
  mmxBrokenFlag  = 42;
  mmxAddresses   = 43;
  mmxKludges     = 44;
  mmxToW         = 45;
  mmxFromW       = 46;
  mmxSubjW       = 47;
  mmxReplyW      = 48;
  mmxCutReSubjW  = 49;
  mmxRCRto       = 50;
  mmxAttachmentCount = 51;
  mmxSubjNoCvt   = 52;
  mmxTextDataInValid = 55;
  mmxTags        = 60;
  mmxSizePadding = 69;
  mmxModDate     = 70;
  mmxReferredMsgURL = 71;
  mmxFromDomain     = 72;
  mmxToDomain       = 73;

  // Message flags (ITBPMessage.GetFlags)
  msfDeleted     =  $00000001;
  msfRead        =  $00000002;
  msfReplied     =  $00000004;
  msfParked      =  $00000008;
  msfAttach      =  $00000010;
  msfNoAttach    =  $00000020;
  msfFlagged     =  $00000040;
  msfForwarded   =  $00000080;
  msfIsPartial   =  $00000100;
  msfImapFiltered=  $00000200;
  msfHasMemo     =  $00000400;
  msfPKCS7Sig    =  $00000800;  { todo: replace to msfSigned }
  msfNeedSplit   =  $00001000;
  msfRcptCfmd    =  $00002000;
  msfPKCS7Enc    =  $00004000;  { todo: replace to msfEncrypted }

  msfDelayed     =  $00008000;
  msfRemote      =  $00010000; //* Message is not present locally
  msfRemoteTxtOnly= $00020000; //* Only textual parts are present locally
  msfStored      =  $00040000;
  __obsolete_msfDeleteOnline=  $00080000;
  msfHasReminder =  $00100000;
  msfChat        =  $00200000;
  msfRemoteHdrOnly= $00400000; //* Only message header is present locally
  msfNeedConfirm =  $00800000;
  msfInReply     =  $01000000;  // Message is being replied, when set
  msfXlatSet     =  $02000000;
  msfExpunged    =  $04000000;  // IMAP only
  msfUTC         =  $08000000;
  msfTagsChanged =  $10000000;  // Set if the tags in the index are not in sync with the tags from the message header
                 // $20000000;  // available
  msfImportFlags =  $40000000;
  msfTestFlagMustNotBeSet =
                    $80000000;

  msfInvalidFlags = $FFFFFFFF;

  msfPriorityTest = $8000000F;

  MsgBaseInvalidUserFlags = -1;
  MsgBaseInvalidColor = $FFFFFFFF;
  MsgBaseInvalidXLT = $FFFFFFFF;
  MsgBaseDefaultXLT = MsgBaseInvalidXLT;
  MsgBaseInvalidPriority = MaxInt;

  msfEnvelopeFlags = msfPKCS7Sig or msfPKCS7Enc or msfAttach or msfNoAttach;
  msfImapFlags     = msfRemote or msfRemoteHdrOnly or msfExpunged or msfImapFiltered or msfRemoteTxtOnly or __obsolete_msfDeleteOnline;
  msfRemoteFlags   = msfRemote or msfRemoteHdrOnly or msfRemoteTxtOnly;

  // messsage delete modes
  dmmDelTrash    = 0;
  dmmDelOnly     = 1;
  dmmDelFolder   = 2;


const
  // TToDoTask indexes
  tdxTaskUID          = 1301;
  tdxCreator          = 1302;
  tdxResponsibles     = 1303;
  tdxAccessList       = 1304;
  tdxSubject          = 1305;
  tdxFullText         = 1306;
  tdxStatus           = 1307;
  tdxPriority         = 1308;
  tdxPercentComplete  = 1309;
  tdxTimeDue          = 1310;
  tdxTimeCreated      = 1311;
  tdxTimeModified     = 1312;
  tdxTimeCompleted    = 1313;
  tdxLinkedTasks      = 1314;
  tdxGroups           = 1315;
  tdxFolder           = 1316;
  tdxSecurityOptions  = 1317;

  // TMessageContentLoader  IDs
  mclxBaseLoader      = 0;
  mclxIMAPLoader      = 1;
  mclxRSSLoader       = 2;
  mclxLocalFileLoader = 3;
  mclxNNTPLoader      = 4;

  icafUnknown         = 0;
  icafStartup         = 1;
  icafAccountSelect   = 2;
  icafReadOrModify    = 3;
  icafExplicitConnect = 4;

const
  // Indexes to get address lists from ITBPMessageStructure
  medxTo        = 0;
  medxCC        = 1;
  medxBCC       = 2;
  medxFrom      = 3;
  medxReplyTo   = 4;
  medxSender    = 5;
  medxXSender   = 6;

  // Message Address List indexes (ITBPAddressList)
  rfcadxName    = 1;
  rfcadxPath    = 2;
  rfcadxMailbox = 3;
  rfcadxDomain  = 4;
  rfcadxComment = 5;
  // the rfcadxTbp_*** values are only returned by ITBPMessageAddrList,
  // they are calculated-on-the fly and thus temporary, in future they can be
  // renamed and moved to permanent valus of the above
  rfcadxTbp_DecodedName    = 20;
  rfcadxTbp_DecodedComment = 21;
  rfcadxTbp_Address        = 22;
  rfcadxTbp_NameWithAddr   = 23;
  rfcadxTbp_Max            = rfcadxTbp_NameWithAddr; // Used by CalcID

  // Message structure indexes (ITBPMessageStructure, ITBPMessagePart)
  midxSubject     = 1;
  midxDate        = 2;
  midxComment     = 3;
  midxInReplyTo   = 4;
  midxMessageID   = 5;
  midxNewsgroups  = 6;
  midxMailer      = 7;
  midxContentType = 8;
  midxContentSubType = 9;
  midxExpireDate     = 10;
  midxOrganization   = 11;
  midxContentID      = 12;
  midxContentMD5     = 13;
  midxPriority       = 14;
  midxImportance     = 15;
  midxContentLocation= 16;
  midxEncoding       = 17;
  midxCharset        = 18;
  midxBoundary       = 19;
  midxMsgEncoding    = 20;
  midxC_Name         = 21;
  midxCD_Name        = 22;
  midxReportType     = 23;
  midxReferences     = 24;
  midxC_Description  = 25;
  midxContentDisposition = 26;
  midxContentLanguage = 27;
  midxC_ID            = 29;
  midxC_AccessType    = 30;
  midxC_Expiration    = 31;
  midxC_Size          = 32;
  midxC_Permission    = 33;
  midxC_Site          = 34;
  midxC_Directory     = 35;
  midxC_Mode          = 36;
  midxC_Server        = 37;
  midxC_Subject       = 38;
  midx_ObsoleteFiles  = 39;  // legacy X-Bat-Files kludge
  midx_ObsoleteMsgs   = 40;  // legacy X-Bat-Messages kludge
  midxReturnPath      = 41;
  midxFromName        = 42;
  midxFromAddr        = 43;
  midxReplyName       = 44;
  midxReplyAddr       = 45;
  midxToName          = 46;
  midxToAddr          = 47;
  midxServerID        = 48;
  midxRRC             = 49;
  midxRRQ             = 50;
  midxFileSubst       = 51;
  midxC_Number        = 52;
  midxC_Total         = 53;
//     midxXCFile          = 54;
  midxMDN_To          = 55;
  midxMDN_Options     = 56;
  midxRefList         = 57;
  midxC_MICAlg        = 58;
  midxC_SMIMEType     = 59;
  midxC_Protocol      = 60;
  midxC_ProtocolType  = 61;
  midxC_ProtocolSubType=62;
  midxMatter          = 63;
  midxListHelp        = 64;
  midxListUnsub       = 65;
  midxListSub         = 66;
  midxListPost        = 67;
  midxListOwner       = 68;
  midxListArchive     = 69;
  midxDecodedFrom     = 70;
  midxDecodedTo       = 71;
  midxDecodedSubj     = 72;
  midxDecodedToEtc    = 73;
  midxFrom            = 74;
  midxTo              = 75;
  midxCC              = 76;
  midxBCC             = 77;
  midxReplyTo         = 78;
  midxSender          = 79;
  midxXSender         = 80;
  midxImapURL         = 81;
  midxMailChat        = 82;
  midxMailingList     = 83;
  midxC_Format        = 84;
  midxC_Type          = 85;
  midxC_Min           = 86;
  midxC_Max           = 87;
  midxC_Mandatory     = 88;
  midxImapSize        = 89;
  midxC_CrType        = 90;
  midxExValName       = 91;
  midxDefValue        = 92;
  midxOrigRcpt        = 93;

  midxCIntData        = 94;
  midxCSpScope        = 95;
  midxCLoadFrom       = 96;
  midxCSaveTo         = 97;
  midxSpScope         = 98;
  midxLoadFrom        = 99;
  midxSaveTo          = 100;
  midxCCalck          = 101;
  midxSCalck          = 102;
  midxSubmitForm      = 103;
  midxSubmitFormIssuer = 104;
  midxSubmitFormVersion= 105;
  midxXMozillaStatus  = 106; // used to import message attributes from Mozilla, see http://www.eyrich-net.org/mozilla/X-Mozilla-Status.html?en
  midxXMozillaStatus2 = 107;

  midxSendDelay       = 108;
  midxSendDelayEvent  = 109;
  midxCDecimal        = 110;
  midxSDecimal        = 111;
  midxTags            = 112;
  midxRefferedMsgURL  = 113;

  // Look below to update the Max Index!
  midxMinIdx          = 1;
  midxMaxIdx          = 113;

  // the midxTbp_*** values are only returned by ITBPMessagePart,
  // they are calculated-on-the fly and thus temporary, in future they can be
  // renamed and moved to permanent valus of the above
  midxTbp_FileName    = 500; //* Decoded file name from
                             //* Content-Disposition or Content-Type

  // IDs to use with ITBPCoreBridge.GetVersionInfo
  vinfProductName       = 0;
  vinfProductVersion    = 1;
  vinfLegalCopyright    = 2;
  vinfFileVersion       = 3;
  vinfFileDescription   = 4;
  vinfAboutDescription  = 5;

  // IDs to use with ITBPCoreBridge.GetRegistrationInfo
  rinfSerialNo          = 0;

  // Attributes of address book (ITBPAddressBook)
  abaTbp_Name     = 1;
  abaTbp_Memo     = 2;
  abaTbp_FileName = 3;

  // Attributes of address book group (ITBPAddrBookGroup)
  ggaItems        = -1;
  ggaName         = 0;
  ggaHandle       = 1;
  ggaTemplateWin  = 2;
  ggaReplyWin     = 3;
  ggaForwardWin   = 4;
  ggaMemo         = 5;
  ggaOptions      = 6;
  ggaCharset      = 7;
  ggaTemplateUTF7 = 8;
  ggaReplyUTF7    = 9;
  ggaForwardUTF7  = 10;
  ggaParentBookID = 11;
  ggaSynchroUID   = 12; // UID of this record in remote storage
  ggaSynchroData  = 13; // Remote storage specific data needed for synchronization
  ggaSynchroMark  = 14; // Defines synchronization state (see symk* constants)

  //~~~~~~~~~~~~~~~~~
  ggaMaxAttr      = 14;
  ggaEnd          = -10;

  // Attributes of address book contact (ITBPAddrBookContact)
  aatName         = -1;
  aatFirstName    = -2;
  aatLastName     = -3;
  aatMiddleName   = -4;
  aatGroup        = -5;
  aatCheck        = -6;
  aatHandle       = -7;
  aatMainEmailIdx = -8;
  aatSex          = -9;
  aatTemplateOpts = -10;
  aatBCCSecondary = -11;
  aatDisplayNameAs= -12;

  aatEnd          = -90;

  aatPhoto        = -91;
  aatCert         = -92;
  aatHasTemplate  = -93;

  aatEmails       = -99;
  aatEmail        = -100;
  aatuserSMIMECertificate = -101;
  aatuserPKCS12   =-102;
  aatCACertificate=-103;
  aatUserCertificate=-104;
  //~~~~~~~~~~~~~~~~~~
  aatMinAttr      = -12;

  aatDName        = -30;
  aatHost         = -31;
  aatTimeStamp    = -32;

  aatInvalidAttr  = aatMinAttr-1;

  aatHomeAddr    = 0;
  aatHomeCity    = 1;
  aatHomeState   = 2;
  aatHomeZIP     = 3;
  aatHomeCountry = 4;
  aatHomePhone   = 5;
  aatHomeFax     = 6;
  aatHomeMobile  = 7;
  aatHomePage    = 8;
  aatBusCompany  = 9;
  aatBusAddr     = 10;
  aatBusCity     = 11;
  aatBusState    = 12;
  aatBusZIP      = 13;
  aatBusCountry  = 14;
  aatBusJob      = 15;
  aatBusDept     = 16;
  aatBusOffice   = 17;
  aatBusPhone    = 18;
  aatBusFax      = 19;
  aatBusPager    = 20;
  aatBusPage     = 21;
  aatMemo        = 22;
  aatTemplateWin = 23;
  aatReplyWin    = 24;
  aatForwardWin  = 25;
  aatBirthdayStr = 26;
  aatNamePrefix  = 27;
  aatNameSuffix  = 28;
  aatCharset     = 29;
  aatX509Subjs   = 30;
  aatX509Emails  = 31;
  aatX509IsrSNs  = 32;
  aatDBID        = 33;
  aatX509SKIs    = 34; // Subject Key Identifiers
  aatTemplateUTF7= 35;
  aatReplyUTF7   = 36;
  aatForwardUTF7 = 37;
  aatGooglePhotoHref = 38;
  aatUaEDRPOU    = 39;
  aatSynchroUID  = 40; // UID of this record in remote storage
  aatSynchroData = 41; // Remote storage specific data needed for synchronization
  aatSynchroMark = 42; // Defines synchronization state (see symk* constants)

  {~~~}
  aatMaxAttr     = 42;

  // Synchronization marks
  symkOriginal   = 'o'; // Record wasn't modified since last synchronization
  symkModified   = 'm'; // Record was modified
  symkDeleted    = 'd'; // Record was deleted

  // Menu properties (ITBPMenu)
  mnuTbp_Id      = 1; // Integer
  mnuTbp_Type    = 2; // Integer
  mnuTbp_Name    = 3; // String
  mnuTbp_Caption = 4; // WideString
  mnuTbp_Hint    = 5; // WideString
  mnuTbp_IconId  = 6; // Integer

type
  TMBProcessCallback = procedure (Sender: TObject; TotalMsgs, CurMsg: Integer; var Stop: Boolean) of object;

const
      fnxTotal               = 0;
      fnxUnread              = 1;
      fnxParked              = 2;
      fnxFlagged             = 3;
      fnxReplied             = 4;
      fnxForwarded           = 5;
      fnxColor               = 6;
//      //--- change the limit below
      fnxMaxIndex            = 6;

      dcfNormalFolder    = 0;
      dcfLocalFolder     = $15951595;
      dcfImapFolder      = $14941494;
      dcfVirtualFolder   = $41944194;
      dcfChatFolder      = $19441944;
      dcfHistory         = $48444484;

      ucxName        = 1;
      ucxUnread      = 2;
      ucxTotal       = 3;
      ucxTicker      = 4;
      ucxColumns     = 5;
      ucxWeight      = 6;
      ucxInfected    = 7;
      ucxDeleted     = 8;
      ucxSizeUsed    = 9;
      ucxViewMode    = 10;

      ucxInMessageCount   = 20;
      ucxOutMessageCount  = 21;
      ucxLastInMsgTime    = 22;
      ucxLastOutMsgTime   = 23;
      ucxEmail            = 24;
      ucxFullName         = 25;
      ucxHomeDir          = 26;
      ucxParking          = 27;
      ucxVFolder          = 28;
      ucxPureUnread       = 29;
      ucxPureTotal        = 30;
      ucxOrder            = 31;

      ucxPath        = 50;
      ucxCheck       = 60;
      ucxFltCheck    = 61;
      ucxAccount     = 62;

  bsfAll = 0;
  bsfUnread = 1;
  bsfParked = 2;
  bsfFlagged = 4;
  bsfNotReplied = 8;
  bsfAttachments = 16;
  bsfColour = 32;
  bsfSigned = 64;

  cfidConfigData    = $0000;
  cfidViewer        = $0100;
  cfidHeader        = $0200;
  cfidEditor        = $0300;
  cfidTicker        = $0400;
  cfidPreview       = $0500;
  cfidHotkeys       = $0600;
  cfidToolbars      = $0700;
  cfidEditorColors  = $0800;
  cfidAddrViewer    = $0900;
  cfidAddrSelector  = $0A00;
  cfidFinder        = $0B00;
  cfidDispatcher    = $0C00;
  cfidDispatchTool  = $0E00;
  cfidSmartPad      = $0F00;
  cfidSourceView    = $1000;
  cfidViewerTool    = $1100;
  cfidXLT           = $1200;
  cfidColor         = $1300;
  cfidViewMode      = $1400;
  cfidFolderTab     = $1500;
  cfidCardfileLink  = $1600;
  cfidMLFilter      = $1700;
  cfidOldMsgListTab = $1800;
//  cfidTabSet        = $1900;
  cfidConfirmations = $2000;
  cfidMiscOptions   = $2100;
  cifdViewerColorProfile = $2200;
  cfidSpellConfig   = $2300;
  cfidFolderSets    = $2400;
  cfidMessageListTab= $2500;
  cfidMLTabConverted= $2600;
  cfidTagLabel      = $2700;
  cfidTagColors     = $2800;
  cfidMHunterProfile= $2900;

  smsxServer          = 01;
  smsxActive          = 02;
  smsxConnectionType  = 03;
  smsxPort            = 04;
  smsxUseFilter       = 05;
  smsxFilter          = 06;
  smsxUseAuth         = 07;
  smsxAuthType        = 08;
  smsxAuthUser        = 09;
  smsxAuthPwd         = 10;
  smsxAuthTokenUser   = 11;
  smsxUseBioAuth      = 12;
  smsxCachePwd        = 13;
  smsxCachePwdTime    = 14;
  smsxPopBeforeSMTP   = 15;
  smsxShared          = 16;
  smsxPortTLS         = 17;
  smsxBioReader       = 18;
  smsxUseMD5          = 19;
  smsxUsePopMD5       = 20;
  smsxAuthTokenName   = 21;
  smsxAuthTokenSN     = 22;
  //----------------------
  smsxIsDefault       = 29;
  smsxLowIndex        = 1;
  smsxHighIndex       = 22;

  smsxIndexStep       = 30;

  satNoAuth           = 0;
  satSpecialLogin     = 1;
  satPOPLogin         = 2;
  satIKeyLogin        = 3;

  // Indexes to access program preferences
  prfAntiSpamScoreType      = 1001; //* (Integer) 0 - Average; 1 - Maximal; 2 - Minimal
  prfAntiSpamMsgDelete      = 1002; //* (Boolean)
  prfAntiSpamMsgJunk        = 1003; //* (Boolean)
  prfAntiSpamMsgDeleteScore = 1004; //* (Integer)
  prfAntiSpamMsgJunkScore   = 1005; //* (Integer)
  prfAntiSpamMsgJunkRead    = 1006; //* (Boolean)
  prfAntiSpamMsgJunkToJunk  = 1007; //* (Boolean)
  prfAntiSpamUseGlobalJunk  = 1008; //* (Boolean)

implementation

end.
