from bokeh.layouts import layout
from bokeh.models import Slider
from bokeh.plotting import figure, curdoc
from bokeh.events import Tap
import nibabel as nib
import numpy as np


def update_slice(attr, old, new):
    new_data = dict(image=[mean_vol[:,:,slider.value].T])
    implot_source.data = new_data


def update_tc(event):
    new_data = dict(x=np.arange(0, vol_4d.shape[3]),
                    y=vol_4d[
                        np.floor(event.x).astype(int),
                        np.floor(event.y).astype(int),
                        slider.value, :]
                   )
    tcplot_source.data = new_data


img = nib.load('bold.nii.gz')
vol_4d = img.get_fdata()
mean_vol = np.mean(vol_4d, axis=3)
midslice = int(mean_vol.shape[2]/2)

plot1 = figure(toolbar_location=None, tools='hover')
plot1.axis.visible = False
plot1.xgrid.visible = False
plot2 = figure(background_fill_color="#fafafa", tools='hover')
slider = Slider(start=0, end=mean_vol.shape[2]-1, step=1, value=midslice, title='Slice')

implot = plot1.image(image=[mean_vol[:,:,midslice].T],
                     x=0, y=0, dw=mean_vol.shape[0], dh=mean_vol.shape[1])
implot_source = implot.data_source

tcplot = plot2.line(x=[], y=[], line_width=3)
tcplot_source = tcplot.data_source

slider.on_change('value', update_slice)
plot1.on_event(Tap, update_tc)

curdoc().add_root(layout([[slider],[plot1, plot2]]))