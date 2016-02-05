object DM: TDM
  OldCreateOrder = False
  Height = 246
  Width = 396
  object fdCon_PG: TADConnection
    Params.Strings = (
      'DriverID=PG')
    Left = 96
    Top = 56
  end
  object ADPhysPgDriverLink: TADPhysPgDriverLink
    Left = 96
    Top = 136
  end
  object ADPhysSQLiteDriverLink: TADPhysSQLiteDriverLink
    Left = 264
    Top = 136
  end
  object fdCon_lite: TADConnection
    Params.Strings = (
      'StringFormat=Unicode'
      'DriverID=SQLite')
    Left = 264
    Top = 56
  end
  object ADGUIxWaitCursor: TADGUIxWaitCursor
    Left = 176
    Top = 40
  end
end
