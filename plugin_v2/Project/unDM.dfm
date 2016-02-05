object DM: TDM
  OldCreateOrder = False
  Height = 388
  Width = 575
  object fdCon: TADConnection
    Params.Strings = (
      'Database=gash_ocen'
      'User_Name=postgres'
      'Password=ramgdov03q'
      'Server=192.168.57.129'
      'DriverID=PG')
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    FormatOptions.AssignedValues = [fvStrsTrim]
    FormatOptions.StrsTrim = False
    LoginPrompt = False
    Left = 48
    Top = 40
  end
  object fdTblKPO: TADTable
    Connection = fdCon
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.UpdateTableName = 'KPO'
    TableName = 'KPO'
    Left = 144
    Top = 120
  end
  object fdQry: TADQuery
    Connection = fdCon
    Left = 144
    Top = 40
  end
  object FDGUIxWaitCursor: TADGUIxWaitCursor
    Provider = 'Console'
    Left = 384
    Top = 192
  end
  object ADPhysPgDriverLink: TADPhysPgDriverLink
    Left = 376
    Top = 120
  end
end
