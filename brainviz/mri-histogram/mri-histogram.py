import dash
import dash_core_components as dcc
import dash_html_components as html
import nibabel as nib
import numpy as np
import plotly.express as px
from dash.dependencies import Input, Output, State
from scipy import ndimage
from skimage import draw


def path_to_indices(path):
    """From SVG path to numpy array of coordinates, each row being a (row, col) point
    """
    indices_str = [
        el.replace('M', '').replace('Z', '').split(',') for el in path.split('L')
    ]
    return np.floor(np.array(indices_str, dtype=float)).astype(np.int)


def path_to_mask(path, shape):
    """From SVG path to a boolean array where all pixels enclosed by the path
    are True, and the other pixels are False.
    """
    cols, rows = path_to_indices(path).T
    rr, cc = draw.polygon(rows, cols)
    mask = np.zeros(shape, dtype=np.bool)
    mask[rr, cc] = True
    mask = ndimage.binary_fill_holes(mask)
    return mask


# Loading the data and creating the figures
img = nib.load('T1map_cropped_reoriented.nii.gz')
data = img.dataobj
default_view = 2
default_slice = int(data.shape[default_view]/2)
view = np.take(data, default_slice, axis=default_view)
view = view.T
fig = px.imshow(view, binary_string=True, origin='lower')
fig.update_layout(dragmode='drawopenpath',
                  newshape=dict(opacity=0.8, line=dict(color='red', width=2)))
config = {
    'modeBarButtonsToAdd': [
        'drawopenpath',
        'drawclosedpath',
        'eraseshape'
    ]
}
fig_hist = px.histogram(data.get_unscaled().ravel())
fig_hist.update_layout(showlegend=False)

app = dash.Dash(__name__)

# Defining the layout of the dashboard
app.layout = html.Div([html.Div([
        html.Div(
            [dcc.Dropdown(id="plane-dropdown", options=[
                {'label': 'Axial', 'value': 2},
                {'label': 'Coronal', 'value': 1},
                {'label': 'Sagittal', 'value': 0}],
                value=2),
             dcc.Graph(id='graph-mri', figure=fig, config=config),
             dcc.Slider(
                id='slice-slider',
                min=0,
                max=data.shape[default_view] - 1,
                value=int(data.shape[default_view]/2),
                step=1)],
            style={'width': '60%', 'display': 'inline-block', 'padding': '0 0'},
        ),
        html.Div(
            [dcc.Graph(id='graph-histogram', figure=fig_hist)],
            style={'width': '40%', 'display': 'inline-block', 'padding': '0 0'},
        ), html.Div(id='test')
    ])
])


@app.callback(
    [Output('graph-mri', 'figure'),
    Output('slice-slider', 'max'),
    Output('slice-slider', 'value')],
    [Input('plane-dropdown', 'value'),
    Input('slice-slider', 'value')],
    prevent_initial_call=True)
def update_plane(plane, vol_slice):
    ctx = dash.callback_context
    if ctx.triggered[0]['prop_id'].split('.')[0]=='plane-dropdown':
        vol_slice = int(data.shape[plane]/2)
    view = np.take(data, vol_slice, axis=plane)
    view = view.T
    fig = px.imshow(view, binary_string=True, origin='lower')
    fig.update_layout(dragmode='drawopenpath',
                      newshape=dict(opacity=0.8, line=dict(color='red', width=2)))
    return [fig, data.shape[plane] - 1, vol_slice]


@app.callback(
    Output('graph-histogram', 'figure'),
    Input('graph-mri', 'relayoutData'),
    [State('plane-dropdown', 'value'),
    State('slice-slider', 'value')],
    prevent_initial_call=True)
def histo_from_annotation(relayout_data, current_plane, current_slice):
    if 'shapes' in relayout_data:
        last_shape = relayout_data['shapes'][-1]
        view = np.take(data, current_slice, axis=current_plane)
        view = view.T
        mask = path_to_mask(last_shape['path'], view.shape)
        fig = px.histogram(view[mask])
        fig.update_layout(showlegend=False)
        return fig
    else:
        return dash.no_update


if __name__ == "__main__":
    app.run_server(debug=True)