unit u_report_nilai_sekolah;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, jpeg, DB, ADODB;

type
  Treport_nilai_sekolah = class(TQuickRep)
    qrbndDetailBand1: TQRBand;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    qrbndTitleBand1: TQRBand;
    qrlbl1: TQRLabel;
    qrlbl2: TQRLabel;
    qrlbl3: TQRLabel;
    qrlbl4: TQRLabel;
    QRImage1: TQRImage;
    QRShape1: TQRShape;
    qry_laporan_nilai: TADOQuery;
    QRGroup2: TQRGroup;
    qrlbl19: TQRLabel;
    qrlbl20: TQRLabel;
    qrlbl21: TQRLabel;
    qrlbl22: TQRLabel;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    qrlbl23: TQRLabel;
    qrlbl24: TQRLabel;
    QRDBText10: TQRDBText;
    qrlbl27: TQRLabel;
    qrlbl5: TQRLabel;
    qrlbl13: TQRLabel;
    qrlbl15: TQRLabel;
    qrlbl17: TQRLabel;
    QRShape4: TQRShape;
    qrbnd1: TQRBand;
    qrbndSummaryBand1: TQRBand;
    qrlbl10: TQRLabel;
    qrlbl_bln: TQRLabel;
    qrlbl11: TQRLabel;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    qrlbl12: TQRLabel;
    QRShape10: TQRShape;
    QRImage2: TQRImage;
    QRGroup1: TQRGroup;
    QRDBText3: TQRDBText;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    qrlbl6: TQRLabel;
    qrlbl7: TQRLabel;
    QRShape5: TQRShape;
    qrlbl14: TQRLabel;
    qrlbl9: TQRLabel;
    qrlbl16: TQRLabel;
    procedure qrbnd1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrbndDetailBand1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRGroup1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRGroup2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    total,nom : Integer;
  public

  end;

var
  report_nilai_sekolah: Treport_nilai_sekolah;

implementation

uses
  u_dm;

{$R *.DFM}

procedure Treport_nilai_sekolah.qrbnd1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
 qrlbl9.Caption:=IntToStr(total);
end;

procedure Treport_nilai_sekolah.qrbndDetailBand1AfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
total := total + qry_laporan_nilai.fieldbyname('nil_indi').AsInteger;
end;

procedure Treport_nilai_sekolah.QRGroup1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
 total:=0;
 nom:=nom+1;
 qrlbl16.Caption:=IntToStr(nom)+'.';
end;

procedure Treport_nilai_sekolah.QuickRepBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
 nom:=1;
end;

procedure Treport_nilai_sekolah.QRGroup2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
 nom:=0;
end;

end.
