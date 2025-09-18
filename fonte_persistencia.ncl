;------------------------------------------------------------
; Plot fonte
;------------------------------------------------------------
begin

;------------------------------------------------------------
; User specifications
;----------------------------------------------------------- 
   lName = (/"Rossby wave source"/)
   dir = "/media/flemes/Dados/ncl/fonte/"
   
;-----------------------------------------------------
; Read in netCDF files
;-----------------------------------------------------
   f1 = addfile(dir+"fonte_mediafinal_dia0_2dpm.nc","r")
   f2 = addfile(dir+"anom_v200_dia0_2dpm.nc","r")
   v1 = f1->fonte(0,:,:)
   v1 = v1*1e10
   v2 = f2->v(0,:,:)
      
;------------------------------------------------------------
; Configuration for plots
;------------------------------------------------------------
   wks_type          = "png"
   wks_type@wkWidth  = 2500
   wks_type@wkHeight = 2500
   wks = gsn_open_wks(wks_type,"fonte_v200_2dpm_dia0") 

;--- Shaded Resources
   res = True
   res@gsnMaximize = True
   res@gsnDraw           = False
   res@gsnFrame          = False
   res@gsnAddCyclic      = False 
   res@gsnContourZeroLineThicknessF = 0. 
   res@tmXBLabelFontHeightF = 0.012
   res@gsnStringFontHeightF = 0.02

   res@cnFillOn  = True         
   res@cnLineLabelsOn = False
   res@cnFillPalette = "precip_diff_12lev"
   res@cnLevelSelectionMode =  "ManualLevels"   
      
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

;--- Map resources
  res@mpMaxLatF = 10.      ; specify the plot domain
  res@mpMinLatF = -80.                             
  res@mpMinLonF = 0.      
  res@mpMaxLonF = 330.    
  res@mpCenterLonF         = 180.         ; defailt is 0 [GM]
   res@mpFillOn = False
   res@mpNationalLineThicknessF = 3.0 
   res@pmTickMarkDisplayMode = "Always"
   res@pmLabelBarOrthogonalPosF = .12
   res@lbLabelBarOn = True
 
;-----------------------------------------
; Plot 
;-----------------------------------------

;--- fonte
   res@cnMinLevelValF = -14
   res@cnMaxLevelValF = 14
   res@cnLevelSpacingF = 2
   res@gsnRightString = "Dia 0 2dpm"
   res@gsnLeftString = "RWS e V200"

   ;plot = gsn_csm_contour_map(wks,v1,res)
   
   plot = gsn_csm_contour_map_ce(wks,v1,res)
   plot1 = gsn_csm_contour(wks,v2,res1)
   overlay(plot,plot1)
   draw(plot)

   ;draw(plot)
   frame(wks)

end

