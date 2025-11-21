object dm: Tdm
  OldCreateOrder = False
  Height = 213
  Width = 256
  object con1: TUniConnection
    ProviderName = 'InterBase'
    SpecificOptions.Strings = (
      'InterBase.Charset=utf8'
      'InterBase.UseUnicode=True')
    Username = 'sysdba'
    LoginPrompt = False
    Left = 24
    Top = 24
    EncryptedPassword = '92FF9EFF8CFF8BFF9AFF8DFF94FF9AFF86FF'
  end
  object intrbsnprvdr1: TInterBaseUniProvider
    Left = 80
    Top = 24
  end
  object qwork: TUniQuery
    Connection = con1
    Left = 184
    Top = 24
  end
  object qtemp: TUniQuery
    Connection = con1
    Left = 136
    Top = 24
  end
  object usersTbl: TUniTable
    TableName = 'TUSERS'
    Connection = con1
    Left = 24
    Top = 88
  end
  object usersDS: TUniDataSource
    DataSet = usersTbl
    Left = 88
    Top = 88
  end
  object qMainGrid: TUniQuery
    Connection = con1
    SQL.Strings = (
      'select * from torders')
    Left = 24
    Top = 136
    object qMainGridALLORDERID: TIntegerField
      FieldName = 'ALLORDERID'
      Required = True
    end
    object qMainGridORDERID: TIntegerField
      FieldName = 'ORDERID'
      Required = True
    end
    object qMainGridUSERNAIM: TStringField
      FieldKind = fkLookup
      FieldName = 'USERNAIM'
      LookupDataSet = usersTbl
      LookupKeyFields = 'USERID'
      LookupResultField = 'USERNAIM'
      KeyFields = 'USERID'
      Size = 30
      Lookup = True
    end
    object qMainGridUSERID: TIntegerField
      FieldName = 'USERID'
      Required = True
    end
    object qMainGridSTOL: TStringField
      FieldName = 'STOL'
      Required = True
      Size = 12
    end
    object qMainGridOPENED: TDateTimeField
      FieldName = 'OPENED'
      Required = True
    end
    object qMainGridCLOSED: TDateTimeField
      FieldName = 'CLOSED'
      Required = True
    end
    object qMainGridPLASTIK: TIntegerField
      FieldName = 'PLASTIK'
      Required = True
    end
    object qMainGridWSUMM: TIntegerField
      FieldName = 'WSUMM'
      Required = True
    end
    object qMainGridFOIZ: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'FOIZ'
      Calculated = True
    end
    object qMainGridALLSUMM: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'ALLSUMM'
      Calculated = True
    end
  end
  object mainDS: TUniDataSource
    DataSet = qMainGrid
    Left = 88
    Top = 136
  end
  object qtemp2: TUniQuery
    Connection = con1
    Left = 184
    Top = 72
  end
end
