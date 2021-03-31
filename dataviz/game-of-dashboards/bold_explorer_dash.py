import dash
import dash_core_components as dcc
import dash_html_components as html
import nibabel as nib
import numpy as np
import plotly.express as px
from dash.dependencies import Input, Output, State


img = nib.load('bold.nii.gz')
vol_4d = img.get_fdata()
mean_vol = np.mean(vol_4d, axis=3)
midslice = int(mean_vol.shape[2]/2)
fig = px.imshow(mean_vol[:,:,midslice].T, binary_string=True, origin='lower')
fig_tc = px.line()

app = dash.Dash(__name__)

app.layout = html.Div([html.Div([
        html.Div(
            [dcc.Graph(id='graph-mri', figure=fig),
             dcc.Slider(
                id='slice-slider',
                min=0,
                max=mean_vol.shape[2] - 1,
                value=midslice,
                step=1)],
            style={'width': '60%', 'display': 'inline-block', 'padding': '0 0'},
        ),
        html.Div(
            [dcc.Graph(id='graph-tc', figure=fig_tc)],
            style={'width': '40%', 'display': 'inline-block', 'padding': '0 0'},
        ), html.Div(id='current-slice', style={'display': 'none'})
    ])
])


@app.callback(
    Output('graph-tc', 'figure'),
    Input('graph-mri', 'clickData'),
    State('current-slice', 'children'),
    prevent_initial_call=True
)
def update_tc(clickData, vol_slice):
    tc = vol_4d[clickData['points'][0]['x'], clickData['points'][0]['y'], int(vol_slice), :]
    fig = px.line(x=np.arange(len(tc)), y=tc)
    return fig


@app.callback(
    [Output('graph-mri', 'figure'),
    Output('current-slice', 'children')],
    Input('slice-slider', 'value'))
def update_slice(vol_slice):
    fig = px.imshow(mean_vol[:,:,vol_slice].T, binary_string=True, origin='lower')
    return [fig, vol_slice]


if __name__ == "__main__":
    app.run_server(debug=True)