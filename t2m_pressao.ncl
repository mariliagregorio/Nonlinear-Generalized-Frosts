begin

dia = "Dia -6"
diaarq = "dia-6"
dp = "0dp"
dptitulo = "0DP"
dppwd = "0dp"


dirip = "/media/marilia/DADOS/Marilia/doutorado/termos_eq_rws/arq_termos/0dp/pressao/"
dirit = "/media/marilia/DADOS/Marilia/doutorado/termos_eq_rws/arq_termos/0dp/t2m/"
diro = "/media/marilia/DADOS/Marilia/doutorado/termos_eq_rws/arq_termos/0dp/figs/t2m_pressao/" 

fili = "0dp_dailymean_" + diaarq + "_mslp_era5.nc"
fili2 = "0dp_anom_" + diaarq + "_t2m_era5.nc"
;fili3 = "student_pressao_" + diaarq + "_" + dp + ".nc"

f = addfile (dirip+fili, "r")
;x = f->slp(0,{-70:10},{-115:-30})
x = f->slp(0,:,:)
x = x/100

; (time,lat,lon) ==> (29,60,180)
g = addfile (dirit+fili2, "r")
y = g->t2m(0,{-70:10},{-115:-30})

;h = addfile (diri+fili3, "r")
;z = h->msl(0,{-70:10},{-115:-30})


wks = gsn_open_wks("png", diro + "0dp_pressao_anomt2m_" + diaarq)


; send graphics to PNG file
res = True
res@gsnMaximize = True
res@gsnDraw = False
res@gsnFrame = False
res@gsnAddCyclic = False
res@cnLinesOn = True
res@mpMaxLatF = 10.
res@mpMinLatF = -70.
res@mpMinLonF = -115.
res@mpMaxLonF = -30.
;res@mpCenterLonF = 180.
res@gsnContourZeroLineThicknessF = 0
res@cnLineLabelsOn = True
res@cnInfoLabelOn = True
res@cnLineThicknessF = 2.0
res@cnInfoLabelOn = False
res@cnLevelSelectionMode = "ManualLevels"
res@gsnLeftString = ""
res@gsnRightString = ""
res@gsnRightStringFontHeightF = 0.010
res@tmXBLabelsOn = False
;res@cnMinLevelValF = -3
;res@cnMaxLevelValF = 3
;res@cnLevelSpacingF = 0.5
res@gsnContourNegLineDashPattern = 1
res@cnLinesOn = True
res1 = True
res1@gsnMaximize = True
res1@mpMaxLatF = 10.
res1@mpMinLatF = -70.
res1@mpMinLonF = -115.
res1@mpMaxLonF = -30.
;res1@mpCenterLonF = 180.
res1@cnFillPalette = "BlueWhiteOrangeRed"
res1@cnFillOn = True
res1@cnLinesOn = False
res1@cnLineLabelsOn = False
res1@cnRasterSmoothingOn = True
res1@cnFillMode = "RasterFill"
res1@gsnAddCyclic = False
res1@trGridType = "TriangularMesh"
res1@tmYLPrecision = 2
res1@tiMainString = "Temperature Anomaly at 2m and MSLP - " + dptitulo + " - " + dia
 res1@tmXBLabelFontHeightF = 0.01  ; Diminui o tamanho dos labels do eixo X
   res1@tmYLLabelFontHeightF = 0.01  ; Diminui o tamanho dos labels do eixo Y
   res1@lbHeightF = 0.01                      ; Define a altura da barra de cores
   res1@lbWidthF = 0.06                       ; Define a largura da barra de cores
   res1@tmXBMinorOn = False    ; Remove tickmarks pequenos no eixo X
   res1@tmYLMinorOn = False    ; Remove tickmarks pequenos no eixo Y
   res1@tmXTOn = False    ; Desativa os tickmarks no topo (eixo X superior)
   res1@tmYROn = False    ; Desativa os tickmarks à direita (eixo Y direito)
   res1@tmXBOn = True     ; Ativa os tickmarks embaixo (eixo X inferior)
   res1@tmYLOn = True     ; Ativa os tickmarks à esquerda (eixo Y esquerdo)
res1@tiMainFontHeightF = 0.015
res1@gsnRightString = ""
res1@gsnLeftString = ""
res1@gsnStringFontHeightF = 0.005
res1@cnLevelSelectionMode = "ManualLevels"
res1@cnMinLevelValF = -16
res1@cnMaxLevelValF = 16
res1@cnLevelSpacingF = 2

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
plot = gsn_csm_contour(wks, x, res)
plot1 = gsn_csm_contour_map_ce(wks, y, res1)
;plot2 = gsn_csm_contour(wks, z, res2)
;plot2 = ColorNegDashZeroPosContour(plot2,"transparent","black","black")
  
;iplot_stipple = plot1
;iplot_stipple = gsn_contour_shade(iplot_stipple,0, 0.8, opt)

overlay(plot1, plot)
;overlay(plot1, iplot_stipple)
  
draw(plot1)
frame(wks)

end
