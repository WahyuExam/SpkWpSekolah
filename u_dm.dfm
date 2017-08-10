object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 527
  Top = 154
  Height = 494
  Width = 735
  object con1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=dbwp.mdb;Persist Se' +
      'curity Info=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 24
    Top = 16
  end
  object XPManifest1: TXPManifest
    Left = 80
    Top = 24
  end
  object qry_kriteria: TADOQuery
    Active = True
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from tbl_kriteria')
    Left = 24
    Top = 72
  end
  object qry_sekolah: TADOQuery
    Active = True
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from tbl_sekolah')
    Left = 24
    Top = 136
  end
  object ds_sekolah: TDataSource
    DataSet = qry_sekolah
    Left = 80
    Top = 128
  end
  object qry_bobot: TADOQuery
    Active = True
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from tbl_bobot')
    Left = 24
    Top = 208
  end
  object qry_tampil_bobot: TADOQuery
    Active = True
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'select a.kd_bobot, b.kd_kriteria, b.kriteria, a.bobot, a.jumlah ' +
        'from tbl_bobot a, tbl_kriteria b where a.kd_kriteria=b.kd_kriter' +
        'ia')
    Left = 80
    Top = 224
  end
  object ds_tampil_bobot: TDataSource
    DataSet = qry_tampil_bobot
    Left = 80
    Top = 280
  end
  object qry_indikator_penilaian: TADOQuery
    Active = True
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from tbl_nil_indikator')
    Left = 200
    Top = 88
  end
  object qry_tampil_indikator_penilaian: TADOQuery
    Active = True
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'select a.kd_nil_indi, b.kd_sub_kriteria, c.kd_kriteria, c.kriter' +
        'ia, b.sub_kriteria, a.nm_indi, a.nil_indi from tbl_nil_indikator' +
        ' a, tbl_sub_kriteria b, tbl_kriteria c where a.kd_sub_kriteria=b' +
        '.kd_sub_kriteria and b.kd_kriteria=c.kd_kriteria ')
    Left = 200
    Top = 152
  end
  object ds_tampil_indikator_penilaian: TDataSource
    DataSet = qry_tampil_indikator_penilaian
    Left = 288
    Top = 120
  end
  object ds_kriteria: TDataSource
    DataSet = qry_kriteria
    Left = 88
    Top = 72
  end
  object qry_subkriteria: TADOQuery
    Active = True
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from tbl_sub_kriteria')
    Left = 24
    Top = 352
  end
  object ds_subkriteria: TDataSource
    DataSet = qry_subkriteria
    Left = 80
    Top = 344
  end
  object qry_tampil_bantu_penilaian: TADOQuery
    Active = True
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'select a.kd_proses, b.kd_sub_kriteria, b.sub_kriteria, a.nm_indi' +
        ', a.nil_indi, a.kd_nil_indi, c.kd_kriteria, c.kriteria from tbl_' +
        'nil_sek a, tbl_sub_kriteria b, tbl_kriteria c  where a.kd_sub_kr' +
        'iteria=b.kd_sub_kriteria and b.kd_kriteria=c.kd_kriteria ')
    Left = 216
    Top = 248
  end
  object qry_bantu_penilaian: TADOQuery
    Active = True
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from tbl_bantu_nilai')
    Left = 216
    Top = 304
  end
  object ds_tampil_bantu_penilaian: TDataSource
    DataSet = qry_tampil_bantu_penilaian
    Left = 296
    Top = 232
  end
  object qry_rangking: TADOQuery
    Active = True
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from tbl_rangking')
    Left = 216
    Top = 368
  end
  object ds_indikator_nilai: TDataSource
    DataSet = qry_indikator_penilaian
    Left = 272
    Top = 64
  end
  object qry_nilai_sekolah: TADOQuery
    Active = True
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from tbl_nil_sek')
    Left = 272
    Top = 352
  end
  object qry_tampil_hasil: TADOQuery
    Active = True
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'select a.kd_proses, a.tahun, b.npsp, b.nm_sekolah, b.kec, a.jenj' +
        ', a.nilai_s, a.nilai_v, a.nilai_wp from tbl_rangking a, tbl_seko' +
        'lah b where a.npsp=b.npsp')
    Left = 440
    Top = 56
  end
  object tbl_pengguna: TADOTable
    Active = True
    Connection = con1
    CursorType = ctStatic
    TableName = 'tbl_login'
    Left = 152
    Top = 16
  end
  object ds_tampil_hasil: TDataSource
    DataSet = qry_tampil_hasil
    Left = 504
    Top = 32
  end
  object tbl_penanggung: TADOTable
    Active = True
    Connection = con1
    CursorType = ctStatic
    TableName = 'tbl_penanggungjawab'
    Left = 440
    Top = 120
  end
  object tbl_kec: TADOTable
    Active = True
    Connection = con1
    CursorType = ctStatic
    TableName = 'tbl_kecamatan'
    Left = 440
    Top = 184
  end
  object ds_kec: TDataSource
    DataSet = tbl_kec
    Left = 480
    Top = 216
  end
end
