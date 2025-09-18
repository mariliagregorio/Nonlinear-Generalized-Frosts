begin
; Defina as variáveis "dp" e "dia"

dia = "dia2"
diatitulo = "Day 2"
dptitulo = "0 DP"


; Defina as latitudes e longitudes
lat1 = -80.0
lat2 = 10.0
lon1 = 0.0
lon2 = 330.0

; Caminho e nomes de arquivos, incorporando as variáveis "dp" e "dia"
diri = "/media/marilia/DADOS/Marilia/doutorado/termos_eq_rws/arq_termos/0dp/div/"
diri2 = "/media/marilia/DADOS/Marilia/doutorado/termos_eq_rws/arq_termos/0dp/vdiv/"

fili1 = "0dp_" + dia + "_div_era5_1974-2019_mean.nc"
fili2 = "0dp_" + dia + "_vdiv_era5_1974-2019_mean.nc"

diro = "/media/marilia/DADOS/Marilia/doutorado/termos_eq_rws/arq_termos/0dp/figs/div/"
diro2 = "/media/marilia/DADOS/Marilia/doutorado/termos_eq_rws/arq_termos/0dp/figs/vdiv/"

filo = "0dp_div_" + dia
filo2 = "0dp_vdiv_" + dia

; Abra os arquivos usando as variáveis no nome
f = addfile (diri+fili1, "r")
v1 = f->div(0,:,:)
v1 = v1*1e6

f2 = addfile (diri2+fili2, "r")
uchi = f2->uchi(0,:,:)
vchi = f2->vchi(0,:,:)


; Defina o nome do arquivo de saída, também incorporando as variáveis

wks = gsn_open_wks("png", diro+filo)
wks2 = gsn_open_wks("png", diro2+filo2)


res1 = True
res1@gsnMaximize = True
res1@mpMaxLatF = 15.
res1@mpMinLatF = -80.
res1@mpMinLonF = 0.
res1@mpMaxLonF = 360.
res1@mpCenterLonF = 180.
res1@cnFillPalette = "precip_diff_12lev"
res1@cnFillOn = True
res1@cnLinesOn = False
res1@cnLineLabelsOn = False
res1@cnRasterSmoothingOn = True
res1@cnFillMode = "RasterFill"
res1@gsnAddCyclic = False
res1@trGridType = "TriangularMesh"
res1@tmYLPrecision = 2
res1@tiMainString = "Rossy Wave Source and Meridional Wind Anomaly at 200 hPa - " + dptitulo
res1@gsnRightString = ""
res1@gsnLeftString = ""
res1@cnLevelSelectionMode = "ManualLevels"
res1@cnMinLevelValF = -14
res1@cnMaxLevelValF = 14
res1@cnLevelSpacingF = 2

;--- Shaded Resources
;   res = True
;   res@gsnDraw           = False
;   res@gsnFrame          = False
;   res@gsnAddCyclic      = False
   ;res@tmXBLabelFontHeightF = 0.012
   ;res@gsnStringFontHeightF = 0.02

   
;   res@mpMaxLatF    = lat2
;   res@mpMinLatF    = lat1                             
;   res@mpMinLonF    = lon1      
;   res@mpMaxLonF    = lon2    
;   res@mpCenterLonF = 180.
   
;   res@gsnContourZeroLineThicknessF = 0. 

;   res@cnFillOn          = True         
;   res@cnLinesOn = False
;   res@cnLineLabelsOn = False
;   res@cnFillPalette = "precip_diff_12lev"
;   res@cnLevelSelectionMode =  "ManualLevels"  
;   res@lbLabelBarOn = True
;   res@cnMinLevelValF = -6
;   res@cnMaxLevelValF = 6
;   res@cnLevelSpacingF = 1 
;   
;   res@mpNationalLineThicknessF = 3.0 
;   res@pmTickMarkDisplayMode = "Always"
;   res@pmLabelBarOrthogonalPosF = .12
      
;   res@lbLabelBarOn = True 
;   res@lbBoxEndCapStyle = "TriangleBothEnds"     
;   res@tmYROn = False
;   res@tmXTOn = False
;   res@tiMainString = "Divergence at 200 hPa - " + dptitulo + " - " + diatitulo
;   res@gsnRightString = ""
;   res@gsnLeftString = ""
;   res@tiMainFontHeightF = 0.015   ; Define o tamanho da fonte do título
;   res@tiMainOffsetYF = -0.02  ; Move o título para mais perto da figura


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
   resv@mpMaxLatF    = lat2
   resv@mpMinLatF    = lat1                             
   resv@mpMinLonF    = lon1      
   resv@mpMaxLonF    = lon2    
   resv@mpCenterLonF = 180.
   resv@tmYROn = False
   resv@tmXTOn = False
 
;--- divergence
   resv@tiMainString = "Divergent Wind at 200 hPa - " + dptitulo + " - " + diatitulo
   resv@gsnRightString = ""
   resv@gsnLeftString = ""
   resv@tiMainFontHeightF = 0.015   ; Define o tamanho da fonte do título
   resv@tiMainOffsetYF = -0.02  ; Move o título para mais perto da figura
   
;--- vetor na figura
   resv@vcRefAnnoOn = True                    ; Ativa a legenda do vetor
   resv@vcRefAnnoString1 = "10"            ; Define o rótulo da legenda
   resv@vcRefAnnoFontHeightF = 0.008           ; Ajusta o tamanho do texto da legenda
   resv@vcRefMagnitudeF         = 6.0
   resv@vcRefLengthF            = 0.045
   resv@vcRefAnnoOrthogonalPosF = -1.0          ; Move a legenda para o topo
   ;resv@vcRefAnnoParallelPosF = 0.5           ; Move a legenda mais para a esquerda (ajuste conforme necessário)



  
   ;res@gsnLeftString = lName2(0)
   plot = gsn_csm_contour_map(wks,v1,res1)
   plot1 = gsn_csm_vector_map(wks2,uchi,vchi,resv)
   ;overlay(plot,plot1)
   draw(plot)
   draw(plot1)

   frame(wks)

end

