import nibabel as nib
import numpy as np
import streamlit as st
import matplotlib.pyplot as plt


@st.cache
def load(filename):
    img = nib.load(filename)
    img_data = img.get_fdata()
    mean_vol = np.mean(img_data, axis=3)
    return img_data, mean_vol


def plot_zslice(vol, coord_xy, z):
    fig, ax = plt.subplots()
    ax.imshow(vol[:, :, z].T, origin='lower', cmap='gray')
    ax.scatter([coord_xy[0]], [coord_xy[1]], facecolors='none', edgecolors='r')
    return fig


def plot_tc(vol_4d, coord):
    fig, ax = plt.subplots()
    ax.plot(np.arange(vol_4d.shape[3]), vol_4d[coord[0], coord[1], coord[2], :])
    return fig


filename = 'bold.nii.gz'
vol_4d, mean_vol = load(filename)
vol_size = mean_vol.shape

x = st.sidebar.slider('x', 0, vol_size[0], int(vol_size[0]/2))
y = st.sidebar.slider('y', 0, vol_size[1], int(vol_size[1]/2))
z = st.sidebar.slider('z', 0, vol_size[2], int(vol_size[2]/2))
fig1 = plot_zslice(mean_vol, [x, y], z)
fig2 = plot_tc(vol_4d, [x,y,z])

col1, col2 = st.beta_columns(2)
col1.pyplot(fig1)
col2.pyplot(fig2)