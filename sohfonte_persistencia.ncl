;------------------------------------------------------------
; Plot fonte
;------------------------------------------------------------
begin

lat1 = -80.0
lat2 = 10.0
lon1 = 0.0
lon2 = 330.0

dia = "dia2"
diatitulo = "Day 2"
dptitulo = "0DP"

;------------------------------------------------------------
; User specifications
;----------------------------------------------------------- 
   lName = (/"Rossby wave source"/)
   dir = "/media/marilia/DADOS/Marilia/doutorado/termos_eq_rws/arq_termos/0dp/fonte/"
   diro = "/media/marilia/DADOS/Marilia/doutorado/termos_eq_rws/arq_termos/0dp/figs/"
;-----------------------------------------------------
; Read in netCDF files
;-----------------------------------------------------
   f1 = addfile(dir+"0dp_" + dia + "_fonte_era5_1974-2019_mean.nc","r")
   ;f2 = addfile(dir+"anom_v200_dia0_2dpm.nc","r")
   v1 = f1->fonte(0,:,:)
   v1 = v1*1e10
   ;v2 = f2->v(0,:,:)
      
;------------------------------------------------------------
; Configuration for plots
;------------------------------------------------------------
   wks_type          = "png"
   wks_type@wkWidth  = 2000
   wks_type@wkHeight = 2000
   wks = gsn_open_wks(wks_type, diro + "0dp_fonte_" + dia) 

;--- Shaded Resources

   
   res1 = True
   res1@gsnMaximize = True
   res1@mpMaxLatF = lat2
   res1@mpMinLatF = lat1
   res1@mpMinLonF = lon1
   res1@mpMaxLonF = lon2
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
   res1@tiMainString = "Rossy Wave Source - " + dptitulo + " - " + diatitulo
   res1@gsnRightString = ""
   res1@gsnLeftString = ""
   res1@cnLevelSelectionMode = "ManualLevels"
   res1@cnMinLevelValF = -14
   res1@cnMaxLevelValF = 14
   res1@cnLevelSpacingF = 2

 
;-----------------------------------------
; Plot 
;-----------------------------------------

   ;plot = gsn_csm_contour_map(wks,v1,res1)
   
   plot = gsn_csm_contour_map_ce(wks,v1,res1)
   ;plot1 = gsn_csm_contour(wks,v2,res1)
   ;overlay(plot,plot1)
   draw(plot)

   ;draw(plot)
   ;frame(wks)

end

