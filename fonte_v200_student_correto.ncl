begin
lat1 = -80.0
lat2 = 10.0
lon1 = 0.0
lon2 = 330.0

dia = "Day -10"
diaarq = "dia-10"
dp = "2dpm" ; 0dp 1dp 2dpm
dppwd = "2dp"
dptitulo = "2DP+"

diri = "/media/marilia/DADOS/Marilia/doutorado/ncl/ncl2/fonte/"
diro = "/media/marilia/DADOS/Marilia/doutorado/zip/figs_tstudent/" + dppwd + "/" 

fili = "fonte_mediafinal_" + diaarq + "_" + dp + ".nc"
fili2 = "anom_v200_" + diaarq + "_" + dp + ".nc"
filis = "student_anom_v200_" + diaarq + "_" + dp + ".nc"



f = addfile (diri+fili2, "r")
x = f->v(0,:,:); (time,lat,lon) ==> (29,60,180)
g = addfile (diri+fili, "r")
y = g->fonte(0,:,:)
y = y*1e10

h = addfile(diri+filis, "r")
z = h->v(0,:,:)

wks = gsn_open_wks("png",diro + "student_" + dp + "fonte_anom_v200_" + diaarq)
; send graphics to PNG file
res = True
res@gsnMaximize = True
res@gsnDraw = False
res@gsnFrame = False
res@gsnAddCyclic = False
res@cnLinesOn = True
res@mpMaxLatF = 10.
res@mpMinLatF = -80.
res@mpMinLonF = 0.
res@mpMaxLonF = 330.
res@mpCenterLonF = 180.
res@gsnContourZeroLineThicknessF = 0
res@cnLineLabelsOn = True
res@cnInfoLabelOn = True
res@cnLineThicknessF = 2.0
res@cnInfoLabelOn = False
res@cnLevelSelectionMode = "ManualLevels"
res@gsnLeftString = ""
res@cnMinLevelValF = -20
res@cnMaxLevelValF = 20
res@cnLevelSpacingF = 4
res@gsnContourZeroLineThicknessF = 0
res@gsnContourNegLineDashPattern = 1
res@cnLinesOn = True

res1 = True
res1@gsnMaximize = True
res1@mpMaxLatF = 15.
res1@mpMinLatF = -80.
res1@mpMinLonF = 0.
res1@mpMaxLonF = 330.
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

res2                 = True
;res2@gsnMaximize     = True       ; maximize in frame
res2@cnLinesOn       = False
res2@cnFillOn        = True
res2@cnFillPalette   = "gsltod"   ; change the color palette
res2@cnMinLevelValF      = 10
res2@cnMaxLevelValF      = 10
res2@cnLevelSpacingF     = 0.1
res2@cnFillOpacityF = 0.1
res2@gsnRightString      = " "
res2@gsnLeftString       = " "

opt = True
opt@gsnShadeHigh         = 1          ; stipple
opt@gsnShadeFillScaleF   = 0.1         ; add extra density
opt@gsnShadeFillDotSizeF = 0.002      ; make dots larger
  

plot = gsn_csm_contour(wks, x, res)
plot1 = gsn_csm_contour_map_ce(wks, y, res1)
plot2 = gsn_csm_contour(wks, z, res2)
;plot2 = ColorNegDashZeroPosContour(plot2,"transparent","black","black")
  
iplot_stipple = plot2
iplot_stipple = gsn_contour_shade(iplot_stipple,0, 0.8, opt)

overlay(plot1, plot)
overlay(plot1, iplot_stipple)
  
draw(plot1)
frame(wks)

;plot = gsn_csm_contour(wks,x,res)
;plot1 = gsn_csm_contour_map_ce(wks,y,res1)
;overlay(plot1,plot)
;draw(plot1)
;frame(wks)

end
