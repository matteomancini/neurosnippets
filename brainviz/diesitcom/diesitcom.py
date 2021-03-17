import os
import matplotlib.pyplot as plt
import pandas as pd
import streamlit as st
import SimpleITK as sitk


def dir_selector(folder_path='.'):
    dirnames = [d for d in os.listdir(folder_path) if os.path.isdir(os.path.join(folder_path, d))]
    selected_folder = st.sidebar.selectbox('Select a folder', dirnames)
    if selected_folder is None:
        return None
    return os.path.join(folder_path, selected_folder)


def plot_slice(vol, slice_ix):
    fig, ax = plt.subplots()
    plt.axis('off')
    selected_slice = vol[slice_ix, :, :]
    ax.imshow(selected_slice, origin='lower', cmap='gray')
    return fig
    

st.sidebar.title('DieSitCom')
dirname = dir_selector()

if dirname is not None:
    try:
        reader = sitk.ImageSeriesReader()
        dicom_names = reader.GetGDCMSeriesFileNames(dirname)
        reader.SetFileNames(dicom_names)
        reader.LoadPrivateTagsOn()
        reader.MetaDataDictionaryArrayUpdateOn()
        data = reader.Execute()
        img = sitk.GetArrayViewFromImage(data)
    
        n_slices = img.shape[0]
        slice_ix = st.sidebar.slider('Slice', 0, n_slices, int(n_slices/2))
        output = st.sidebar.radio('Output', ['Image', 'Metadata'], index=0)
        if output == 'Image':
            fig = plot_slice(img, slice_ix)
            plot = st.pyplot(fig)
        else:
            metadata = dict()
            for k in reader.GetMetaDataKeys(slice_ix):
                metadata[k] = reader.GetMetaData(slice_ix, k)
            df = pd.DataFrame.from_dict(metadata, orient='index', columns=['Value'])
            st.dataframe(df)
    except RuntimeError:
        st.text('This does not look like a DICOM folder!')
