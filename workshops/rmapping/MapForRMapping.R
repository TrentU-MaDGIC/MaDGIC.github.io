library(sf)
library(terra)
library(sp)
library(raster)
library(tmap)
#library(leaflet)
library(dplyr)

nobel = data.frame(latitude = c(59.32534072546109, 59.32753448735016, 59.33505242280391, 59.31054753663115, 59.34856313057529, 59.365099056434836),
                   longitude = c(18.070684617793507, 18.055185156811298, 18.063145068807643, 17.985987611199512, 18.02746935449288, 18.05848738855165),
                   build = c("Nobel Prize Museum", "Stockholms stadshus", "Konserthuset Stockholm", "Nobel's Blasting Bunkers", "Karolinska institutet", "Stockholms universitet"))

nobelsf = st_as_sf(nobel, coords=c("longitude", "latitude"), crs=4326)
plot(st_geometry(nobelsf))

nobelwalk = data.frame(latitude = c(59.32534072546109,59.33505242280391,59.32753448735016),
                       longitude = c(18.070684617793507,18.063145068807643,18.055185156811298))
nobelwalkm = as.matrix(nobelwalk[,c("longitude","latitude")])
nobelwalkline = st_sfc(st_linestring(nobelwalkm),crs=4326)
plot(nobelwalkline)

st_crs(nobelsf)
st_crs(nobelwalkline)
class(nobelwalkline)
st_geometry_type(nobelwalkline)

map = tm_shape(nobelsf) + tm_symbols(col="blue", fill_alpha=1)+ tm_text("build", size=0.8, col="white", remove.overlap=TRUE) +
  tm_shape(nobelwalkline) + tm_lines(col="yellow", lwd=3) +
  tm_add_legend(labels="Nobel Winners' Walk", position=c("right","top"), type="lines",col="yellow",lwd=3, show=TRUE,bg.alpha=0.6)+
  tm_basemap('CartoDB.DarkMatter') +
    tm_compass(type = "arrow", position = c("left", "top"), bg=TRUE, bg.color="white",bg.alpha=0.6) +
    tm_scalebar(breaks = c(0, 2, 5), text.size = 1, position = c("right", "bottom"),bg=TRUE, bg.color="white",bg.alpha=0.6) +
    tm_title("Nobel Prize Week") +
    tm_credits("  Created by: James Marcaccio, 
  Created on: 8 October 2025, 
  WGS84", position = c("right", "bottom"), size=0.5)+
    tm_layout(asp=1, inner.margins=c(0.2,0.5,0.5,0.2))
map  
