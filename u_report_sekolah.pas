unit u_report_sekolah;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, jpeg;

type
  Treport_sekolah = class(TQuickRep)
    qrbndDetailBand1: TQRBand;
    qrbndColumnHeaderBand1: TQRBand;
    qrbndSummaryBand1: TQRBand;
    qrlbl5: TQRLabel;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape5: TQRShape;
    qrlbl6: TQRLabel;
    qrlbl7: TQRLabel;
    qrlbl9: TQRLabel;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRShape9: TQRShape;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText4: TQRDBText;
    QRShape10: TQRShape;
    qrlbl10: TQRLabel;
    qrlbl_bln: TQRLabel;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    qrlbl12: TQRLabel;
    qrbnd1: TQRBand;
    QRShape11: TQRShape;
    QRImage2: TQRImage;
    qrlbl13: TQRLabel;
    qrlbl14: TQRLabel;
    qrlbl15: TQRLabel;
    qrlbl16: TQRLabel;
    QRImage3: TQRImage;
    qrlbl11: TQRLabel;
  private

  public

  end;

var
  report_sekolah: Treport_sekolah;

implementation

uses
  u_dm;

{$R *.DFM}

end.
