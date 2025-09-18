;------------------------------------------------------------
; Plot fonte
;------------------------------------------------------------
load "./phases.ncl"

begin

;------------------------------------------------------------
; User specifications
;----------------------------------------------------------- 
   lName = (/"200 hPa absolute vorticity (10~S~-5 ~N~s ~S~-1~N~)"/)
   legp = (/"a) Inactive MJO, + ~F33~s", "b) Active MJO, + ~F33~s","c) Inactive MJO, - ~F33~s", "d) Active MJO, - ~F33~s"/)
   dir = "/mnt/c/data/reanalysis/fontes/"
   
;-----------------------------------------------------
; Read in netCDF files
;-----------------------------------------------------
   f2 = addfile(dir+"vorta_era5_1974-2019.nc","r")
   v2 = f2->vorta
   v2 = v2*1e5
   
   f4 = addfile(dir+"grad_vorta_era5_1974-2019.nc","r")  
   v4 = f4->grad
   v4 = v4*1e11
   
;--------------------------------------------------------
;----- Composites
;-------------------------------------------------------- 
   vort1 = dim_avg_n_Wrap(v2(t0mais,:,:),0)
   vort2 = dim_avg_n_Wrap(v2(tamais,:,:),0)
   vort3 = dim_avg_n_Wrap(v2(t0menos,:,:),0)
   vort4 = dim_avg_n_Wrap(v2(tamenos,:,:),0)

   grad1 = dim_avg_n_Wrap(v4(t0mais,:,:),0)
   grad2 = dim_avg_n_Wrap(v4(tamais,:,:),0)
   grad3 = dim_avg_n_Wrap(v4(t0menos,:,:),0)
   grad4 = dim_avg_n_Wrap(v4(tamenos,:,:),0)

;------------------------------------------------------------
; Configuration for plots
;------------------------------------------------------------
   wks_type          = "png"
   wks_type@wkWidth  = 2500
   wks_type@wkHeight = 2500
   wks = gsn_open_wks(wks_type,"fig9") 

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
   res@lbLabelBarOn = False 
   res@lbBoxEndCapStyle = "TriangleBothEnds"     
   res@tmYROn = False
   res@tmXTOn = False

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
 
;-----------------------------------------
; Plot 
;-----------------------------------------
   base_map = new(4,graphic)

   res@cnMinLevelValF  = 1
   res@cnMaxLevelValF  = 10
   res@cnLevelSpacingF = 1
   res@gsnRightString = lName(0)
   
   res@gsnLeftString = legp(0)
   base_map(0) = gsn_csm_contour_map(wks,grad1,res)
   map0 = gsn_csm_contour(wks,vort1,res2)
   overlay(base_map(0),map0)

   res@gsnLeftString = legp(1)
   base_map(1) = gsn_csm_contour_map(wks,grad2,res)
   map0 = gsn_csm_contour(wks,vort2,res2)
   overlay(base_map(1),map0)

   res@gsnLeftString = legp(2)
   base_map(2) = gsn_csm_contour_map(wks,grad3,res)
   map0 = gsn_csm_contour(wks,vort3,res2)
   overlay(base_map(2),map0)
   
   res@gsnLeftString = legp(3)
   base_map(3) = gsn_csm_contour_map(wks,grad4,res)
   map0 = gsn_csm_contour(wks,vort4,res2)
   overlay(base_map(3),map0)
   
;------------------------------------------------------------
; create panel
;------------------------------------------------------------
   resP = True
   resP@gsnFrame         = False
   resP@gsnPanelLabelBar = True
   resP@gsnPanelBottom   = 0.05         
   resP@gsnPanelTop      = 0.95 
   resP@gsnPanelYWhiteSpacePercent = 5
   gsn_panel(wks,base_map,(/2,2/),resP)

   frame(wks)

end

