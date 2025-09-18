load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

begin

;--------------------------------------------------------
;----- Definindo variaveis
;-------------------------------------------------------- 


dia = "dia2"
diatitulo = "Day 2"
dptitulo = "0 DP"

; Defina as latitudes e longitudes
lat1 = -80.0
lat2 = 10.0
lon1 = 0.0
lon2 = 360.0

;--------------------------------------------------------
;----- Abrindo arquivos
;-------------------------------------------------------- 

; Caminho e nomes de arquivos, incorporando as variáveis "dp" e "dia"
diri = "/media/marilia/DADOS/Marilia/doutorado/termos_eq_rws/arq_termos/0dp/vorta/"
diri2 = "/media/marilia/DADOS/Marilia/doutorado/termos_eq_rws/arq_termos/0dp/grad/"

;fili1 = "temp2_0dp_dia2_grad_vorta_era5_1974-2019_mean.nc"
fili1 = "0dp_" + dia + "_vorta_era5_1974-2019_mean.nc"
fili2 = "temp2_0dp_dia2_grad_vorta_era5_1974-2019_mean.nc"
;fili2 = "0dp_" + dia + "_grad_vorta_era5_1974-2019_mean.nc"

   f2 = addfile(diri+fili1,"r")
   v2 = f2->vorta
   vort = v2*1e5
   vort = vort(0,:,:)
   
   f4 = addfile(diri2+fili2,"r")  
   v4 = f4->grad
   grad = v4*1e11
   grad = grad(0,:,:)
   
; Caminho e nomes de arquivos de saida, incorporando as variáveis "dp" e "dia"
diro = "/media/marilia/DADOS/Marilia/doutorado/termos_eq_rws/arq_termos/0dp/figs/vort/"
diro2 = "/media/marilia/DADOS/Marilia/doutorado/termos_eq_rws/arq_termos/0dp/figs/grad/"

filo = "0dp_vorta_" + dia
filo2 = "0dp_grad_vorta_" + dia

;--------------------------------------------------------
;----- Salvando arquivos de saida
;-------------------------------------------------------- 
 
wks = gsn_open_wks("png", diro+filo)
wks2 = gsn_open_wks("png", diro2+filo2)



;------------------------------------------------------------
; Configuration for plots
;------------------------------------------------------------


;--- Shaded Resources
   res = True
   res@gsnDraw           = False
   res@gsnFrame          = False
   res@gsnAddCyclic      = False
   res@gsnContourZeroLineThicknessF = 0. 
   res@tmXBLabelFontHeightF = 0.012
   res@gsnStringFontHeightF = 0.02
   
   
   res@cnFillOn  = True         
   res@cnLinesOn = False
   res@cnLineLabelsOn = False
   res@cnFillPalette = "WhiteYellowOrangeRed"
   res@gsnRightString = ""
   res@gsnLeftString = ""
   res@cnLevelSelectionMode = "ManualLevels"
   res@cnMinLevelValF = 2
   res@cnMaxLevelValF = 14
   res@cnLevelSpacingF = 2 
   res@lbLabelBarOn = True 
   res@lbBoxEndCapStyle = "TriangleBothEnds"     
   res@tmYROn = False
   res@tmXTOn = False

;--- Map resources
   res@mpMaxLatF = 15.
   res@mpMinLatF = -80.
   res@mpMinLonF = 0.
   res@mpMaxLonF = 360.
   res@mpCenterLonF = 180.
   res@mpFillOn = False
   res@mpNationalLineThicknessF = 3.0 
   res@pmTickMarkDisplayMode = "Always"
   res@pmLabelBarOrthogonalPosF = .12

;--- Contour resources
   res2 = True
   res2@mpMaxLatF    = lat2
   res2@mpMinLatF    = lat1                             
   res2@mpMinLonF    = lon1      
   res2@mpMaxLonF    = lon2    
   res2@mpCenterLonF = 180.
   res2@mpFillOn = False
   res2@mpNationalLineThicknessF = 3.0 
   res2@pmTickMarkDisplayMode = "Always"
   res2@pmLabelBarOrthogonalPosF = .12
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
 
   plot = gsn_csm_contour_map_ce(wks2,grad,res)
   plot1 = gsn_csm_contour(wks,vort,res2)
   ;overlay(plot,plot1)
   draw(plot)
   draw(plot1)

   frame(wks2)
   frame(wks)

end
