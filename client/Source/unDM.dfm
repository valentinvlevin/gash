object DM: TDM
  OldCreateOrder = False
  OnDestroy = DataModuleDestroy
  Height = 247
  Width = 401
  object udCon: TADConnection
    Params.Strings = (
      'Database=data.stg'
      'StringFormat=Unicode'
      'OpenMode=ReadWrite'
      'DriverID=SQLite')
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    FormatOptions.AssignedValues = [fvStrsTrim]
    FormatOptions.StrsTrim = False
    LoginPrompt = False
    Left = 24
    Top = 16
  end
  object udtbl: TADTable
    Connection = udCon
    Left = 24
    Top = 80
  end
  object FDGUIxWaitCursor: TADGUIxWaitCursor
    Provider = 'Forms'
    Left = 120
    Top = 80
  end
  object FDPhysSQLiteDriverLink: TADPhysSQLiteDriverLink
    Left = 120
    Top = 16
  end
  object adTblTrans: TADTable
    Connection = udCon
    UpdateOptions.UpdateTableName = 'Translations'
    TableName = 'Translations'
    Left = 216
    Top = 16
  end
end
