begin
lat1 = -80.0
lat2 = 10.0
lon1 = 0.0
lon2 = 330.0
diri = "/home/flemes/ncl/geop850/arquivos/"
fili = "2dpm_novo_dia5_geop850.nc"
f = addfile (diri+fili, "r")
x = f->z850_filtrado(0,:,:)
wks = gsn_open_wks("png","2dpm_geop850_dia5")
res1 = True
res1@gsnMaximize = True
res1@mpMaxLatF = 10.
res1@mpMinLatF = -80.
res1@mpMinLonF = 0.
res1@mpMaxLonF = 330.
res1@cnLinesOn = True
res1@cnLineLabelsOn = True
res1@cnRasterSmoothingOn = True
res1@cnFillMode = "RasterFill"
res1@cnFillMode = "AreaFill"
res1@gsnAddCyclic = False
res1@cnLevelSelectionMode = "ManualLevels"
res1@gsnLeftString = ""
res1@cnMinLevelValF = -300
res1@cnMaxLevelValF = 300
res1@cnLevelSpacingF = 50
res1@trGridType = "TriangularMesh"
res1@tmYLPrecision = 2
res1@tiMainString = "geop850 (FILTRO 30-90) 2dpm - DIA 5"
res1@gsnRightString = ""
res1@gsnLeftString = ""
res1@gsnContourNegLineDashPattern = 1
res1@gsnContourZeroLineThicknessF = 0
res1@cnLineThicknessF = 2.0
plot1 = gsn_csm_contour_map(wks,x,res1)
draw(plot1)
frame(wks)
end