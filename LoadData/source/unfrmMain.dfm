object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1060#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077' '#1092#1072#1081#1083#1072' '#1089' '#1076#1072#1085#1085#1099#1084#1080' '#1043#1040#1064
  ClientHeight = 116
  ClientWidth = 322
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object gProgress: TGauge
    Left = 232
    Top = 24
    Width = 65
    Height = 65
    Kind = gkPie
    Progress = 0
  end
  object Button1: TButton
    Left = 32
    Top = 24
    Width = 177
    Height = 25
    Caption = #1057#1092#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100' '#1092#1072#1081#1083' '#1076#1072#1085#1085#1099#1093
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 32
    Top = 64
    Width = 177
    Height = 25
    Caption = #1042#1099#1093#1086#1076
    TabOrder = 1
    OnClick = Button2Click
  end
  object fdQry_lite: TADQuery
    Connection = DM.fdCon_lite
    Left = 72
    Top = 64
  end
  object fdQry_PG: TADQuery
    Connection = DM.fdCon_PG
    FetchOptions.AssignedValues = [evRecordCountMode]
    FetchOptions.RecordCountMode = cmTotal
    Left = 144
    Top = 64
  end
end
