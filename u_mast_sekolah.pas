unit u_mast_sekolah;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Buttons, DBCtrls, jpeg, ExtCtrls;

type
  Tf_mast_sekolah = class(TForm)
    grp1: TGroupBox;
    Label1: TLabel;
    grp2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    edt_npsp: TEdit;
    edt_nama: TEdit;
    grp3: TGroupBox;
    btn_campur: TBitBtn;
    btn_ubah: TBitBtn;
    btn_simpan: TBitBtn;
    btn_hapus: TBitBtn;
    btn_keluar: TBitBtn;
    grp4: TGroupBox;
    edt_pencarian: TEdit;
    Label6: TLabel;
    grp5: TGroupBox;
    dbgrd1: TDBGrid;
    dblkcbbkec: TDBLookupComboBox;
    edt_kec: TEdit;
    img1: TImage;
    cbb_jenj: TComboBox;
    Label4: TLabel;
    Label7: TLabel;
    edtjumlah_data: TEdit;
    procedure btn_keluarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_campurClick(Sender: TObject);
    procedure edt_npspKeyPress(Sender: TObject; var Key: Char);
    procedure edt_namaKeyPress(Sender: TObject; var Key: Char);
    procedure cbb_jenjClick(Sender: TObject);
    procedure edt_kecKeyPress(Sender: TObject; var Key: Char);
    procedure btn_simpanClick(Sender: TObject);
    procedure dbgrd1DblClick(Sender: TObject);
    procedure btn_ubahClick(Sender: TObject);
    procedure btn_hapusClick(Sender: TObject);
    procedure edt_pencarianChange(Sender: TObject);
    procedure dblkcbbkecCloseUp(Sender: TObject);
    procedure cbb_jenjKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure konek;
  end;

var
  f_mast_sekolah: Tf_mast_sekolah;
  status, npsp, nama_sek, kec, jenjang : string;

implementation

uses
  u_dm, ADODB, DB;

{$R *.dfm}

procedure Tf_mast_sekolah.btn_keluarClick(Sender: TObject);
begin
 close;
end;

procedure Tf_mast_sekolah.FormShow(Sender: TObject);
begin
 edt_npsp.Clear;
 edt_nama.Clear;
// cbb_jenj.Text:=''; cbb_jenj.ItemIndex:=-1;
 edt_kec.Clear;
 grp2.Enabled:=False;
 dblkcbbkec.KeyValue:=null;

 btn_campur.Enabled:=True; btn_campur.Caption:='Tambah';
 btn_simpan.Enabled:=false;
 btn_ubah.Enabled:=false;
 btn_hapus.Enabled:=false;
 btn_keluar.Enabled:=True;

 dbgrd1.Enabled:=True;
 edt_pencarian.Clear; edt_pencarian.Enabled:=True;

 konek;
 edtjumlah_data.Text:=IntToStr(dm.qry_sekolah.RecordCount);
 with dm.tbl_kec do
  begin
    Close;
    Open;
  end;
end;

procedure Tf_mast_sekolah.btn_campurClick(Sender: TObject);
begin
 if btn_campur.Caption='Tambah' then
  begin
   edt_npsp.Clear; edt_nama.Clear; edt_kec.Clear; //cbb_jenj.Text:='';
   dblkcbbkec.KeyValue:=null;
   grp2.Enabled:=True;
   edt_npsp.SetFocus;

   btn_campur.Caption:='Batal';
   btn_simpan.Enabled:=True;
   btn_ubah.Enabled:=false;
   btn_hapus.Enabled:=false;
   btn_keluar.Enabled:=false;

   dbgrd1.Enabled:=false;
   edt_pencarian.Clear;
   edt_pencarian.Enabled:=false;
   status:='simpan';
  end
  else
 if btn_campur.Caption='Batal' then FormShow(Sender);
end;

procedure Tf_mast_sekolah.edt_npspKeyPress(Sender: TObject; var Key: Char);
begin
 if not (key in ['0'..'9',#13,#8,#9]) then Key:=#0;
 if Key=#13 then
  begin
    if dm.qry_sekolah.Locate('npsp',edt_npsp.Text,[]) then
     begin
       MessageDlg('No NPSN Sudah ada',mtWarning,[mbOK],0);
       edt_npsp.Clear;
       Exit;
     end
     else edt_nama.SetFocus;
  end;
end;

procedure Tf_mast_sekolah.edt_namaKeyPress(Sender: TObject; var Key: Char);
begin
 if not (key in ['a'..'z','A'..'Z','0'..'9',#13,#32,#8,#9]) then key:=#0;
 if Key=#13 then dblkcbbkec.SetFocus;
end;

procedure Tf_mast_sekolah.cbb_jenjClick(Sender: TObject);
begin
 dblkcbbkec.SetFocus;
end;

procedure Tf_mast_sekolah.edt_kecKeyPress(Sender: TObject; var Key: Char);
begin
 if not (key in ['a'..'z','A'..'Z','0'..'9',#13,#32,#8,#9]) then key:=#0;
 if Key=#13 then btn_simpan.Click;
end;

procedure Tf_mast_sekolah.btn_simpanClick(Sender: TObject);
begin
 if (Trim(edt_npsp.Text)='') or (Trim(edt_nama.Text)='') or (Trim(edt_kec.Text)='') then
    begin
      MessageDlg('Semua Data Wajib Diisi',mtInformation,[mbOK],0);
      if (Trim(edt_npsp.Text)='') then edt_npsp.SetFocus
       else
      if (Trim(edt_nama.Text)='') then edt_nama.SetFocus
       else
      if (Trim(edt_kec.Text)='') then dblkcbbkec.SetFocus;
      Exit;
    end;

  with dm.qry_sekolah do
   begin
     if status='simpan' then
       begin
        if Locate('npsp',edt_npsp.Text,[]) then
         begin
          MessageDlg('NPSN Sudah Ada',mtInformation,[mbOK],0);
          edt_npsp.SetFocus;
          Exit;
         end;

        if Locate('nm_sekolah;kec',VarArrayOf([edt_nama.Text,edt_kec.Text]),[]) then
         begin
          MessageDlg('Data Sekolah Sudah Ada',mtInformation,[mbOK],0);
          edt_nama.SetFocus;
          Exit;
         end;
        Append;
       end
      else
     if status='ubah' then
      begin
        if (edt_npsp.Text=npsp) and (edt_nama.Text=nama_sek) and (edt_kec.Text=kec) then
         begin
           MessageDlg('Data Sudah Disimpan',mtInformation,[mbok],0);
           FormShow(Sender);
           Exit;
         end
         else
         begin
           if edt_npsp.Text<>npsp then
            begin
              if Locate('npsp',edt_npsp.Text,[]) then
               begin
                MessageDlg('NPSN Sudah Ada',mtInformation,[mbOK],0);
                edt_npsp.SetFocus;
                Exit;
               end;
            end
            else
           if (edt_nama.Text<>nama_sek) or (edt_kec.Text<>kec) then
            begin
             if Locate('nm_sekolah;kec',VarArrayOf([edt_nama.Text,edt_kec.Text]),[]) then
               begin
                MessageDlg('Data Sekolah Sudah Ada',mtInformation,[mbOK],0);
                edt_nama.SetFocus;
                Exit;
               end;
            end;
           if Locate('npsp',npsp,[]) then Edit;
         end;
      end;
      FieldByName('npsp').AsString:=edt_npsp.Text;
      FieldByName('nm_sekolah').AsString:=edt_nama.Text;
      FieldByName('jenjang').AsString:='SMA/SMK/MA';
      FieldByName('kec').AsString:=edt_kec.Text;
      Post;
      MessageDlg('Data Sudah Disimpan',mtInformation,[mbok],0);
      FormShow(Sender);
   end;
end;

procedure Tf_mast_sekolah.dbgrd1DblClick(Sender: TObject);
begin
 edt_npsp.Text:= dbgrd1.Fields[0].AsString;
 npsp:=edt_npsp.Text;
 if npsp='' then Exit;

 edt_nama.Text:= dbgrd1.Fields[1].AsString;
 nama_sek:=edt_nama.Text;
 {cbb_jenj.Text:= dbgrd1.Fields[2].AsString;
 jenjang:=cbb_jenj.Text;}
 edt_kec.Text := dbgrd1.Fields[3].AsString;
 kec := edt_kec.Text;
 dblkcbbkec.KeyValue:=dbgrd1.Fields[3].AsString;

 btn_campur.Caption:='Tambah';
 btn_simpan.Enabled:=false;
 btn_ubah.Enabled:=True;
 btn_hapus.Enabled:=True;
 btn_keluar.Enabled:=false;
end;

procedure Tf_mast_sekolah.btn_ubahClick(Sender: TObject);
begin
 status:= 'ubah';
 dbgrd1.Enabled:=False;
 edt_pencarian.Enabled:=false; edt_pencarian.Clear;

 grp2.Enabled:=True; edt_npsp.SetFocus;
 btn_campur.Caption:='Batal';
 btn_simpan.Enabled:=True;
 btn_ubah.Enabled:=False;
 btn_hapus.Enabled:=False;
 btn_keluar.Enabled:=false;
end;

procedure Tf_mast_sekolah.btn_hapusClick(Sender: TObject);
begin
 if MessageDlg('Yakin Data Akan Dihapus?',mtConfirmation,[mbYes,mbNo],0)=mryes then
  begin
    with dm.qry_sekolah do
     begin
       if Locate('npsp',edt_npsp.Text,[]) then Delete;
       FormShow(Sender);
       MessageDlg('Data Sudah Dihapus',mtInformation,[mbOK],0);
     end;
  end;
end;

procedure Tf_mast_sekolah.edt_pencarianChange(Sender: TObject);
begin
 if edt_pencarian.Text='' then konek else
  begin
    with dm.qry_sekolah do
     begin
       DisableControls;
       close;
       SQL.Clear;
       SQL.Text:='select * from tbl_sekolah where npsp like ''%'+edt_pencarian.Text+'%'' or nm_sekolah like ''%'+edt_pencarian.Text+'%''';
       Open;
       EnableControls;
     end;
  end;
end;

procedure Tf_mast_sekolah.konek;
begin
with dm.qry_sekolah do
  begin
    DisableControls;
    Close;
    SQL.Clear;
    SQL.Text:='select * from tbl_sekolah';
    Open;
    EnableControls;
  end;
end;

procedure Tf_mast_sekolah.dblkcbbkecCloseUp(Sender: TObject);
begin
 if dblkcbbkec.KeyValue=null then Exit else
  begin
    edt_kec.Text:=dblkcbbkec.KeyValue;
  end;
end;

procedure Tf_mast_sekolah.cbb_jenjKeyPress(Sender: TObject; var Key: Char);
begin
 Key:=#0;
end;

end.
