begin
lat1 = -80.0
lat2 = 10.0
lon1 = 0.0
lon2 = 330.0

dia = -5
dp = 1dp

diri = "/media/marilia/DADOS/Marilia/doutorado/ncl/ncl2/fonte/"
diri2= "/media/marilia/DADOS/Marilia/doutorado/ncl/ncl2/fonte/"
fili = "anom_v200_dia" + dia + "_" + dp ".nc"
fili2 = "fonte_mediafinal_dia" + dia + dp + ".nc"
f = addfile (diri+fili, "r")
x = f->v(0,:,:)
; (time,lat,lon) ==> (29,60,180)
g = addfile (diri2+fili2, "r")
y = g->fonte(0,:,:)
y = y*1e10
wks = gsn_open_wks("png","fonte_v200_dia" + dia + "_" + dp)
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
res1@tiMainString = "Rossy Wave Source - " + dia + dp "DP"
res1@gsnRightString = ""
res1@gsnLeftString = ""
res1@cnLevelSelectionMode = "ManualLevels"
res1@cnMinLevelValF = -14
res1@cnMaxLevelValF = 14
res1@cnLevelSpacingF = 2
plot = gsn_csm_contour(wks,x,res)
plot1 = gsn_csm_contour_map_ce(wks,y,res1)
overlay(plot1,plot)
draw(plot1)
frame(wks)
end
