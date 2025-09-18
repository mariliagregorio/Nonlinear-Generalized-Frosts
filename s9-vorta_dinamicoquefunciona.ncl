begin

;--------------------------------------------------------
;----- Definindo variaveis
;-------------------------------------------------------- 

dia = "dia2"
diatitulo = "Day 2"
dptitulo = "0 DP"

diri = "/media/marilia/DADOS/Marilia/doutorado/termos_eq_rws/arq_termos/0dp/vorta/"
diri2 = "/media/marilia/DADOS/Marilia/doutorado/termos_eq_rws/arq_termos/0dp/grad/"
diro = "/media/marilia/DADOS/Marilia/doutorado/termos_eq_rws/arq_termos/0dp/figs/vort/"

fili = "0dp_" + dia + "_vorta_era5_1974-2019_mean.nc"
fili2 = "0dp_" + dia + "_grad_vorta_era5_1974-2019_mean.nc"
filo = "0dp_vorta_gradvorta_" + dia
;--------------------------------------------------------
;----- Abrindo arquivos
;--------------------------------------------------------

f2 = addfile(diri+fili,"r")
v2 = f2->vorta(0,:,:)
v2 = v2*1e5

f4 = addfile(diri2+fili2,"r")
v4 = f4->grad(0,:,:)
v4 = v4*1e11

;--------------------------------------------------------
;----- Configuracao da Plotagem
;--------------------------------------------------------

   wks_type          = "png"
   wks_type@wkWidth  = 2500
   wks_type@wkHeight = 2500
   wks = gsn_open_wks(wks_type,diro+filo) 

;--- Shaded Resources
   res = True
   res@gsnDraw           = False
   res@gsnFrame          = False
   res@gsnAddCyclic      = False
   res@gsnContourZeroLineThicknessF = 0. 
   res@tmXBLabelFontHeightF = 0.012
   res@gsnStringFontHeightF = 0.02
   res2 = res
   
   res@cnFillOn  = True         
   res@cnLinesOn = False
   res@cnLineLabelsOn = False
   res@cnFillPalette = "WhiteYellowOrangeRed"
   res@cnLevelSelectionMode =  "ManualLevels"   
   res@lbLabelBarOn = True 
   res@lbBoxEndCapStyle = "TriangleBothEnds"     
   res@tmYROn = False
   res@tmXTOn = False
   res@gsnLeftString = ""
   res@gsnRightString = ""
   res@tiMainString = "200 hPa Gradient and Absolute Vorticity - " + dptitulo + " " + diatitulo
   res@tiMainFontHeightF = 0.015   ; Define o tamanho da fonte do título
   res@tiMainOffsetYF = -0.02  ; Move o título para mais perto da figura

;--- Map resources
   res@mpMaxLatF    = 20
   res@mpMinLatF    = -70                             
   res@mpMinLonF    = 20      
   res@mpMaxLonF    = 330    
   res@mpCenterLonF = 180.
   res@mpFillOn = False
   res@mpNationalLineThicknessF = 3.0 
   res@pmTickMarkDisplayMode = "Always"
   res@pmLabelBarOrthogonalPosF = .12

;--- Contour resources
   res2@cnFillOn  = False         
   res2@cnLinesOn = True
   res2@cnInfoLabelOn = False
   res2@cnLineLabelInterval = 2
   res2@cnLineLabelFontHeightF = 0.006
   res2@cnLineLabelPlacementMode = "constant"   
   res2@cnLevelSelectionMode =  "ManualLevels"   
   res2@cnMinLevelValF    = -14
   res2@cnMaxLevelValF    = 14
   res2@cnLevelSpacingF   = 2
   res2@gsnLeftString = ""
   res2@gsnRightString = ""

;---

   res@cnMinLevelValF  = 2
   res@cnMaxLevelValF  = 12
   res@cnLevelSpacingF = 2
   
   base_map = gsn_csm_contour_map_ce(wks,v4,res)
   map = gsn_csm_contour(wks,v2,res2)
   overlay(base_map,map)
   draw(base_map)
   
    frame(wks)

end  
