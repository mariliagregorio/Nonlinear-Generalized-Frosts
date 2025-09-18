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
diro = "/media/marilia/DADOS/Marilia/doutorado/termos_eq_rws/arq_termos/0dp/figs/u200_vvento/" 


;fili = "fonte_mediafinal_" + diaarq + "_" + dp + ".nc"
fili2 = "anom_u200_" + diaarq + "_" + dp + ".nc"
filiv = "anom_v200_" + diaarq + "_" + dp + ".nc"
filis = "student_anom_u200_" + diaarq + "_" + dp + ".nc"



f = addfile (diri+fili2, "r")
x = f->u(0,:,:); (time,lat,lon) ==> (29,60,180)
g = addfile (diri+filiv, "r")
y = g->v(0,:,:)
h = addfile(diri+filis, "r")
z = h->u(0,:,:)

wks = gsn_open_wks("png",diro + "student_anom_u200_vvento_" + diaarq)

  ; Configurações de mapa
  res = True
  res@gsnMaximize = True
  res@gsnDraw     = False
  res@gsnFrame    = False
  res@gsnAddCyclic = False
  res@mpMinLatF = -80.
  res@mpMaxLatF = 10.
  res@mpMinLonF = 0.
  res@mpMaxLonF = 330.
  res@mpCenterLonF = 180.
  res@mpOutlineOn = True
  res@mpFillOn    = False             ; <- sem preenchimento nos continentes
  res@mpGeophysicalLineColor = "grey"
  res@mpGeophysicalLineThicknessF = 2.5
  res@gsnRightString  = " "
  res@gsnLeftString   = " "
  res@tiMainFontHeightF = 0.015   ; Define o tamanho da fonte do título
  res@tiMainOffsetYF = -0.014  ; Move o título para mais perto da figura
  res@pmTickMarkDisplayMode = "Always"
  res@tiMainFontHeightF = 0.015
  res@gsnRightString = ""
  res@gsnLeftString = ""
  res@gsnStringFontHeightF = 0.005
  res@tiMainString = "Anomaly of zonal and vector wind at 200 hPa - " + dptitulo + " - " + dia
  res@mpGeophysicalLineColor = "grey62"  ; ou qualquer cor válida
  res@mpNationalLineColor   = "grey62"
  res@mpGeophysicalLineThicknessF = 5.0
  res@mpMaxLatF = 10.
  res@mpMinLatF = -70.
  res@mpMinLonF = -115.
  res@mpMaxLonF = -30.   
  ;resv@mpCenterLonF = 180.

  ; Contornos e preenchimento colorido
  res@cnFillOn = True
  res@cnLinesOn = False               ; <- remove linhas de contorno
  res@cnLineLabelsOn = False          ; <- remove valores nas linhas

  ; Níveis e paleta personalizada
  res@cnLevelSelectionMode = "ManualLevels"
  res@cnMinLevelValF = -18
  res@cnMaxLevelValF = 18
  res@cnLevelSpacingF = 2

  ; Paleta manual azul-branco-vermelho
  res@cnFillPalette = "precip_diff_12lev"
  res@mpNationalLineColor   = "LightGrey"
  res@lbLabelFontHeightF = 0.01   ; diminui o tamanho da fonte

   resv = True
   
;--- Vector resources
   resv@gsnLeftString = ""
   resv@vcRefAnnoOn = False
   resv@vcRefAnnoOrthogonalPosF = -1.0   ; move ref vector up
   resv@vcRefMagnitudeF         = 6.0
   resv@vcRefLengthF            = 0.045
   resv@vcGlyphStyle            = "CurlyVector"  
   resv@vcMinDistanceF          = 0.015
   resv@tmYROn       = False
   resv@tmXTOn       = False      

;--- Map resources
   resv@mpNationalLineThicknessF = 3.0 
   resv@pmTickMarkDisplayMode = "Always"
   resv@pmLabelBarOrthogonalPosF = .12
   resv@mpMaxLatF = 10.
   resv@mpMinLatF = -70.
   resv@mpMinLonF = -115.
   resv@mpMaxLonF = -30.   
   resv@mpCenterLonF = 180.
   resv@tmYROn = False
   resv@tmXTOn = False
   resv@mpFillOn = False
   resv@tiMainFontHeightF = 0.015   ; Define o tamanho da fonte do título
   resv@tiMainOffsetYF = -0.015  ; Move o título para mais perto da figura
   resv@pmTickMarkDisplayMode = "Always"
   resv@tiMainFontHeightF = 0.015
   resv@gsnRightString = ""
   resv@gsnLeftString = ""
   resv@gsnStringFontHeightF = 0.005
   resv@tiMainString = "Anomaly of zonal and vector wind at 200 hPa - " + dptitulo + " - " + dia
   resv@mpGeophysicalLineColor = "grey62"  ; ou qualquer cor válida
   resv@mpNationalLineColor   = "grey62"
   resv@mpGeophysicalLineThicknessF = 5.0
   
   ;--- vetor na figura
   resv@vcRefAnnoOn = True                    ; Ativa a legenda do vetor
   resv@vcRefAnnoString1 = "10"            ; Define o rótulo da legenda
   resv@vcRefAnnoFontHeightF = 0.008           ; Ajusta o tamanho do texto da legenda
   resv@vcRefMagnitudeF         = 10.0
   resv@vcRefLengthF            = 0.025
   resv@vcRefAnnoOrthogonalPosF = -1.36          ; Move a legenda para o topo
   ;resv@vcRefAnnoParallelPosF = 0.5           ; Move a legenda mais para a esquerda (ajuste conforme necessário)
   resv@vcLineArrowColor = "black"
   resv@vcRefAnnoOn     = True     ; garante que a seta apareça
   resv@vcRefAnnoString1 = "10 m/s" ; texto que será exibido junto à seta
   resv@vcRefAnnoString2On = False

; ================================
; Somente para o teste t student
; ================================
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

; ================================
; Somente para o teste t student
; ================================

; -----Plot final
  
plot1 = gsn_csm_vector(wks,x, y, resv)
plot = gsn_csm_contour_map(wks, x, res)
overlay(plot, plot1)
draw(plot)
frame(wks)

;=============================================
;plot = gsn_csm_contour(wks, x, res)
;plot1 = gsn_csm_contour_map(wks, x, res)
;plot2 = gsn_csm_contour(wks, z, res2)
;plot2 = ColorNegDashZeroPosContour(plot2,"transparent","black","black")
  
;iplot_stipple = plot2
;iplot_stipple = gsn_contour_shade(iplot_stipple,0, 0.8, opt)

;overlay(plot1, plot2)
;overlay(plot1, iplot_stipple)
  
;draw(plot1)
;frame(wks)

;plot = gsn_csm_contour(wks,x,res)
;plot1 = gsn_csm_contour_map_ce(wks,y,res1)
;overlay(plot1,plot)
;draw(plot1)
;frame(wks)
;=============================================

end
