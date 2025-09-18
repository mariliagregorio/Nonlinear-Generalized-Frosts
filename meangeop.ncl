begin

dia = "Dia 2"
diaarq = "dia2"
dp = "0dp"
dptitulo = "0DP"
dppwd = "0dp"


dirip = "/media/marilia/DADOS/Marilia/doutorado/termos_eq_rws/arq_termos/0dp/geop/"
diro = "/media/marilia/DADOS/Marilia/doutorado/termos_eq_rws/arq_termos/0dp/figs/geop/mean" 

fili = "0dp_dailymean_" + diaarq + "_geop850_era5.nc"

f = addfile (dirip+fili, "r")
;x = f->slp(0,{-70:10},{-115:-30})
x = f->hgt(0,0,{-80:10},{0:330})
;x = x/100

wks = gsn_open_wks("png", diro + "0dp_mean_geop850_" + diaarq)


; send graphics to PNG file
res = True
res@gsnMaximize = True
res@gsnDraw = False
res@gsnFrame = False
res@gsnAddCyclic = False
res@cnLinesOn = True
res@mpMaxLatF = 10.
res@mpMinLatF = -80.
res@mpMinLonF = 0.
res@mpMaxLonF = 330.
res@mpCenterLonF = 180.
res@gsnContourZeroLineThicknessF = 0
res@cnLineLabelsOn = True
res@cnInfoLabelOn = True
res@cnLineThicknessF = 2.0
res@cnInfoLabelOn = False
res@cnLevelSelectionMode = "ManualLevels"
res@gsnLeftString = ""
res@gsnRightString = ""
res@gsnRightStringFontHeightF = 0.010
res@tmXBLabelsOn = True
;res@cnMinLevelValF = -3
;res@cnMaxLevelValF = 3
;res@cnLevelSpacingF = 0.5
res@gsnContourNegLineDashPattern = 1
res@cnLinesOn = True
res@tiMainString = "Mean value of geopotential height at 850 hPa - " + dptitulo + " - " + dia
   res@tiMainFontHeightF = 0.015   ; Define o tamanho da fonte do título
   res@tiMainOffsetYF = -0.02  ; Move o título para mais perto da figura
res@tmXBLabelFontHeightF = 0.01  ; Diminui o tamanho dos labels do eixo X
   res@tmYLLabelFontHeightF = 0.01  ; Diminui o tamanho dos labels do eixo Y
   res@tmXBMinorOn = True    ; Remove tickmarks pequenos no eixo X
   res@tmYLMinorOn = True    ; Remove tickmarks pequenos no eixo Y
   res@tmXTOn = False    ; Desativa os tickmarks no topo (eixo X superior)
   res@tmYROn = False    ; Desativa os tickmarks à direita (eixo Y direito)
   ;res@tmXBOn = True     ; Ativa os tickmarks embaixo (eixo X inferior)
   ;res@tmYLOn = True     ; Ativa os tickmarks à esquerda (eixo Y esquerdo)
   res@pmTickMarkDisplayMode = "Always"
res@tiMainFontHeightF = 0.015
res@gsnRightString = ""
res@gsnLeftString = ""
res@gsnStringFontHeightF = 0.005
res@cnLevelSelectionMode = "ManualLevels"
res@cnMinLevelValF = 1200
res@cnMaxLevelValF = 1500
res@cnLevelSpacingF = 50

; para plotar o teste t-student. Aqui nao deu certo!
res2                 = True
;res2@gsnMaximize     = True       ; maximize in frame
res2@cnLinesOn       = False
res2@cnFillOn        = True
res2@cnFillPalette   = "gsltod"   ; change the color palette
res2@cnMinLevelValF      = 10
res2@cnMaxLevelValF      = 10
res2@cnLevelSpacingF     = 0.1
res2@cnFillOpacityF = 0.1
res2@gsnRightString      = " "
res2@gsnLeftString       = " "

opt = True
opt@gsnShadeHigh         = 1          ; stipple
opt@gsnShadeFillScaleF   = 0.1         ; add extra density
opt@gsnShadeFillDotSizeF = 0.002      ; make dots larger

; aqui plota sem o teste t-student
;plot = gsn_csm_contour(wks,x,res)
;plot1 = gsn_csm_contour_map_ce(wks,y,res1)
;overlay(plot1,plot)
;draw(plot1)
;frame(wks)

;aqui plota com o teste t-student. mas nao deu certo para essas variaveis
plot = gsn_csm_contour_map_ce(wks, x, res)
;plot1 = gsn_csm_contour_map_ce(wks, y, res1)
;plot2 = gsn_csm_contour(wks, z, res2)
;plot2 = ColorNegDashZeroPosContour(plot2,"transparent","black","black")
  
;iplot_stipple = plot1
;iplot_stipple = gsn_contour_shade(iplot_stipple,0, 0.8, opt)

;overlay(plot1, plot)
;overlay(plot1, iplot_stipple)
  
draw(plot)
frame(wks)

end
