unit u_report_nilai_sekolah2;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, ADODB, jpeg;

type
  Treport_nilai_sekolah2 = class(TQuickRep)
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
    qrlbl5: TQRLabel;
    qrlbl13: TQRLabel;
    qrlbl15: TQRLabel;
    qrlbl17: TQRLabel;
    QRShape4: TQRShape;
    QRImage2: TQRImage;
    QRGroup2: TQRGroup;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    qrlbl7: TQRLabel;
    qrlbl6: TQRLabel;
    qrlbl19: TQRLabel;
    qrlbl20: TQRLabel;
    qrlbl21: TQRLabel;
    qrlbl22: TQRLabel;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    qrlbl23: TQRLabel;
    qrlbl24: TQRLabel;
    QRDBText10: TQRDBText;
    qrlbl25: TQRLabel;
    qrlbl26: TQRLabel;
    QRDBText11: TQRDBText;
    qrlbl27: TQRLabel;
    qrbnd1: TQRBand;
    QRShape10: TQRShape;
    qrbndSummaryBand1: TQRBand;
    qrlbl10: TQRLabel;
    qrlbl_bln: TQRLabel;
    qrlbl11: TQRLabel;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    qrlbl12: TQRLabel;
    qry_laporan_nilai: TADOQuery;
  private

  public

  end;

var
  report_nilai_sekolah2: Treport_nilai_sekolah2;

implementation

uses
  u_dm;

{$R *.DFM}

end.
