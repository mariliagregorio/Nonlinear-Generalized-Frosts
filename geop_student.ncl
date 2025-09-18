begin
lat1 = -80.0
lat2 = 10.0
lon1 = 0.0
lon2 = 330.0

dia = "Day 2"
diaarq = "dia2"
dp = "0dp" ; 0dp 1dp 2dpm
dppwd = "0dp"
dptitulo = "0 DP"

diri = "/media/marilia/DADOS/Marilia/doutorado/termos_eq_rws/arq_termos/anom/"
diro = "/media/marilia/DADOS/Marilia/doutorado/termos_eq_rws/arq_termos/0dp/figs/geop/anom/200hpa/" 


;fili = "fonte_mediafinal_" + diaarq + "_" + dp + ".nc"
fili2 = "anom_geop200_" + diaarq + "_" + dp + "_cdc.nc"
filis = "student_anom_geop200_" + diaarq + "_" + dp + "_cdc.nc"



f = addfile (diri+fili2, "r")
x = f->hgt(0,:,:); (time,lat,lon) ==> (29,60,180)
;g = addfile (diri+fili, "r")
;y = g->fonte(0,:,:)
;y = y*1e10

h = addfile(diri+filis, "r")
z = h->hgt(0,:,:)

wks = gsn_open_wks("png",diro + "student_anom_geop200_" + diaarq)
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
res@cnInfoLabelOrthogonalPosF = -0.98   ; Posição vertical → mais próximo da parte inferior
res@cnInfoLabelParallelPosF   = 0.99   ; Posição horizontal → mais próximo da direita
res@cnInfoLabelFontHeightF = 0.008
;res@cnLevelSelectionMode = "AutomaticLevels"
;res@gsnLeftString = ""
;res@cnMinLevelValF = -120
;res@cnMaxLevelValF = 120
;res@cnLevelSpacingF = 10

  res@cnLevelSelectionMode = "ManualLevels"  ; Define níveis explicitamente
  ;res@cnLevels = (/ -160, -140, -120, -100, -80, -60, -40, -20, 20, 40, 60, 80, 100, 120, 140, 160 /)  ; Exemplos de valores
  res@cnMinLevelValF = -160
  res@cnMaxLevelValF = 160
  res@cnLevelSpacingF = 20
res@gsnContourZeroLineThicknessF = 0
res@gsnContourNegLineDashPattern = 1
res@cnLinesOn = True
res@lbLabelBarOn = False
res@mpOutlineBoundarySets     = "NoBoundaries"     
res@mpOutlineSpecifiers      = (/"Continents"/)  ; continents only
;res@cnFillOn = False
res@cnInfoLabelOn = True
res@cnLineLabelsOn = False
res@mpFillOn = False
   res@tmYROn = False
   res@tmXTOn = False
   res@tmXBLabelFontHeightF = 0.012
   ;res@gsnStringFontHeightF = 0.02
   res@mpNationalLineThicknessF = 3.0 
   res@cnLineLabelFontHeightF = 0.006
  res@tmXBLabelFontHeightF = 0.01  ; Diminui o tamanho dos labels do eixo X
  res@tmYLLabelFontHeightF = 0.01  ; Diminui o tamanho dos labels do eixo Y
;res1@lbHeightF = 0.01                      ; Define a altura da barra de cores
;res1@lbWidthF = 0.06                       ; Define a largura da barra de cores
  res@tmXBMinorOn = False    ; Remove tickmarks pequenos no eixo X
  res@tmYLMinorOn = False    ; Remove tickmarks pequenos no eixo Y
  res@tiMainString = "Meridional Wind Anomaly at 200 hPa - " + dptitulo + " - " + dia
res@tiMainFontHeightF = 0.015   ; Define o tamanho da fonte do título
res@tiMainOffsetYF = -0.02  ; Move o título para mais perto da figura
   res@pmTickMarkDisplayMode = "Always"
res@tiMainFontHeightF = 0.015
res@gsnRightString = ""
res@gsnLeftString = ""
res@gsnStringFontHeightF = 0.005

;res1 = True
;res1@gsnMaximize = True
;res1@mpMaxLatF = 15.
;res1@mpMinLatF = -80.
;res1@mpMinLonF = 0.
;res1@mpMaxLonF = 330.
;res1@mpCenterLonF = 180.
;res1@cnFillPalette = "precip_diff_12lev"
;res1@cnFillOn = False
;res1@cnLinesOn = False
;res1@cnLineLabelsOn = False
;res1@cnRasterSmoothingOn = True
;res1@cnFillMode = "RasterFill"
;res1@gsnAddCyclic = False
;res1@trGridType = "TriangularMesh"
;res1@tmYLPrecision = 2
res@tiMainString = "Geopotential Anomaly at 200 hPa - " + dptitulo + " - " + dia
res@tiMainFontHeightF = 0.015   ; Define o tamanho da fonte do título
res@tiMainOffsetYF = -0.02  ; Move o título para mais perto da figura
;res@gsnRightString = ""
;res@gsnLeftString = ""
;res@cnLevelSelectionMode = "ManualLevels"
;res@cnMinLevelValF = -14
;res@cnMaxLevelValF = 14
;res@cnLevelSpacingF = 2

res2                 = True
;res2@gsnMaximize    = True       ; maximize in frame
res2@cnLinesOn       = False
;res2@cnFillOn        = False
res2@cnFillPalette   = "gsltod"   ; change the color palette
res2@cnMinLevelValF  = 10
res2@cnMaxLevelValF  = 10
res2@cnLevelSpacingF = 0.1
res2@cnFillOpacityF  = 0.1
res2@gsnRightString  = " "
res2@gsnLeftString   = " "
res2@cnInfoLabelOn = False
res2@cnLineLabelsOn = False
res2@mpFillOn = False
   res2@tmYROn = False
   res2@tmXTOn = False
   res2@tmXBLabelFontHeightF = 0.012
   ;res@gsnStringFontHeightF = 0.02
   res2@mpNationalLineThicknessF = 3.0 
   res2@cnLineLabelFontHeightF = 0.006
  res2@tmXBLabelFontHeightF = 0.01  ; Diminui o tamanho dos labels do eixo X
  res2@tmYLLabelFontHeightF = 0.01  ; Diminui o tamanho dos labels do eixo Y
    res2@tmXBMinorOn = False    ; Remove tickmarks pequenos no eixo X
  res2@tmYLMinorOn = False    ; Remove tickmarks pequenos no eixo Y


opt = True
opt@gsnShadeHigh         = 1          ; stipple
opt@gsnShadeFillScaleF   = 0.1         ; add extra density
opt@gsnShadeFillDotSizeF = 0.002      ; make dots larger
  

;plot = gsn_csm_contour(wks, x, res)
plot1 = gsn_csm_contour_map(wks, x, res)
plot2 = gsn_csm_contour(wks, z, res2)
;plot2 = ColorNegDashZeroPosContour(plot2,"transparent","black","black")
  
iplot_stipple = plot2
iplot_stipple = gsn_contour_shade(iplot_stipple,0, 0.8, opt)

;overlay(plot1, plot2)
overlay(plot1, iplot_stipple)
  
draw(plot1)
frame(wks)

;plot = gsn_csm_contour(wks,x,res)
;plot1 = gsn_csm_contour_map_ce(wks,y,res1)
;overlay(plot1,plot)
;draw(plot1)
;frame(wks)

end
