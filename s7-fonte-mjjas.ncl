;------------------------------------------------------------
; Plot fonte
;------------------------------------------------------------

;-----------------------------------------------------------
begin

;------------------------------------------------------------
; User specifications
;----------------------------------------------------------- 
   lName = (/"200 hPa zonal wind","200 hPa meridional wind","200 hPa divergence","200 hPa divergent wind","200 hPa absolute vorticity","Rossby wave source"/)
   unt = (/"m/s","m/s","10~S~-6 ~N~s ~S~-1~N~","m/s","10~S~-5 ~N~s ~S~-1~N~","10~S~-11 ~N~s ~S~-2~N~"/)
   dir = "/mnt/c/data/reanalysis/fontes/"
   diru = "/mnt/c/data/reanalysis/uwnd/day/"
   dirv = "/mnt/c/data/reanalysis/vwnd/day/"
   
;-----------------------------------------------------
; Read in netCDF files
;-----------------------------------------------------
   f1 = addfile(dir+"div_era5_1974-2019.nc","r")
   f2 = addfile(dir+"vorta_era5_1974-2019.nc","r")
   f3 = addfile(dir+"fonte_era5_1974-2019.nc","r")
   f4 = addfile(dir+"grad_vorta_era5_1974-2019.nc","r")
   f5 = addfile(dir+"vdiv_era5_1974-2019.nc","r")
   fu = addfile(diru+"era5_1974-2019_regrid.nc","r")
   fv = addfile(dirv+"era5_1974-2019_regrid.nc","r")

   v1 = f1->div
   v2 = f2->vorta
   v3 = f3->fonte
   v4 = f4->grad
   v5 = f5->uchi
   v6 = f5->vchi
   vu = fu->u
   vv = fv->v
   v1 = v1*1e6
   v2 = v2*1e5
   v3 = v3*1e11
   v4 = v4*1e11
   
   v1m = calculate_monthly_values(v1, "avg", 0, False)
   v2m = calculate_monthly_values(v2, "avg", 0, False)
   v3m = calculate_monthly_values(v3, "avg", 0, False)
   v4m = calculate_monthly_values(v4, "avg", 0, False)
   v5m = calculate_monthly_values(v5, "avg", 0, False)
   v6m = calculate_monthly_values(v6, "avg", 0, False)
   vum = calculate_monthly_values(vu, "avg", 0, False)
   vvm = calculate_monthly_values(vv, "avg", 0, False)

   p1 = clmMonTLL(v1m)
   p2 = clmMonTLL(v2m)
   p3 = clmMonTLL(v3m)
   p4 = clmMonTLL(v4m)
   p5 = clmMonTLL(v5m)
   p6 = clmMonTLL(v6m)
   pu = clmMonTLL(vum)
   pv = clmMonTLL(vvm)

   p1m = dim_avg_n_Wrap(p1(4:8,:,:),0)
   p2m = dim_avg_n_Wrap(p2(4:8,:,:),0)
   p3m = dim_avg_n_Wrap(p3(4:8,:,:),0)
   p4m = dim_avg_n_Wrap(p4(4:8,:,:),0)
   p5m = dim_avg_n_Wrap(p5(4:8,:,:),0)
   p6m = dim_avg_n_Wrap(p6(4:8,:,:),0)
   pum = dim_avg_n_Wrap(pu(4:8,:,:),0)
   pvm = dim_avg_n_Wrap(pv(4:8,:,:),0)

;------------------------------------------------------------
; Configuration for plots
;------------------------------------------------------------
   wks_type          = "png"
   wks_type@wkWidth  = 2500
   wks_type@wkHeight = 2500
   wks = gsn_open_wks(wks_type,"fig7") 

;--- Shaded Resources
   res = True
   res@gsnDraw           = False
   res@gsnFrame          = False
   res@gsnAddCyclic      = False
   res@gsnContourZeroLineThicknessF = 0. 
   res@tmXBLabelFontHeightF = 0.012
   res@gsnStringFontHeightF = 0.02
   res2 = res
   resv = res
   
   res@cnFillOn  = True         
   res@cnLinesOn = False
   res@cnLineLabelsOn = False
   res@cnFillPalette = "precip_diff_12lev"
   res@cnLevelSelectionMode =  "ManualLevels"   
   res@lbLabelBarOn = True 
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

;--- Vector resources
   resv@vcRefAnnoOrthogonalPosF = -1.0   ; move ref vector up
   resv@vcRefMagnitudeF         = 6.0
   resv@vcRefLengthF            = 0.045
   resv@vcGlyphStyle            = "CurlyVector"  
   resv@vcMinDistanceF          = 0.015
   resv@tmYROn       = False
   resv@tmXTOn       = False      
   resv@mpMaxLatF    = 20
   resv@mpMinLatF    = -70                             
   resv@mpMinLonF    = 20      
   resv@mpMaxLonF    = 330    
   resv@mpCenterLonF = 180.
   resv@mpFillOn     = False
   resv@mpNationalLineThicknessF = 3.0  
   resv@pmTickMarkDisplayMode = "Always"   
 
;-----------------------------------------
; Plot 
;-----------------------------------------
   base_map = new(6,graphic)

;--- divergence
   res@cnMinLevelValF = -6
   res@cnMaxLevelValF = 6
   res@cnLevelSpacingF = 1
   res@gsnRightString = "["+unt(2)+"]"
   res@gsnLeftString = "c) "+lName(2)+ " - MJJAS"
   base_map(2) = gsn_csm_contour_map(wks,p1m,res)

;--- fonte
   res@cnMinLevelValF = -35
   res@cnMaxLevelValF = 35
   res@cnLevelSpacingF = 5
   res@gsnRightString = "["+unt(5)+"]"
   res@gsnLeftString = "f) "+lName(5)+ " - MJJAS"
   base_map(5) = gsn_csm_contour_map(wks,p3m,res)

;--- vorticity
   res@cnFillPalette     = "WhiteYellowOrangeRed"
   res@cnMinLevelValF    = 2
   res@cnMaxLevelValF    = 12
   res@cnLevelSpacingF   = 2
   res@gsnRightString = "["+unt(4)+"]"
   res@gsnLeftString = "e) "+lName(4)+ " - MJJAS"
   base_map(4) = gsn_csm_contour_map(wks,p4m,res)
   map0 = gsn_csm_contour(wks,p2m,res2)
   overlay(base_map(4),map0)

;--- divergent wind
   resv@gsnLeftString = "d) "+lName(3)+ " - MJJAS"
   resv@gsnRightString = "["+unt(3)+"]"
   base_map(3) = gsn_csm_vector_map(wks,p5m,p6m,resv)

;--- zonal wind
   cmap = read_colormap_file("hotcold_18lev")
   cmap = cmap (::-1,:)
   res@cnFillPalette := cmap(5:18,:)
   res@cnMinLevelValF := -15
   res@cnMaxLevelValF := 50
   res@cnLevelSpacingF := 5 
   res@gsnRightString = "["+unt(0)+"]"
   res@gsnLeftString = "a) "+lName(0)+ " - MJJAS"
   base_map(0) = gsn_csm_contour_map(wks,pum,res)

;--- meridional wind
   res@cnFillPalette  := "precip_diff_12lev"
   res@cnMinLevelValF := -8
   res@cnMaxLevelValF := 8
   res@cnLevelSpacingF := 2 
   res@gsnRightString = "["+unt(1)+"]"
   res@gsnLeftString = "b) "+lName(1)+ " - MJJAS"
   res@cnLinesOn = True
   base_map(1) = gsn_csm_contour_map(wks,pvm,res)


;------------------------------------------------------------
; create panel
;------------------------------------------------------------
   resP = True
   resP@gsnFrame         = False
   resP@gsnPanelLabelBar = False
   resP@gsnPanelBottom   = 0.05         
   resP@gsnPanelTop      = 0.95 
   resP@gsnPanelYWhiteSpacePercent = 2
   gsn_panel(wks,base_map,(/3,2/),resP)

   frame(wks)

end

