;------------------------------------------------------------
; Plot fonte
;------------------------------------------------------------
load "./phases.ncl"

begin

;------------------------------------------------------------
; User specifications
;----------------------------------------------------------- 
   lName = (/"Rossby wave source"/)
   legp = (/"a) Inactive MJO, + ~F33~s", "b) Active MJO, + ~F33~s","c) Inactive MJO, - ~F33~s", "d) Active MJO, - ~F33~s"/)
   dir = "/mnt/c/data/reanalysis/fontes/"
   
;-----------------------------------------------------
; Read in netCDF files
;-----------------------------------------------------
   f1 = addfile(dir+"fonte_era5_1974-2019.nc","r")
   v1 = f1->fonte
   v1 = v1*1e11
      
;--------------------------------------------------------
;----- Composites
;-------------------------------------------------------- 
   div1 = dim_avg_n_Wrap(v1(t0mais,:,:),0)
   div2 = dim_avg_n_Wrap(v1(tamais,:,:),0)
   div3 = dim_avg_n_Wrap(v1(t0menos,:,:),0)
   div4 = dim_avg_n_Wrap(v1(tamenos,:,:),0)

;------------------------------------------------------------
; Configuration for plots
;------------------------------------------------------------
   wks_type          = "png"
   wks_type@wkWidth  = 2500
   wks_type@wkHeight = 2500
   wks = gsn_open_wks(wks_type,"fig10") 

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
   res@cnFillPalette = "precip_diff_12lev"
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
 
;-----------------------------------------
; Plot 
;-----------------------------------------
   base_map = new(4,graphic)

;--- fonte
   res@cnMinLevelValF = -35
   res@cnMaxLevelValF = 35
   res@cnLevelSpacingF = 5
   res@gsnRightString = lName(0)
   
   res@gsnLeftString = legp(0)
   base_map(0) = gsn_csm_contour_map(wks,div1,res)

   res@gsnLeftString = legp(1)
   base_map(1) = gsn_csm_contour_map(wks,div2,res)

   res@gsnLeftString = legp(2)
   base_map(2) = gsn_csm_contour_map(wks,div3,res)
   
   res@gsnLeftString = legp(3)
   base_map(3) = gsn_csm_contour_map(wks,div4,res)
   
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

