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
   f1 = addfile(dir+"fonte_mediafinal_dia-1_0dp.nc","r")
   
   if (isvar("f1")) then
       if (isdim(f1,"fonte")) then
           v1 = f1->fonte(0,:,:,:,:)
           ;v1 = v1*1e10
       else
           print("Error: 'fonte' dimension not found in the file.")
           exit
       end if
   else
       print("Error: File not found or could not be opened.")
       exit
   end if
   
;------------------------------------------------------------
; Configuration for plots
;------------------------------------------------------------
   wks_type          = "png"
   wks = gsn_open_wks(wks_type,"fonte_0dp_dia-10") 

   ; Set workstation size
   setvalues wks
      "wkWidth"  : 2500
      "wkHeight" : 2500
   end setvalues

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
   res@mpMaxLatF = 10.      ; specify the plot domain
   res@mpMinLatF = -80.                             
   res@mpMinLonF = 0.      
   res@mpMaxLonF = 330.    
   res@mpCenterLonF = 180.  ; default is 0 [GM]
   res@mpFillOn = False
   res@mpNationalLineThicknessF = 3.0 
   res@pmTickMarkDisplayMode = "Always"
   res@pmLabelBarOrthogonalPosF = .12
 
;-----------------------------------------
; Plot 
;-----------------------------------------

;--- fonte
   ;res@cnMinLevelValF = -10
   ;res@cnMaxLevelValF = 10
   ;res@cnLevelSpacingF = 5
   ;res@gsnRightString = lName(0)

   plot = gsn_csm_contour_map(wks,v1,res)
   
   draw(plot)
   frame(wks)

end
