import numpy as np
import panel as pn
import plotly.graph_objs as go
import nibabel as nib
import plotly.express as px


def get_slice(zslice=0):
    return px.imshow(mean_vol[:,:,zslice].T, binary_string=True, width=500, origin='lower')


img = nib.load('bold.nii.gz')
vol_4d = img.get_fdata()
mean_vol = np.mean(vol_4d, axis=3)
pn.extension("plotly")
sliceplot = pn.interact(get_slice, zslice=np.arange(0, mean_vol.shape[2]))


@pn.depends(sliceplot[1][0].param.click_data)
def get_tc(click_data):
    if click_data is None:
        return px.line()
    else:
        return px.line(x=np.arange(0, vol_4d.shape[3]),
                       y=vol_4d[click_data['points'][0]['x'], click_data['points'][0]['y'],
                                sliceplot[0][0].value, :])


app = pn.Row(sliceplot, get_tc)
app.servable()