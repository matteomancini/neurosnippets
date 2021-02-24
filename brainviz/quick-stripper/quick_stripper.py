import nibabel as nib
import numpy as np
import streamlit as st
import matplotlib.pyplot as plt
import os


def file_selector(folder_path='.'):
    filenames = [f for f in os.listdir(folder_path) if f.endswith(".nii") or f.endswith(".gz")]
    selected_filename = st.sidebar.selectbox('Select a file', filenames)
    if selected_filename is None:
        return None
    return os.path.join(folder_path, selected_filename)


def plot_zslice(vol, overlay, z):
    fig, ax = plt.subplots()
    plt.axis('off')
    zslice = vol[:, :, z]
    ax.imshow(zslice.T, origin='lower', cmap='gray')
    if os.path.exists(overlay):
        mask = nib.load(overlay)
        mask_data = mask.get_fdata()
        if mask_data.shape == vol.shape:
            zslice = mask_data[:, :, z]
            ax.imshow(zslice.T, origin='lower', alpha=0.5)
    return fig
    

st.sidebar.title('BET explorer')
filename = file_selector()
threshold = st.sidebar.slider('Fractional intensity threshold', 0.0, 1.0, 0.5)
overlay = 'brain_mask.nii.gz'

if filename is not None:
    img = nib.load(filename)
    img_data = img.get_fdata()

    if st.sidebar.button('Run BET'):
        st.sidebar.write(f'Running bet with f={threshold}...')
        st.spinner(text='In progress...')
        os.system(f'bet {filename} brain.nii.gz -m -f {threshold}')
        st.balloons()
        st.sidebar.write('...Done!')

    zlen = img_data.shape[2]
    z = st.slider('Slice', 0, zlen, int(zlen/2))
    fig = plot_zslice(img_data, overlay, z)
    plot = st.pyplot(fig)
