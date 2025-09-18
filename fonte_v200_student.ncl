begin
lName = (/"Rossby wave source"/)

dia = "Day 0"
diaarq = "dia0"
dp = "0dp" ; 0dp 1dp 2dpm
dppwd = "0dp"
dptitulo = "0DP"

diri = "/media/marilia/DADOS/Marilia/doutorado/ncl/ncl2/fonte/"
diro = "/media/marilia/DADOS/Marilia/doutorado/zip/figs_tstudent/" + dppwd + "/" 

filif = "fonte_mediafinal_" + diaarq + "_" + dp + ".nc"
filiv = "anom_v200_" + diaarq + "_" + dp + ".nc"
filis = "student_anom_v200_" + diaarq + "_" + dp + ".nc"



f1 = addfile(diri+filif, "r")
f2 = addfile(diri+filiv, "r")
f3 = addfile(diri+filis, "r")

v1 = f1->fonte(0,:,:)
v1 = v1*1e10
v2 = f2->v(0,:,:)
wks_type = "png"
wks_type@wkWidth = 2500
wks_type@wkHeight = 2500
wks = gsn_open_wks(wks_type, diro + "student_" + dp + "fonte_anom_v200_" + diaarq)
res = True
res@gsnMaximize = True
res@gsnDraw = False
res@gsnFrame = False
res@gsnAddCyclic = False
res@gsnContourZeroLineThicknessF = 0.
res@tmXBLabelFontHeightF = 0.012
res@gsnStringFontHeightF = 0.02
res@cnFillOn = True
res@cnLineLabelsOn = False
res@cnFillPalette = "precip_diff_12lev"
res@cnLevelSelectionMode = "ManualLevels"
res@lbLabelBarOn = False
res@lbBoxEndCapStyle = "TriangleBothEnds"
res@tmYROn = False
res@tmXTOn = False
res1 = True
res1@gsnMaximize = True
res1@gsnDraw = False
res1@gsnFrame = False
res1@gsnAddCyclic = False
res1@cnLinesOn = True
res1@mpMaxLatF = 10.
res1@mpMinLatF = -80.
res1@mpMinLonF = 0.
res1@mpMaxLonF = 330.
res1@mpCenterLonF = 180.
res1@gsnContourZeroLineThicknessF = 0
res1@cnLineLabelsOn = True
res1@cnInfoLabelOn = True
res1@cnLineThicknessF = 2.0
res1@cnInfoLabelOn = False
res1@cnLevelSelectionMode = "ManualLevels"
res1@gsnLeftString = ""
res1@cnMinLevelValF = -10
res1@cnMaxLevelValF = 10
res1@cnLevelSpacingF = 2
res1@gsnContourNegLineDashPattern = 1
res1@cnLinesOn = True
res@mpMaxLatF = 10.
res@mpMinLatF = -80.
res@mpMinLonF = 0.
res@mpMaxLonF = 330.
res@mpCenterLonF = 180.
res@mpFillOn = False
res@mpNationalLineThicknessF = 3.0
;res@pmTickMarkDisplayMode = "Always"
res@pmLabelBarOrthogonalPosF = .12
res@lbLabelBarOn = True
res@cnMinLevelValF = -14
res@cnMaxLevelValF = 14
res@cnLevelSpacingF = 2
res1@gsnRightString = " "
res1@gsnLeftString = " "
res1@tiMainString = "Rossby Wave Source and Meridional Wind Anomaly at 200 hPa - " + dptitulo
res@tmXBLabelFontHeightF = 0.01  ; Diminui o tamanho dos labels do eixo X
res@tmYLLabelFontHeightF = 0.01  ; Diminui o tamanho dos labels do eixo Y
res@lbHeightF = 0.01                      ; Define a altura da barra de cores
res@lbWidthF = 0.06                       ; Define a largura da barra de cores
res@tmXBMinorOn = False    ; Remove tickmarks pequenos no eixo X
res@tmYLMinorOn = False    ; Remove tickmarks pequenos no eixo Y
res@tmXTOn = False    ; Desativa os tickmarks no topo (eixo X superior)
res@tmYROn = False    ; Desativa os tickmarks à direita (eixo Y direito)
res@tmXBOn = True     ; Ativa os tickmarks embaixo (eixo X inferior)
res@tmYLOn = True     ; Ativa os tickmarks à esquerda (eixo Y esquerdo)
;plot = gsn_csm_contour_map(wks,v1,res1)
plot = gsn_csm_contour_map_ce(wks,v2,res1)
plot1 = gsn_csm_contour(wks,v2,res1)
;overlay(plot,plot1)
draw(plot)
frame(wks)
end
