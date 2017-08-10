program app_sekolah_sehat_wp;

uses
  Forms,
  u_menuutama in 'u_menuutama.pas' {f_menu},
  u_dm in 'u_dm.pas' {dm: TDataModule},
  u_mast_sekolah in 'u_mast_sekolah.pas' {f_mast_sekolah},
  u_mast_bobot in 'u_mast_bobot.pas' {f_mast_bobot},
  u_trans_indikator in 'u_trans_indikator.pas' {f_trans_indikator},
  u_bantu_kriteria in 'u_bantu_kriteria.pas' {f_bantu_kriteria},
  u_trans_penilaian in 'u_trans_penilaian.pas' {f_trans_nilai_sekolah},
  u_bantu_sekolah in 'u_bantu_sekolah.pas' {f_bantu_sekolah},
  u_trans_proseswp in 'u_trans_proseswp.pas' {f_trans_proseswp},
  u_peng_ganti_sandi in 'u_peng_ganti_sandi.pas' {f_peng_gantisandi},
  u_peng_salindata in 'u_peng_salindata.pas' {f_peng_salindata},
  u_report_sekolah in 'u_report_sekolah.pas' {report_sekolah: TQuickRep},
  u_peng_jawab in 'u_peng_jawab.pas' {f_peng_jawab},
  u_lap_perangkingan in 'u_lap_perangkingan.pas' {f_lap_rangking},
  u_report_rang in 'u_report_rang.pas' {report_rangking: TQuickRep},
  u_lap_nilai_sekolah in 'u_lap_nilai_sekolah.pas' {f_lap_nilai_sekolah},
  u_bantu_sekolah2 in 'u_bantu_sekolah2.pas' {f_bantu_sekolah2},
  u_report_nilai_sekolah in 'u_report_nilai_sekolah.pas' {report_nilai_sekolah: TQuickRep},
  u_report_indikator_nilai in 'u_report_indikator_nilai.pas' {repor_indikator_nilai: TQuickRep},
  u_login in 'u_login.pas' {f_login},
  u_report_nilai_sekolah2 in 'u_report_nilai_sekolah2.pas' {report_nilai_sekolah2: TQuickRep};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(Tf_login, f_login);
  Application.CreateForm(Tf_menu, f_menu);
  Application.CreateForm(Tf_mast_sekolah, f_mast_sekolah);
  Application.CreateForm(Tf_mast_bobot, f_mast_bobot);
  Application.CreateForm(Tf_trans_indikator, f_trans_indikator);
  Application.CreateForm(Tf_bantu_kriteria, f_bantu_kriteria);
  Application.CreateForm(Tf_trans_nilai_sekolah, f_trans_nilai_sekolah);
  Application.CreateForm(Tf_bantu_sekolah, f_bantu_sekolah);
  Application.CreateForm(Tf_trans_proseswp, f_trans_proseswp);
  Application.CreateForm(Tf_peng_gantisandi, f_peng_gantisandi);
  Application.CreateForm(Tf_peng_salindata, f_peng_salindata);
  Application.CreateForm(Treport_sekolah, report_sekolah);
  Application.CreateForm(Tf_peng_jawab, f_peng_jawab);
  Application.CreateForm(Tf_lap_rangking, f_lap_rangking);
  Application.CreateForm(Treport_rangking, report_rangking);
  Application.CreateForm(Tf_lap_nilai_sekolah, f_lap_nilai_sekolah);
  Application.CreateForm(Tf_bantu_sekolah2, f_bantu_sekolah2);
  Application.CreateForm(Treport_nilai_sekolah, report_nilai_sekolah);
  Application.CreateForm(Trepor_indikator_nilai, repor_indikator_nilai);
  Application.CreateForm(Treport_nilai_sekolah2, report_nilai_sekolah2);
  Application.Run;
end.
